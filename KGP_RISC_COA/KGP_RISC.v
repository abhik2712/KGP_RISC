`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:25 11/04/2019 
// Design Name: 
// Module Name:    KGP_RISC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module KGP_RISC(
    	input clk,
		input reset,
		output [31:0] rout
    );

wire PCSrcIn,PCSRc;        //to decide if we need to choose external NPC or incremented PC
wire [7:0] exNPCIn,exNPC;  //external NPC (coming from branch statements)
wire [7:0] npc,pc,npc_mux;  //Parts of instruction fetch

//Various Parameters of the instruction decoder
wire [2:0] opcode;
wire [4:0] rsAddr,rtAddr,shamt,wrAddr;
wire [7:0] if_id_NPC;
wire [31:0] if_id_instr; 
wire [3:0] fcode;
wire [21:0] imm;
wire [24:0] label;
wire clk1,clk2;

//RegWrite: To decide if we need to write in register
wire RegWrite;

//Data corresponding to rsAddr, rtAddr
wire [31:0] rsData,rtData,wrData;

//dout: output of Instuction_Memory, ra: return address
wire [31:0] dout,ra;

//To decide if we need to write in memory
wire MemWrite;

//Various flags
wire carryFlag,overflowFlag,zFlag,signFlag;

//ALU parameters
wire [31:0] ALUOut,ALUExtOut,inp1,inp2;

//MemOut: Data loaded, MemAddr: Address in Memory
wire [31:0] MemOut;
wire [31:0] MemAddrFull;
wire [9:0] MemAddr;

//
wire [31:0] rout2;

clockDivide CD(clk,clk1,clk2);

/*//Instruction fetch module: Combination of 5 top modules
MUX_2x1 M(npc,exNPC,PCSrc,npc_mux);    //Choose out of npc and external npc
PC P1(clk1,npc_mux,pc);            //make it pc at clk
Instruction_Memory IMEM(           //extract instruction
  .clka(clk2), 
  .addra(pc), 
  .douta(dout)); 
IF_ID if_id(reset,clk1,dout,npc,if_id_instr,if_id_NPC);   //make it output at clk
PC_incrementor I(pc,npc);          //increment
*/
//InstrFetch IF(clk1,clk2,reset,PCSrc,exNPC,if_id_instr,if_id_NPC);
//assign rout = if_id_instr;
InstrFetch IF(clk1,clk2,reset,PCSrc,exNPC,if_id_instr,if_id_NPC);


//Instruction Decoder, input as instruction, output as various parameters of instruction
//assign rout = {opcode[2:0] ,rsAddr[4:0] ,rtAddr[4:0],shamt[4:0],fcode[3:0],imm[8:0],MemWrite};
InstDecode I_D(
	 .inst(if_id_instr),
	 .opcode(opcode),
	 .rsAddr(rsAddr),
	 .rtAddr(rtAddr),
	 .shamt(shamt),
	 .func(fcode),
	 .imm(imm),
	 .label(label),
	 .MemWrite(MemWrite)
	 );

//WriteAddress decides if we need to write something
//if yes, what and where based on opcode and fcode
//there are multiple options to write like ALUOut (Arithmetic and shift op)
//ra (call a function case) and MemOut(load case)
//assign rout = {opcode,fcode,rsAddr,ALUOut[5:0],wrAddr[4:0],wrData[7:0],RegWrite};
writeAddress wa (
    .opcode(opcode), 
    .fcode(fcode), 
    .rsAddr(rsAddr),
	 .rtAddr(rtAddr),
    .ALUOut(ALUOut), 
    .ra(ra), 
	 .MemOut(MemOut),
    .wrAddr(wrAddr), 
    .RegWrite(RegWrite), 
    .wrData(wrData)
    );

//Register File 32 x 32, can read from two registers and write into one register at a time
assign rout = rout2;
regBank RB(
	 .reset(reset),
    .clk(clk1), 
    .RegWrite(RegWrite), 
    .wrAddr(wrAddr), 
    .wrData(wrData), 
    .rdAddrA(rsAddr), 
    .rdDataA(rsData), 
    .rdAddrB(rtAddr), 
    .rdDataB(rtData),
	 .rout(rout2)
    );

//Get the Address from Memory where we need to load/store
//assign rout = MemAddr;
assign MemAddrFull=rsData+imm;	 
assign MemAddr=MemAddrFull[7:0];

//Assign inputs assigns values to the two inputs of the ALU based on the opcode and fcode
//assign rout ={opcode,fcode,rsData[4:0],rtData[4:0],imm[14:0]};
//assign rout = {inp1[10:0],inp2[10:0],imm[9:0]};
assignInputs a_i (
    .rs(rsData), 
    .rt(rtData), 
    .shamt(shamt), 
    .imm(imm), 
    .opcode(opcode), 
    .fcode(fcode), 
    .inp1(inp1), 
    .inp2(inp2)
    ); 

//given two inputs, opcode and fcode, ALU gives the output and updates flags	 
//assign rout = {inp1[4:0],inp2[4:0],ALUOut[21:0]};
ALU alu(
    .inp1(inp1), 
    .inp2(inp2), 
    .opcode(opcode), 
    .fcode(fcode), 
    .out(ALUOut),
	 .ext_out(ALUExtOut),
    .carryFlag(carryFlag), 
    .zFlag(zFlag), 
    .signFlag(signFlag), 
    .overflowFlag(overflowFlag)
    );

//given the opcode, fcode, labels and flags, branch gives the new exNPC where we need to jump and updates PCSrc
branch b (
    .opcode(opcode), 
    .fcode(fcode), 
    .label(label), 
    .carryFlag(carryFlag), 
    .zFlag(zFlag), 
    .overflowFlag(overflowFlag), 
    .signFlag(signFlag), 
    .PC(if_id_NPC), 
    .exNPC(exNPC), 
    .PCSrc(PCSrc), 
    .ra(ra)
    );
	 

//Data Block RAM 
blk_mem_gen_v7_3b blk_mem (
  .clka(clk2), 
  .wea(MemWrite), 
  .addra(MemAddr),
  .dina(rtData),
  .douta(MemOut) 
);

endmodule
