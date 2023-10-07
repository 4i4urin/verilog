`timescale 1ns/1ns

`include "div_three.v"
// биты поступают в обратном порядке
`define NUMBER 129 // на графике число 129 % 3 = 0
// `define NUMBER 1 // на графике число 128 % 3 = 2
// `define NUMBER 17 // на графике число 136 % 3 = 1

module td(
	output clk,

	output data, 
	output data_start,
	output data_finish
);


div_three div_three(
	clk, 
	data, 
	data_start, 
	data_finish, 
	div_three_output
);

reg clk = 0;

initial
	forever #5 clk = ~clk; // period 10 nsec

reg data_start = 0;
reg data_finish = 0;
reg transmition = 0;

// turn on data_start/finish
initial
begin
	#5 transmition <= 1;
	#10	data_start <= 1;
	#70	data_finish <= 1;
end

// turn off data_start and data end
always @(posedge clk) begin
	if (data_start == 1)
		data_start <= 0;
	if (data_finish == 1) begin
		data_finish <= 0;
		transmition <= 0;
	end
end


reg [7:0]number = `NUMBER;
reg data = 0;

// turn off transmition
always @(posedge clk) begin
	if (transmition == 1) begin
		if (number == 0)
			data <= 0;
		else begin
			data <= number % 2;
			number <= number / 2;
		end
	end
end


initial
begin
	$dumpfile("test.vcd");
	$dumpvars(0, td);
end


endmodule
