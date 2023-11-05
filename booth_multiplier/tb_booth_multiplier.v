`timescale 1ns/1ns

`define A1  8'sd10
`define B1  -8'sd9

`define A2 -8'sd3
`define B2 -8'sd7

`define A3 -8'sd3
`define B3 8'sd10

`define A4 8'sd7
`define B4 8'sd3

module tb_booth_multiplier ();

reg clk = 0;

initial
	forever #5 clk = ~clk; // period 10 nsec


reg signed [7 : 0] a1 = 8'sh0;
reg signed [7 : 0] b1 = 8'sh0;
reg action = 0;

booth_mult_matrix_8_bit mult1(
	.clk   (clk),
	.num1  (a1),
	.num2  (b1)
);

booth_mult_accum_8_bit mult2(
	.clk   (clk),
	.num1  (a1),
	.num2  (b1),
	.action (action)
);

reg [3 : 0] clk_count = 8'h0;

// turn off data_start and data end
always @(posedge clk) begin
	if (clk_count == 2) begin
		a1 <= `A1;
		b1 <= `B1;
		action <= 1;
	end
	else if (clk_count == 4) begin
		a1 <= `A2;
		b1 <= `B2;
		action <= 1;
	end
	else if (clk_count == 6) begin
		a1 <= `A3;
		b1 <= `B3;
		action <= 1;
	end
	else if (clk_count == 8) begin
		a1 <= `A4;
		b1 <= `B4;
		action <= 1;
	end
	else begin
		a1 <= 0;
		b1 <= 0;
		action <= 0;
	end
	clk_count <= clk_count + 1;
end

initial
begin
	$dumpfile("test_booth.vcd");
	$dumpvars;
end

endmodule