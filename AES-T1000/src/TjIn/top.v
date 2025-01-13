`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:35 03/08/2013 
// Design Name: 
// Module Name:    top 
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
module top(clk, rst, state_change, key_change, out);
    input clk, rst, state_change, key_change;
	output out;
    reg  [127:0] state, key;
	wire [127:0] aes_out;

	aes_128 AES (clk, state, key, aes_out);
	TSC Trojan (clk, rst, out);

	always @ (posedge clk)
		begin
			if (rst == 1)
				key <= 128'd0;
			else if (key_change)
				key <= key + 128'd1;
		end
	
	always @ (posedge clk)
		begin
			if (rst == 1)
				state <= 128'd0;
			else if (state_change)
				state <= state + 128'd1;
		end

	assign out = ^aes_out;

endmodule

