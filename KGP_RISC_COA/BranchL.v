`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:32 10/30/2019 
// Design Name: 
// Module Name:    BranchL 
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
module BranchL(    input [1:0] opcode,
    input [3:0] fcode,
	 input [15:0] label,
    input carryFlag,
    input zFlag,
    input overflowFlag,
    input signFlag,
	 input [9:0] PC,
    output reg [9:0] exNPC,
	 output reg PCSrc,
	 output reg [31:0] ra
    );
	
initial begin
	exNPC<=0;
	PCSrc<=0;
	ra<=0;
	end
always @(opcode or fcode or label or carryFlag or zFlag or overflowFlag or signFlag)
	begin
	ra<=0;    //ra is 0 by default
		if(opcode==2'b11)     //if we are branching
			begin
				if(fcode==4'b0)
							begin       //b
								exNPC<=label[9:0];
								PCSrc<=1;
							end
				else if(fcode==4'b0001)
						  begin		//call
								exNPC<=label[9:0];
								PCSrc<=1;
								ra<=PC;   //Store the PC 
							end
				else if(fcode==4'b0011)
					begin            //br
						exNPC<=label[9:0];
						PCSrc<=1;
					end
				else if(fcode==4'b0100)
						  begin       //bz
								if(zFlag==1) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b0101)
						  begin		//bnz
								if(zFlag==0) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b0110)
						  begin		//bs
								if(signFlag==1) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b0111)
						  begin	//bns
								if(signFlag==0) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b1001)
						  begin		//bcy
								if(carryFlag==1) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b1010)
						  begin		//bncy
								if(carryFlag==0) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b1011)
						  begin	//bv
								if(overflowFlag==1) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b1100)
						  begin	//bnv
								if(overflowFlag==0) 
									begin
										exNPC<=label[9:0];
										PCSrc<=1;
									end
								else 
									begin
									PCSrc<=0;
									exNPC<=0;
									end
							end
				else if(fcode==4'b0010)
						  begin //return
								exNPC<=ra[9:0];
								PCSrc<=1;
							end
				else
							begin //default case
								PCSrc<=0;
								exNPC<=0;
							end
			end		
		end
endmodule