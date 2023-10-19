`timescale 1ns/1ns

`define A1_RE  8'sd10
`define B1_IM  -8'sd9

`define A2_RE -8'sd3
`define B2_IM -8'sd7

`define A3_RE -8'sd3
`define B3_IM 8'sd10

`define A4_RE 8'sd5
`define B4_IM -8'sd3


module tb_mult_two_cycle ();

reg clk = 0;

initial
	forever #5 clk = ~clk; // period 10 nsec


// 10 * 4 = 40 -> 0x28
mult_8bit_sign mult1(
	.clk(clk),
	.a(`A1_RE),
	.b(`B1_IM),
);

// -3 * -7 = 21 -> 0x15
mult_8bit_sign mult2(
	.clk(clk),
	.a(`A2_RE),
	.b(`B2_IM),
);

// -3 * 12 = -36 -> 0xDC
mult_8bit_sign mult3(
	.clk(clk),
	.a(`A3_RE),
	.b(`B3_IM),
);

// 5 * -3 = -15 -> 0xF1
mult_8bit_sign mult4(
	.clk(clk),
	.a(`A4_RE),
	.b(`B4_IM),
);

initial
begin
	$dumpfile("test_mult.vcd");
	$dumpvars;
end

endmodule
