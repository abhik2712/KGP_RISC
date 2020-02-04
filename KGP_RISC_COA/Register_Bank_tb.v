`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:44:54 10/23/2019
// Design Name:   Register_Bank
// Module Name:   C:/Users/student/Desktop/KGP_RISC/Instruction_fetch/Register_Bank_tb.v
// Project Name:  Instruction_fetch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Register_Bank
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Register_Bank_tb;

	// Inputs
	reg write_enable;
	reg clk;
	reg rst;
	reg [4:0] write_loc;
	reg [31:0] write_data;
	reg [4:0] read_rs;
	reg [4:0] read_rt;

	// Outputs
	wire [31:0] rs_data;
	wire [31:0] rt_data;

	// Instantiate the Unit Under Test (UUT)
	Register_Bank uut (
		.write_enable(write_enable), 
		.clk(clk), 
		.rst(rst), 
		.write_loc(write_loc), 
		.write_data(write_data), 
		.read_rs(read_rs), 
		.rs_data(rs_data), 
		.read_rt(read_rt), 
		.rt_data(rt_data)
	);

	always begin
		#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		write_enable = 0;
		clk = 0;
		rst = 0;
		write_loc = 0;
		write_data = 0;
		read_rs = 0;
		read_rt = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 1;
		
		#10;
		rst = 0;
		
		#10;
		write_enable = 0;
		write_data = 143434;
		read_rs = 28;
		read_rt = 30;
		
		#10;
		write_enable = 1;
		write_data = 143434;
		read_rs = 28;
		read_rt = 30;
		
		#10
		write_enable = 1;
		write_data = 143434;
		read_rs = 30;
		read_rt = 28;
		// Add stimulus here

	end
    
endmodule
