`timescale 1ns/1ns


module fir_filter_sep (
    input clk,    // Clock

    input signed  [7 : 0] input_sig,
    input ready,

    output signed [7 : 0] filtred_sig
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
reg signed [16: 0] coll_sum_neg = 0;

reg signed [16: 0] tact_calc_neg [0 : 3];
reg        [15: 0] tact_calc_pos [0 : 3];

reg signed [7 : 0] result = 0;
reg [6 : 0] index = 0;

integer ii;

always @(posedge clk) begin

    if (index < 75 && ready)
        index <= index + 4;
    else begin
        index <= 0;
        result <= ((coll_sum_pos + coll_sum_neg + 1) >>> 8) & 16'shFF;

        delay[0] <= input_sig;
        for (ii = 1; ii < 80; ii = ii + 1) 
            delay[ii] <= delay[ii - 1];
    end

    if (ready) begin

        for (ii = 0; ii < 4; ii = ii + 1)
            if ( (fir_coefs[index + ii] ^ delay[index + ii]) & 8'sh80 ) begin
                tact_calc_neg[ii] <= fir_coefs[index + ii] * delay[index + ii] - 1;
                tact_calc_pos[ii] <= 0; 
            end
            else begin
                tact_calc_neg[ii] <= -1;
                tact_calc_pos[ii] <= fir_coefs[index + ii] * delay[index + ii]; 
            end 


        if (index) begin
            coll_sum_pos <= coll_sum_pos + tact_calc_pos[0] + tact_calc_pos[1] + tact_calc_pos[2] + tact_calc_pos[3];
            coll_sum_neg <= coll_sum_neg + tact_calc_neg[0] + tact_calc_neg[1] + tact_calc_neg[2] + tact_calc_neg[3] + 4; 
        end
        else begin
            coll_sum_pos <= 0;
            coll_sum_neg <= -1;
        end
    end
end



assign filtred_sig = result;

endmodule
