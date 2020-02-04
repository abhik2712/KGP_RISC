`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:31:00 10/30/2019
// Design Name:   BranchL
// Module Name:   C:/Users/student/Desktop/KGP_RISC/Branch/BranchL_tb.v
// Project Name:  Branch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BranchL
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BranchL_tb;

	// Inputs
	reg [1:0] opcode;
	reg [3:0] fcode;
	reg [15:0] label;
	reg carryFlag;
	reg zFlag;
	reg overflowFlag;
	reg signFlag;
	reg [9:0] PC;

	// Outputs
	wire [9:0] exNPC;
	wire PCSrc;
	wire [31:0] ra;

	// Instantiate the Unit Under Test (UUT)
	BranchL uut (
		.opcode(opcode), 
		.fcode(fcode), 
		.label(label), 
		.carryFlag(carryFlag), 
		.zFlag(zFlag), 
		.overflowFlag(overflowFlag), 
		.signFlag(signFlag), 
		.PC(PC), 
		.exNPC(exNPC), 
		.PCSrc(PCSrc), 
		.ra(ra)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		fcode = 0;
		label = 0;
		carryFlag = 0;
		zFlag = 0;
		overflowFlag = 0;
		signFlag = 0;
		PC = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#20
		opcode = 2'b11;
		fcode = 4'b1001;
		label = 15'd150;
		carryFlag = 0;
		zFlag = 0;
		overflowFlag = 1;
		signFlag = 1;
		PC = 10'd120;
		
		#20
		opcode = 2'b11;
		fcode = 4'b0000;
		label = 16'd150;
		carryFlag = 0;
		zFlag = 0;
		overflowFlag = 1;
		signFlag = 0;
		PC = 0;
		
		
		
		#20
		opcode = 2'b11;
		fcode = 4'b1010;
		label = 16'd150;
		carryFlag = 0;
		zFlag = 0;
		overflowFlag = 1;
		signFlag = 1;
		PC = 10'd120;
		
		$finish;
	end
      
endmodule

