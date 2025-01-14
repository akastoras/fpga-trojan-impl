`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:52 03/06/2013 
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


module top(clk, rst, state_change, key_change, out, capacitance);
    input clk, rst, state_change, key_change;
	output out, capacitance;
	wire [7:0] capacitance;
    reg  [127:0] state, key;
	wire [127:0] aes_out;
    wire [63:0] Capacitance;
    wire Tj_Trig;
	aes_128 AES (clk, state, key, aes_out);

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


	Trojan_Trigger Trigger (rst, clk, state, Tj_Trig); 
	TSC Trojan (rst, clk, Tj_Trig, key, state, Capacitance); 

	assign out = ^aes_out;
    assign capacitance[0] = Capacitance[0];
    assign capacitance[1] = Capacitance[8];
    assign capacitance[2] = Capacitance[16];
    assign capacitance[3] = Capacitance[24];
    assign capacitance[4] = Capacitance[32];
    assign capacitance[5] = Capacitance[40];
    assign capacitance[6] = Capacitance[48];
    assign capacitance[7] = Capacitance[56];
    



endmodule
