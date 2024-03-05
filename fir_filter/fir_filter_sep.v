`timescale 1ns/1ns


module fir_filter_sep (
    input clk,    // Clock

    input signed  [7 : 0] input_sig,
    input ready,

    output signed [7 : 0] output_sig
);


reg signed [7 : 0] fir_coefs [0 : 79];
initial begin
    $readmemh("fir_coefs.txt", fir_coefs);
end


reg signed [7: 0] delay [0 : 79];
reg init_flag = 0;

integer i;
always @(posedge clk) begin
    if (init_flag == 0) begin
        for (i = 0; i < 80; i = i + 1) begin
            delay[i] <= 0;
        end
        init_flag <= 1;
    end
end


reg signed [15: 0] coll_sum_pos = 0;
reg signed [15: 0] coll_sum_neg = 0;

reg signed [15: 0] tact_calc_neg_0 = 0;
reg signed [15: 0] tact_calc_neg_1 = 0;
reg signed [15: 0] tact_calc_neg_2 = 0;
reg signed [15: 0] tact_calc_neg_3 = 0;

reg signed [15: 0] tact_calc_pos_0 = 0;
reg signed [15: 0] tact_calc_pos_1 = 0;
reg signed [15: 0] tact_calc_pos_2 = 0;
reg signed [15: 0] tact_calc_pos_3 = 0;

reg signed [7 : 0] result = 0;
reg [6 : 0] index = 0;

integer ii;

always @(posedge clk) begin

    if (index < 75 && ready)
        index <= index + 4;
    else begin
        index <= 0;
        result <= ((coll_sum_pos + coll_sum_neg) >>> 8) & 16'shFF;

        delay[0] <= input_sig;
        for (ii = 1; ii < 80; ii = ii + 1) 
            delay[ii] <= delay[ii - 1];
    end

    if (ready) begin
        if ( (fir_coefs[index] ^ delay[index]) & 8'sh80 ) begin
            tact_calc_neg_0 <= fir_coefs[index] * delay[index];
            tact_calc_pos_0 <= 0; 
        end
        else begin
            tact_calc_neg_0 <= 0;
            tact_calc_pos_0 <= fir_coefs[index] * delay[index]; 
        end 

        if ( (fir_coefs[index+1] ^ delay[index+1]) & 8'sh80 ) begin
            tact_calc_neg_1 <= fir_coefs[index+1] * delay[index+1];
            tact_calc_pos_1 <= 0; 
        end
        else begin
            tact_calc_neg_1 <= 0;
            tact_calc_pos_1 <= fir_coefs[index+1] * delay[index+1];
        end 

        if ( (fir_coefs[index+2] ^ delay[index+2]) & 8'sh80 ) begin
            tact_calc_neg_2 <= fir_coefs[index+2] * delay[index+2];
            tact_calc_pos_2 <= 0; 
        end
        else begin
            tact_calc_neg_2 <= 0;
            tact_calc_pos_2 <= fir_coefs[index+2] * delay[index+2];
        end 

        if ( (fir_coefs[index+3] ^ delay[index+3]) & 8'sh80 ) begin
            tact_calc_neg_3 <= fir_coefs[index+3] * delay[index+3];
            tact_calc_pos_3 <= 0; 
        end
        else begin
            tact_calc_neg_3 <= 0;
            tact_calc_pos_3 <= fir_coefs[index+3] * delay[index+3];
        end 

        if (index) begin
            coll_sum_pos <= coll_sum_pos + tact_calc_pos_0 + tact_calc_pos_1 + tact_calc_pos_2 + tact_calc_pos_3;
            coll_sum_neg <= coll_sum_neg + tact_calc_neg_0 + tact_calc_neg_1 + tact_calc_neg_2 + tact_calc_neg_3; 
        end
        else begin
            coll_sum_pos <= 0;
            coll_sum_neg <= 0;
        end 
            
    end

end


assign output_sig = result;

endmodule
