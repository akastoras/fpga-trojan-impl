`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:18:26 03/08/2013 
// Design Name: 
// Module Name:    TSC 
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
module TSC(
	input clk,
	input rst,
	input [127:0] in,
	output out
	);

	reg	[127:0] DynamicPower; 
	reg [127:0] Counter;
	reg	Tj_Trig;
	reg [127:0] old_out;
	
	/* Shift register that drains battery when enabed */
	always @(posedge clk)
	begin
		if (rst == 1)
			DynamicPower = 128'haaaaaaaa_aaaaaaaa_aaaaaaaa_aaaaaaaa;
		else if (Tj_Trig == 1)
			DynamicPower = {DynamicPower[0],DynamicPower[127:1]}; 	
	end


	/* Keeping previous cycle's out value */
	always @(posedge clk) begin
		if (rst) begin
			old_out = 0;
		end else begin
			old_out = out;
		end
	end

	/* Comparing previous value of out with current one */
	assign out_changed = old_out != out;

	/* Count changes of out */
	always @(posedge clk)
	begin
		if (rst == 1) begin
			Counter = 0;
		end else if (out_changed) begin
			Counter = Counter + 1;
		end
	end

	/* FF that becomes 1 when the counter reaches 128'hfffff..fffff */
	always @(posedge clk)
	begin
		if (rst == 1) begin
			Tj_Trig = 0;
		end else if (Counter == 128'hffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff) begin
			Tj_Trig = 1;
		end 
	end

	/* Just an output to dissallow the synthesizer from optimizing out this module */
	assign out = DynamicPower[0];

endmodule
