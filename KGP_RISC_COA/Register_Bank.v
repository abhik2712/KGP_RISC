`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:57 10/23/2019 
// Design Name: 
// Module Name:    Register_Bank 
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
module Register_Bank(
		input write_enable,
		input clk,
		input rst,
		input [4:0] write_loc,
		input [31:0] write_data,
		input [4:0] read_rs,
		output reg [31:0] rs_data,
		input [4:0] read_rt,
		output reg [31:0] rt_data
    );
	 
	 reg [31:0] reg_0 [7:0];
	 reg [31:0] reg_8 [7:0];	 
	 reg [31:0] reg_16 [7:0];
	 reg [31:0] reg_24 [7:0];

	 
	 always @ (posedge clk or posedge rst)
	 begin
				if(rst)
				begin
						//Setting all registers to zero
						reg_0[0] <= 32'b0;  
						reg_0[1] <= 32'b0;
						reg_0[2] <= 32'b0;
						reg_0[3] <= 32'b0;
						reg_0[4] <= 32'b0;
						reg_0[5] <= 32'b0;
						reg_0[6] <= 32'b0;
						reg_0[7] <= 32'b0;
						
						reg_8[0] <= 32'b0;  
						reg_8[1] <= 32'b0;
						reg_8[2] <= 32'b0;
						reg_8[3] <= 32'b0;
						reg_8[4] <= 32'b0;
						reg_8[5] <= 32'b0;
						reg_8[6] <= 32'b0;
						reg_8[7] <= 32'b0;
						
						reg_16[0] <= 32'b0;  
						reg_16[1] <= 32'b0;
						reg_16[2] <= 32'b0;
						reg_16[3] <= 32'b0;
						reg_16[4] <= 32'b0;
						reg_16[5] <= 32'b0;
						reg_16[6] <= 32'b0;
						reg_16[7] <= 32'b0;
						
						reg_24[0] <= 32'b0;  
						reg_24[1] <= 32'b0;
						reg_24[2] <= 32'b0;
						reg_24[3] <= 32'b0;
						reg_24[4] <= 32'b0;
						reg_24[5] <= 32'b0;
						reg_24[6] <= 32'b0;
						reg_24[7] <= 32'b0;
						
				end
	 
				else
				begin
						if(write_enable)    // write_enable == 1
						begin
								if(write_loc <= 3'b111)
								begin
										reg_0[ write_loc[2:0] ] <= write_data;
								end
								
								else if(write_loc <= 4'b1111)
								begin
										reg_8[ write_loc[2:0] ] <= write_data;
								end
								
								else if(write_loc <= 5'b10111)
								begin 
										reg_16[ write_loc[2:0] ] <= write_data;
								end
								
								else
								begin
										reg_24[ write_loc[2:0] ] <= write_data;
								end
						end
				end
	 end
	 
	 //////assign rs_data = regArray[read_rs];
	 
	 always @(*)
	 begin
			if(read_rs[3:0] <= 3'b111)
			begin
					rs_data <= reg_0[ read_rs[2:0] ];
			end
			
			else if(read_rs <= 4'b1111)
			begin
					rs_data <= reg_8[ read_rs[2:0] ];
			end
			
			else if(read_rs <= 5'b10111)
			begin 
					rs_data <= reg_16[ read_rs[2:0] ];
			end
			
			else
			begin
					rs_data <= reg_24[ read_rs[2:0] ];
			end
			
			//////assign rt_data = regArray[read_rt];
	
			if(read_rt <= 3'b111)
			begin
					rt_data <= reg_0[ read_rt[2:0] ];
			end
			
			else if(read_rt <= 4'b1111)
			begin
					rt_data <= reg_8[ read_rt[2:0] ];
			end
			
			else if(read_rt <= 5'b10111)
			begin 
					rt_data <= reg_16[ read_rt[2:0] ];
			end
			
			else
			begin
					rt_data <= reg_24[ read_rt[2:0] ];
			end
	 end

//////////We are using 8x1 mux(not exactly ie. A = reg[location], location can be 0 to 7) for selecting one register out of 0-7 or 8-15 or 16-23 or 24-31
//////////Then with if/else statement we are selecting the specific range as mentioned above
 
endmodule


