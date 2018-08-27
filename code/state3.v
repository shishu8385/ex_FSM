`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/27 11:22:32
// Design Name: 
// Module Name: state3
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


module state3(
		input                      		clk_i,
		input                     		rst_n,
		input                       	A,
		output                   K1,
		output                     K2
    );
	reg [3:0]                       now_state;
	reg [3:0]                       next_state;
	
	parameter                  START = 4'b0001;
	parameter                  STOP  = 4'b0010;
	parameter                  CLEAR = 4'b0100;
	parameter                  IDLE  = 4'b1000;
	
	//Describe sequential state transition in the 1st sequential always block
	always @(posedge clk_i) 
		if(!rst_n)
			now_state <= IDLE;
		else 
			now_state <= next_state;
    //State transition conditions in the 2nd combinational always block
	always @(*) begin
		case(now_state)
			IDLE: begin
				if(!rst_n)
					next_state = IDLE;
				else if(A)
					next_state = START;
				else 	
					next_state = now_state;
			end
			STOP: begin
				if(!rst_n)
					next_state = IDLE;
				else if(A)
					next_state = CLEAR;
				else 	
					next_state = now_state;
			end
			START: begin
				if(!rst_n)
					next_state = IDLE;
				else if(!A)
					next_state = STOP;
				else 	
					next_state = now_state;
			end
			CLEAR: begin
				if(!rst_n || !A)
					next_state = IDLE;
				else 
					next_state = now_state;
			end
			default:
				next_state = IDLE;
		endcase
	end
	//Describe the FSM out in the 3rd sequential always block K1
/*	always @(*) begin
		if(!rst_n)
			{K2,K1} = {0,0};
		else
			case(now_state) //保持同步输出
				IDLE: 
					if(A)
						{K2,K1} = {0,0};
					else 
						{K2,K1} = {0,0};
				START:
					{K2,K1} = {0,0};
				STOP:
					if(!rst_n)
						{K2,K1} = {0,0};
					else if(A)
						{K2,K1} = {1,0};
				CLEAR:
					if(!rst_n || !A)
						{K2,K1} = {0,1};
				default:
					{K2,K1} = {0,0};
			endcase	
	end	*/
	assign K1 = (now_state== CLEAR && (!A || !rst_n))? 1 :0;
	assign K2 = (now_state== STOP  && A)? 1 :0;
	
endmodule
