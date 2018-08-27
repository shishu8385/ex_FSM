`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/27 13:07:20
// Design Name: 
// Module Name: tb_ex_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ex_fsm(

    );
		reg                      		clk_i;
		reg                     		rst_n;
		reg                       		A;
		wire                   			K1;
		wire                  			K2;
	
	state3 state3_instant(
		.clk_i (clk_i)  ,
		.rst_n (rst_n)  ,
		.A     (A)    ,
		.K1    (K1)   ,
		.K2    (K2) 
    );
	
	localparam    CLK_P  = 1;
	always # CLK_P  clk_i = ~ clk_i;
	
	initial begin
		clk_i =0;
		rst_n =0;
		#10;
		rst_n=1;
		#50
		A = 1;
		#2
		A =0;
		#2
		A = 1;
		#4;
		A= 0;
	end	
	
endmodule
