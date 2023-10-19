`timescale 1ns/1ns

// (a1 + b1 i) * (a2 + b2 i) = a1*a2 - b1*b2 + (a1*b2 + a2*b1) i
module complex_mult (
	input clk,    // Clock

	input signed [7 : 0] a1, // Real number 1
	input signed [7 : 0] b1, // Img number 1
	input signed [7 : 0] a2, // Real number 2
	input signed [7 : 0] b2, // Img number 2

	output signed [7 : 0] res_re, // Real mult result
	output signed [7 : 0] res_im  // Img mult result
);

reg signed [7 : 0] a1_a2;
wire signed [7 : 0] sub_res_re_1;
wire signed [7 : 0] sub_res_re_2;
wire signed [7 : 0] sub_res_im_1;
wire signed [7 : 0] sub_res_im_2;

// a1 * a2
mult_8bit_sign mult_real1(
	.clk(clk),	.a(a1),
	.b(a2),	.res(sub_res_re_1)
);

// b1 * b2
mult_8bit_sign mult_real2(
	.clk(clk),	.a(b1),
	.b(b2),	.res(sub_res_re_2)
);

// a1 * b2
mult_8bit_sign mult_img1(
	.clk(clk),	.a(a1),
	.b(b2),	.res(sub_res_im_1)
);

// a2 * b1
mult_8bit_sign mult_img2(
	.clk(clk),	.a(a2),
	.b(b1),	.res(sub_res_im_2)
);


reg signed [7 : 0] res_re = 0;
reg signed [7 : 0] res_im = 0;

always @(posedge clk) begin 
	res_re <= sub_res_re_1 - sub_res_re_2; //  a1*a2 - b1*b2
	res_im <= sub_res_im_1 + sub_res_im_2; // (a1*b2 + a2*b1) i
end

endmodule
