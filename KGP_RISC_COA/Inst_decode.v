`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:08 10/16/2019 
// Design Name: 
// Module Name:    Inst_decode 
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
module Inst_decode(input [31:0] inst,
	output reg [1:0] opcode, output reg [4:0] rs, output reg [4:0] rt, output reg [4:0] shamt, output reg [3:0] func, output reg [15:0] offset, output reg MemWrite
    );
	 
always @(*)
	begin
		opcode <= inst[31:30];
		
		if(opcode == 2'b00)		//Arithmetic operation, Logic and Shift
			begin
				rs <= inst[29:25];
				func <= inst[19:16];
				
				if(func[2:1] == 2'b10)    //Offset
					offset <= inst[15:0];
				else
					offset <= 16'b0;
					
				if(func[3] == 1)          // Shift vs rt
					begin
						shamt <= inst[24:20];
						rt <= 5'b0;
					end
				else
					begin
						shamt <= 5'b0;
						rt <= inst[24:20];
					end
					
			end
		
		
		else if(opcode == 2'b01)		// load word
			begin
				rs <= inst[29:25];
				rt <= inst[24:20];
				shamt <= 5'b0;
				func <= inst[19:16];
				offset <= inst[15:0];
			end
			
			
		else if(opcode == 2'b10)		// store word
			begin
				rs <= inst[29:25];
				rt <= inst[24:20];
				shamt <= 5'b0;
				func <= inst[19:16];
				offset <= inst[15:0];
			end
			
			
		else if(opcode == 2'b11)		// branch
			begin
				func <= inst[19:16];
				
				if(func[3]==1)           // branch with 2 register compare jump
					begin
						rs <= inst[29:25];
						rt <= inst[24:20];
						shamt <= 5'b0;
						offset <= inst[15:0];
					end
				
				else 
				begin
					if(func[3:1] == 3'b0)     // Call and Unconditional jump
						begin
							rs <= 5'b0;
							rt <= 5'b0;
							shamt <= 5'b0;
							offset <= inst[15:0];
						end
						
					else if(func[3:1] == 3'b001)      // Return jump
						begin
							rs <= 5'b0;
							rt <= 5'b0;
							shamt <= 5'b0;
							offset <= 16'b0;
						end
						
					else                         // Sign check and value(equal to 0) check jump
					begin
						rs <= inst[29:25];
						rt <= 5'b0;
						shamt <= 5'b0;
						offset <= inst[15:0];
					end
				end
				
			end
		
	end
	
	
always @(*)                 //Assign MemWrite
	begin
		if(opcode==3'd2 & func==4'd1)   //only in case of store word make it 1
			begin
			MemWrite<=1;
			end
		else
			MemWrite<=0;
	end
endmodule

