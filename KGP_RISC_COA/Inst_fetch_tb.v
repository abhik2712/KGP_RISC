
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
/*
*/
////////////////////////////////////////////////////////////////////////////////

module Instruction_Fetch_TB;

	// Inputs
	reg [31:0] pc;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] instruction;

	// Instantiate the Unit Under Test (UUT)
	InstructionFetch uut (
		.pc(pc), 
		.instruction(instruction), 
		.clk(clk), 
		.rst(rst)
	);

	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		pc = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 1;
		#10 rst = 0;
		#10 pc = 1;
		#10 pc = 2;
		#10 pc = 3;
		#10 pc = 4;
	end
	
      
endmodule