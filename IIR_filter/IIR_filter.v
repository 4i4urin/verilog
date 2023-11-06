`timescale 1ns/1ns

// odds a = -2, b, = 3
// IIR filter - y(n) = a * y(n - 1) + b * x(n)

// rework filter function to - 
// 		y(n) = a^3 * y(n - 3) + a^2 * b * x(n - 2) + a * b * x(n - 1) + b * x(n)
//		a^3 = -8, a^2 * b = 12, a * b = -6, b = 3

`define A_CUBE -16'sd8
`define A_SQUARE_MULT_B 16'sd12
`define A_MULT_B -16'sd6
`define B 16'sd3


module IIR_filter (
	input clk,    // Clock
	input signed  [15 : 0] x_val, // x(n)

	output signed [15 : 0] y_val // y(n)
);

reg [8 : 0] init_count = 0;		// count to calculate all summable
reg [8 : 0] disinit_count = 0;	// count to stop work

reg signed [15 : 0] x_val_old_1 = 0; // x(n - 1)
reg signed [15 : 0] x_val_old_2 = 0; // x(n - 2)
reg signed [15 : 0] y_calc_val = 0;	 // y(n)


always @(posedge clk) begin
	x_val_old_1 <= x_val;	
	x_val_old_2 <= x_val_old_1;

	if (init_count > 5)
		// y(n) = a^3 * y(n - 3) + a^2 * b * x(n - 2) + a * b * x(n - 1) + b * x(n)
		y_calc_val <= x_mult_b + x_mult_a_b + x_mult_a_a_b + y_mult_a_cube;
	else begin // a^3 * y(n - 3)  exist only after 5 tics 
		// y(n) = a^2 * b * x(n - 2) + a * b * x(n - 1) + b * x(n)
		y_calc_val <= x_mult_b + x_mult_a_b + x_mult_a_a_b;
		init_count <= init_count + 1;
	end
end

wire signed [15 : 0] x_mult_b; 		// b * x(n) 
wire signed [15 : 0] x_mult_a_b;	// a * b * x(n - 1)
wire signed [15 : 0] x_mult_a_a_b;	// a^2 * b * x(n - 2)
wire signed [15 : 0] y_mult_a_cube;	// a^3 * y(n - 3)

// b * x(n) 			n = 1
mult m_x_mult_b(
	.clk 	(clk),
	.num1	(`B),
	.num2	(x_val),

	.res 	(x_mult_b)
);

// a * b * x(n - 1)		n = 2
mult m_x_mult_a_b(
	.clk 	(clk),
	.num1	(`A_MULT_B),
	.num2	(x_val_old_1),

	.res 	(x_mult_a_b)
);

// a^2 * b * x(n - 2)	n = 3
mult m_x_mult_a_a_b(
	.clk 	(clk),
	.num1	(`A_SQUARE_MULT_B),
	.num2	(x_val_old_2),

	.res 	(x_mult_a_a_b)
);

// a^3 * y(n - 3)		n = 4
mult m_y_mult_a_cube(
	.clk 	(clk),
	.num1	(`A_CUBE),
	.num2	(y_calc_val),

	.res 	(y_mult_a_cube)
);

assign y_val = y_calc_val;

endmodule 
