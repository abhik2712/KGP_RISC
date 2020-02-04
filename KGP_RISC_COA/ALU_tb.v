`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:17:17 10/30/2019
// Design Name:   alu
// Module Name:   C:/Users/student/Desktop/KGP_RISC/ALU/ALU_tb.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg [3:0] opcode;

	// Outputs
	wire [31:0] result;
	wire zero_flag;
	wire carry_flag;
	wire sign_flag;
	wire overflow_flag;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.a(a), 
		.b(b), 
		.opcode(opcode), 
		.result(result), 
		.zero_flag(zero_flag), 
		.carry_flag(carry_flag), 
		.sign_flag(sign_flag), 
		.overflow_flag(overflow_flag)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		opcode = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		#20;
		opcode = 4'b0010;
		a = 10;
		b = 20;
		
		#20;
		opcode = 4'b0011;
		a = 7;
		b = -1;
		
		#20;
		opcode = 4'b0000;
		a = 10;
		b = -20;
		
		#20;
		opcode = 4'b0010;
		a = 7;
		b = -1;
		
		#20;
		opcode = 0;
		a = -10;
		b = -20;
		
		#20;
		opcode = 4'b1111;
		a = 32'h7fffffff;
		b = 32'h7fffffff;
		
		#20;
		opcode = 4'b0110;
		a = 32'hffffffff;
		b = 32'hffffffff;
	
		#20;
		opcode = 0;
		a = 32'h00a11a78;
		b = 32'h03aeff36;
	end
      
endmodule

