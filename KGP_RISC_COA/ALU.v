`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:13 10/28/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(input wire [31:0] a, input wire [31:0] b, input wire [3:0] opcode, output reg [31:0] result,output reg zero_flag,
				output reg carry_flag, output reg sign_flag, output reg overflow_flag
    );
	 reg signed [31:0] multiplicand;
	 reg signed [31:0] multiplier;
	 reg signed [31:0] product_high;
	 reg signed [31:0] product_low;
	 
	 wire [31:0] rst, produ,prods;
	 wire cst;
	 
	 wire [31:0] left_shifted;
	 wire [31:0] right_shifted;
	 
	 
	 wire [31:0] input1;
	 wire [31:0] input2;
	 
	 
	 assign input1 = a;
	 assign input2 = b;
	 Hibrid_adder A(.a(input1), .b(input2), .sum(rst), .cout(cst));
	 
	 array_multiplier M(.a(input1), .b(input2), .y(produ));
	 
	 wire [31:0] input11;
	 wire [31:0] input22;
	 checkBit C(.a(a),.y(input11));
	 checkBit D(.a(b),.y(input22));
	 array_multiplier N(.a(input11), .b(input22), .y(prods));
	  

		always @(*)
		begin
			carry_flag <= 0;// Setting all flags to zero initially
			zero_flag <= 0;
			sign_flag <= 0;
			overflow_flag <= 0;
			
			case(opcode)
				//ARITHMETIC
				4'b0000:
					begin
						result <= rst;
						carry_flag <= cst; //Addition, there is a chance of generating carry
						zero_flag <= (result == 32'd0)?1:0;// If result is zero, this is set to zero.
						sign_flag <= result[31]; // the sign flag is the sign bit of the result
						overflow_flag <= carry_flag^(result[31]^(a[31]^b[31])); // the overflow flag
					end

				4'b0001:
					begin
						result <= ~b+1;//2's Compliment
						zero_flag <= (result == 32'd0)?1:0;// If result is zero, this is set to zero.
						sign_flag <= result[31]; // the sign flag is the sign bit of the result
						overflow_flag <= carry_flag^(result[31]^(a[31]^b[31])); // the overflow flag
					end

				
				4'b0010:
					begin
						result <= produ;//Unsigned Multiplication
						zero_flag <= (result == 32'd0)?1:0;// If result is zero, this is set to zero.
						sign_flag <= result[31]; // the sign flag is the sign bit of the result
						overflow_flag <= carry_flag^(result[31]^(a[31]^b[31])); // the overflow flag
					end
					
				4'b0011: 
					begin
						 if(a[31]!=b[31])
						 begin
								result <= ~prods + 1;
								sign_flag <= result[31];
						 end
						 else
						 begin
								result <= prods;
								sign_flag <= result[31]; 
						 end
						 zero_flag <= (result == 32'd0)?1:0;// If result is zero, this is set to zero.
						 overflow_flag <= carry_flag^(result[31]^(a[31]^b[31])); // the overflow flag
					end
							 
				4'b0100:
					begin
						result <= rst;
						carry_flag <= cst; //Addition, there is a chance of generating carry
						zero_flag <= (result == 32'd0)?1:0;// If result is zero, this is set to zero.
						sign_flag <= result[31]; // the sign flag is the sign bit of the result
						overflow_flag <= carry_flag^(result[31]^(a[31]^b[31])); // the overflow flag
					end

				4'b0101:
					begin
						result <= ~b+1;//2's Compliment
						zero_flag <= (result == 32'd0)?1:0;// If result is zero, this is set to zero.
						sign_flag <= result[31]; // the sign flag is the sign bit of the result
						overflow_flag <= carry_flag^(result[31]^(a[31]^b[31])); // the overflow flag
					end
				//Immidiate will be same as the selection of registers is done in another file
				
				
				//LOGIC
				4'b0110: result <= a&b;//And operation
				4'b0111: result <= a^b;//XOR operation
				
				
				//SHIFT OPERATION
				4'b1010: result <= a<<b;//Left shift logical
				4'b1011: result <= a>>b;//Right shift logical
				
				4'b1100: result <= a<<b;//Left shift logical variable
				4'b1101: result <= a>>b;//Right shift logical variable

				4'b1110: result <= a<<<b;//Left shift logical arithmetic
				4'b1111: result <= a>>>b;//Right shift logical arithmetic

				
				default:
					begin
							result <= 32'd0; // Default does nothing
							zero_flag <= 0;
							sign_flag <= 0;
							overflow_flag <= 0;
							carry_flag <= 0;
					end
			endcase
	end

endmodule


module Hibrid_adder( 
		input [31:0] a,
		input [31:0] b,
		output [31:0] sum,
		output cout
    );
	 
	 wire cin = 0;
	 wire [6:0] c;
	 
	 
	 fourBitAdder Add1(.a(a[3:0]), .b(b[3:0]), .cin(cin) ,.sum(sum[3:0]), .cout(c[0]));
	 fourBitAdder Add2(.a(a[7:4]), .b(b[7:4]), .cin(c[0]) ,.sum(sum[7:4]), .cout(c[1]));
	 
	 fourBitAdder Add3(.a(a[11:8]), .b(b[11:8]), .cin(c[1]) ,.sum(sum[11:8]), .cout(c[2]));
	 fourBitAdder Add4(.a(a[15:12]), .b(b[15:12]), .cin(c[2]) ,.sum(sum[15:12]), .cout(c[3]));
	 
	 fourBitAdder Add5(.a(a[19:16]), .b(b[19:16]), .cin(c[3]) ,.sum(sum[19:16]), .cout(c[4]));
	 fourBitAdder Add6(.a(a[23:20]), .b(b[23:20]), .cin(c[4]) ,.sum(sum[23:20]), .cout(c[5]));
	 
	 fourBitAdder Add7(.a(a[27:24]), .b(b[27:24]), .cin(c[5]) ,.sum(sum[27:24]), .cout(c[6]));
	 fourBitAdder Add8(.a(a[31:28]), .b(b[31:28]), .cin(c[6]) ,.sum(sum[31:28]), .cout(cout));

endmodule



module fourBitAdder(input [3:0] a, input [3:0] b, input cin, output [3:0] sum, output cout);
	 wire [3:0] G,P,C;
	 assign G = a&b;
	 assign P = a^b;
	 assign C[0] = cin;
	 assign C[1] = G[0] + (P[0]&C[0]);
	 assign C[2] = G[1] + (P[1]&G[0]) + (P[1]&P[0]&cin);
	 assign C[3] = G[2] + (P[2]&G[1]) + (P[2]&P[1]&G[0]) +  (P[2]&P[1]&P[0]&cin);
	 assign cout = G[3]+ (P[3]&G[2]) + (P[3]&P[2]&G[1]) +  (P[3]&P[2]&P[1]&G[0]) + (P[3]&P[2]&P[1]&P[0]&cin);	 
	 assign sum = {cout,P^C};
endmodule

module array_multiplier(a, b, y);

		parameter width = 32;
		input [width-1:0] a, b;
		output [2*width-1:0] y;

		wire [width*width-1:0] partials;

		genvar i;
		assign partials[width-1 : 0] = a[0] ? b : 0;
		generate for (i = 1; i < width; i = i+1) 
		begin:gen
			 assign partials[width*(i+1)-1 : width*i] = (a[i] ? b << i : 0) + partials[width*i-1 : width*(i-1)];
		end endgenerate

		assign y = partials[width*width-1 : width*(width-1)];

endmodule

module checkBit(a, y);
	
		input [31:0] a;
		output reg [31:0] y;
		
		always @(*)
		begin
			if(a[31] == 1)
			begin
				y <= ~a + 1;
			end
			else
			begin
				y <= a;
			end
		end

endmodule

