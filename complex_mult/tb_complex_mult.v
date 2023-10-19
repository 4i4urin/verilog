`timescale 1ns/1ns


`define A1_RE -8'sd3
`define B1_IM  8'sd9

`define A2_RE  8'sd10
`define B2_IM  8'sd9


module tb_complex_mult ();


reg clk = 0;

initial
	forever #5 clk = ~clk; // period 10 nsec


reg signed [7 : 0] a1_out = 8'sh0;
reg signed [7 : 0] b1_out = 8'sh0;
reg signed [7 : 0] a2_out = 8'sh0;
reg signed [7 : 0] b2_out = 8'sh0;

wire signed [7 : 0] res_re_tb = 0;
wire signed [7 : 0] res_im_tb = 0;


complex_mult complex_mult(
	.clk(clk),

	.a1(a1_out), 
	.b1(b1_out),
	.a2(a2_out),
	.b2(b2_out),

	.res_re(res_re_tb),
	.res_im(res_im_tb)
);


reg [1 : 0] clk_count = 8'h0;


// turn off data_start and data end
always @(posedge clk) begin
	if (clk_count % 3 == 2) begin
		a1_out <= `A1_RE;
		b1_out <= `B1_IM;
		a2_out <= `A2_RE;
		b2_out <= `B2_IM;
		clk_count <= 0;
	end
	else begin
		a1_out <= 0;
		b1_out <= 0;
		a2_out <= 0;
		b2_out <= 0;
		clk_count <= clk_count + 1;
	end
end


initial
begin
	$dumpfile("test.vcd");
	$dumpvars;
end


endmodule
