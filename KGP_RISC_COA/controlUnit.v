`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:27 11/04/2019 
// Design Name: 
// Module Name:    controlUnit 
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
module controlUnit(input wire[1:0] opcode, input wire [3:0] func,
		input wire clk, input wire rst,
		output reg [3:0] alu_control,
		output reg branch, mem_read, mem_write, mem_to_reg, alu_src, reg_write, jump
	);

	always@(opcode or func or rst)
	begin
		if(rst) // setting all flags to zero
		begin
			alu_control <= 0;
			jump <= 0;
			branch <= 0;
			mem_read <= 0;
			mem_write <= 0;
			mem_to_reg <= 0;
			alu_src <= 0;
			reg_write <= 0;
		end
		else
		begin
			case(opcode)
				2'd0:				// R-type instruction
					begin
						case(func)
							4'd0:						// Add
								begin
									alu_control <= 0;
									jump <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
							4'd1: 						// Complement
								begin
									alu_control <= 1;
									branch <= 0;
									jump <= 0;
									mem_read <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
							4'd2: 						// Multiply Unsigned
								begin
									alu_control <= 2;
									branch <= 0;
									jump <= 0;
									mem_read <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
							4'd3: 						// Multiply Signed
								begin
									alu_control <= 3;
									branch <= 0;
									jump <= 0;
									mem_read <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
							4'd4: 						// Add Immediate
								begin
									alu_control <= 4;
									branch <= 0;
									jump <= 0;
									mem_read <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
							4'd5: 						// Complement Immediate
								begin
									alu_control <= 5;
									branch <= 0;
									jump <= 0;
									mem_read <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
							4'd6:  						// AND
								begin
									alu_control <= 6;
									branch <= 0;
									jump <= 0;
									mem_read <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
							4'd7:  						// XOR
								begin
									alu_control <= 7;
									branch <= 0;
									mem_read <= 0;
									jump <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 1;
								end
								
								
							4'd10:  						// Shift Left Logical
								begin
									alu_control <= 10;
									branch <= 0;
									mem_read <= 0;
									jump <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 1;
									reg_write <= 1;
								end
							4'd11: 						// Shift Right logical
								begin
									alu_control <= 11;
									branch <= 0;
									mem_read <= 0;
									jump <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 1;
									reg_write <= 1;
								end
							
							4'd12: 						// Shift left logical variable
								begin
									alu_control <= 12;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 0;
									mem_to_reg <= 0;
									alu_src <= 1;
									reg_write <= 1;
								end
								
							4'd13: 						// Shift Right logical variable
								begin
									alu_control <= 13;
									branch <= 0;
									mem_read <= 0;
									jump <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 1;
									reg_write <= 1;
								end
								
							4'd14: 						// Shift Right arithmetic
								begin
									alu_control <= 14;
									branch <= 0;
									mem_read <= 0;
									jump <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 1;
									reg_write <= 1;
								end
								
							4'd15: 						// Shift Right arithmetic variable
								begin
									alu_control <= 15;
									branch <= 0;
									mem_read <= 0;
									jump <= 0;
									mem_write <= 0;
									mem_to_reg <= 0;
									alu_src <= 1;
									reg_write <= 1;
								end
								
							default: 
								begin
								end
						endcase
					end
					
					
				2'b11:
					begin
							case(func)
							4'd0:            //Unconditional branch
								begin
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
							
							4'd1:
								begin         //Call
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
								
							4'd2:
								begin         //Return
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
							
							4'd3:
								begin         //Branch Register
									alu_control <= 0;
									branch <= 1;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 0;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
							
							4'd4:
								begin         //Branch on zero
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
							
							4'd5:
								begin         //Branch on not zero
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
								
							4'd6:
								begin         //Branch on Sign
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
								
							4'd7:
								begin         //Branch on Not Sign
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
								
							4'd9:
								begin         //Branch on Carry
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
								
							4'd10:
								begin         //Branch on No Carry
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
								
							4'd11:
								begin         //Branch on Overflow
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
							
							4'd12:
								begin         //Branch on No Overflow
									alu_control <= 0;
									branch <= 0;
									mem_read <= 0;
									mem_write <= 0;
									jump <= 1;
									mem_to_reg <= 0;
									alu_src <= 0;
									reg_write <= 0;
								end
								
							default: 
								begin
								end
					endcase
				end
			endcase
		end
	end
endmodule
