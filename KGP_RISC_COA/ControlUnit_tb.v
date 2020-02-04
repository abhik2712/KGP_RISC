`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:49:16 11/04/2019
// Design Name:   controlUnit
// Module Name:   C:/Users/student/Desktop/KGP_RISC/ControlUnit/ControlUnit_tb.v
// Project Name:  ControlUnit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: controlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ControlUnit_tb;

	// Inputs
	reg [1:0] opcode;
	reg [3:0] func;
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] alu_control;
	wire branch;
	wire mem_read;
	wire mem_write;
	wire mem_to_reg;
	wire alu_src;
	wire reg_write;
	wire jump;

	// Instantiate the Unit Under Test (UUT)
	controlUnit uut (
		.opcode(opcode), 
		.func(func), 
		.clk(clk), 
		.rst(rst), 
		.alu_control(alu_control), 
		.branch(branch), 
		.mem_read(mem_read), 
		.mem_write(mem_write), 
		.mem_to_reg(mem_to_reg), 
		.alu_src(alu_src), 
		.reg_write(reg_write), 
		.jump(jump)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		func = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#10 rst = 1;
		#10 rst = 0;
		
		#10;
		opcode = 0;
		func = 0;
      
		#10;
		opcode = 0;
		func = 4;
		
		#10;
		opcode = 3;
		func = 0;
		
		#10;
		opcode = 4;
		func = 0;
		
		#10;
		opcode = 15;
		func = 0;
		// Add stimulus here

	end
	
	always begin
		#5 clk = ~clk;
	end  

      
endmodule

