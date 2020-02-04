`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:57 10/23/2019 
// Design Name: 
// Module Name:    InstrFetch 
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
module InstrFetch(
	input clk1,
	input clk2,
	input rst,
	input PC_select,
	input [7:0] Ex_NPC,
	output [31:0] instr,
	output [7:0] NPC
    );
	 
	wire [7:0] npc,pc,npc_mux;
	wire [31:0] dout;

	MUX_2x1 M(npc,Ex_NPC,PC_select,npc_mux);

	PC P1(clk1,npc_mux,pc); 
	
	blk_mem_gen_v7_3 blk_ram(.clka(clk2),.addra(pc),.douta(dout));
	
	IF_ID if_id(reset,clk1,dout,npc,instr,NPC);
	
	PC_incrementor I(pc,npc);
endmodule
