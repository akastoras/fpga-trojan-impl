`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:39 03/08/2013 
// Design Name: 
// Module Name:    Trojan_Trigger 
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
module Trojan_Trigger(
    input rst,
    input clk,
    input [127:0] state,
    output Tj_Trig
    );

	reg Tj_Trig;

	always @(posedge clk)
	begin
		if (rst == 1) begin
			Tj_Trig = 0;
		end else if (state == 128'h00112233_44556677_8899aabb_ccddeeff) begin 
			Tj_Trig = 1;
		end
	end

endmodule
