



module div_three (
	input clk, 		// Clock
	input in_data, 		// input number
	input in_data_start,  // Flag starting data transmition
	input in_data_finish, // Flag finishing data transmition
	
	output out_is_div_three
);

reg is_div_three = 1;
reg [1:0] state = 0;
reg is_transmition = 0;
assign input_bit = in_data;

// turning ON/OFF
always @(posedge clk) begin 
	if (in_data_start == 1)
		is_transmition <= 1;
	if (in_data_finish == 1)
		is_transmition <= 0;
	end


always @(posedge clk) begin 

	if (in_data_start | is_transmition) begin
		case (state)
			2'b00: begin
				state <= input_bit ? 1 : 0;
				if (input_bit)
					is_div_three <= 0; // state 0 -> 1
			end
			2'b01: begin
				state <= input_bit ? 0 : 2;
				is_div_three <= input_bit ? 1 : 0;
			end
			2'b10: begin
				state <= input_bit ? 2 : 1;
				is_div_three <= 0;
			end

			default : begin 
				state <= 0;
				is_div_three <= 1;
			end
		endcase
	end

end



assign out_is_div_three = is_div_three;




endmodule 
