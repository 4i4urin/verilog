`timescale 1ns/1ns

module mult_8bit_sign (
	input clk,    	 // Clock
	input signed [7 : 0] a, // first number
	input signed [7 : 0] b, // second number

	output signed [7 : 0]res // multiply result
);


integer i = 0;
reg signed [7 : 0] tmp [0 : 7];
reg signed [7 : 0] res = 0;
reg a_sign = 0, b_sign = 0;

always @(posedge clk) begin
	for (i = 0; i < 7; i++) begin
		// creation of multiply matrix
		if (a[7] == 1 && b[7] == 0) // a < 0 ; b > 0
			tmp[ i ] <= ( b[i] ) ? ( ~(a - 1) ) << i : 0; // additional code a to direct

		else if (a[7] == 0 && b[7] == 1) // a > 0 ; b < 0
			tmp[ i ] <= ( a[i] ) ? ( ~(b - 1) ) << i : 0; // additional code b to direct

		else if (a[7] == 1 && b[7] == 1) // a < 0 ; b < 0
			tmp[ i ] <= (  ( ~(a - 1) & (1 << i) )  ) ? ( ~(b - 1) ) << i : 0;
			// additional code a and b to direct
		else // a > 0 ; b > 0
			tmp[ i ] <= ( a[i] ) ? b << i : 0;
	end

	a_sign <= a[7]; b_sign <= b[7];

	if ( a_sign == 1 ^ b_sign == 1 )// a * b < 0
		res <= 1 + ~(
			tmp[0] + tmp[1] + tmp[2] + tmp[3] + tmp[4] + tmp[5] + tmp[6]
		);
	else // a * b > 0
		res <= tmp[0] + tmp[1] + tmp[2] + tmp[3] + tmp[4] + tmp[5] + tmp[6];
end

endmodule
