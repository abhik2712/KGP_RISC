`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:13 10/16/2019
// Design Name:   Inst_decode
// Module Name:   C:/Users/student/Desktop/KGP_RISC/Instruction_fetch/Inst_decode_tb.v
// Project Name:  Instruction_fetch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Inst_decode
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Inst_decode_tb;

	// Inputs
	reg [31:0] inst;

	// Outputs
	wire [1:0] opcode;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] shamt;
	wire [3:0] func;
	wire [15:0] offset;
	wire MemWrite;

	// Instantiate the Unit Under Test (UUT)
	Inst_decode uut (
		.inst(inst), 
		.opcode(opcode), 
		.rs(rs), 
		.rt(rt), 
		.shamt(shamt), 
		.func(func), 
		.offset(offset), 
		.MemWrite(MemWrite)
	);

	initial begin
		inst = 32'b0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		inst=32'b00000100110000101000000111100101;
		
		#20
		inst=32'b00100100110000101000000111100101;
		
		#20
		inst=32'b01000100110000101000000111100101;
		
		#20
		inst=32'b01100100110000101000000111100101;
		
		#20
		inst=32'b10000100110000101000000111100101;
		
		$finish;

	end
      
endmodule

