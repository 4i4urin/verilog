`timescale 1ns/1ns

module mult (
	input clk,    // Clock
	input signed [15 : 0] num1,
	input signed [15 : 0] num2,

	output signed [15 : 0] res	
);

reg signed [15 : 0] mult;
reg signed [15 : 0] tmp;


always @(posedge clk) begin
	tmp <= num1 * num2;
	mult <= tmp;
end

assign res = mult;

endmodule
