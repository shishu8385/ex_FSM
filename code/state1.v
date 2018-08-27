`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/27 10:40:01
// Design Name: Kevin Zhang
// Module Name: state1
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


module state1(
		input                      		clk_i,
		input                     		rst_n,
		input                       	A,
		output   reg                    K1,
		output   reg                    K2
    );
	//  onehot
	parameter                  START = 4'b0001;
	parameter                  STOP  = 4'b0010;
	parameter                  CLEAR = 4'b0100;
	parameter                  IDLE  = 4'b1000;
	
    reg [3:0]                  state;
	
	//1-paragraph method to describe FSM
	always @(posedge clk_i) begin
		if(!rst_n) begin
			state <= IDLE;
			{K1,K2} <= {0,0};
		end
		else begin
			case(state)
				IDLE: begin
					if(!rst_n) begin
						state <= IDLE;
						{K1,K2} <= {0,0};
					end
					else if(A) begin
						state <= START;
						{K1,K2} <= {0,0};
					end
				end
				START: begin
					if(!rst_n) begin
						state <= IDLE;
						{K1,K2} <= {0,0};
					end
					else if(!A) begin
						state <= STOP;
						{K1,K2} <= {0,0};
					end
				end
				STOP: begin
					if(!rst_n) begin
						state <= IDLE;
						{K1,K2} <= {0,0};
					end
					else if(A) begin
						state <= CLEAR;
						{K1,K2} <= {0,1};
					end
				end
				CLEAR: begin
					if(!rst_n || !A) begin
						state <= IDLE;
						{K1,K2} <= {0,1};
					end
				end
				default: begin
					state <= IDLE;
					{K1,K2} <= {0,0};
				end
			endcase
		end
	end
endmodule
