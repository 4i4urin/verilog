`timescale 1ns/1ns


module fir_filter_sep (
    input clk,    // Clock

    input signed  [7 : 0] input_sig,
    input ready,

    output signed [7 : 0] filtred_sig
);


wire signed [7 : 0] fir_coefs [0 : 79];
// # python3
// from scipy.signal import kaiserord, firwin

// sample_rate = 100.0
// nyq_rate = sample_rate / 2.0
// width = 5.0/nyq_rate
// ripple_db = 60.0

// # Compute the order and Kaiser parameter for the FIR filter.
// N, beta = kaiserord(ripple_db, width)
// cutoff_hz = 10.0

// taps = firwin(N, cutoff_hz/nyq_rate, window=('kaiser', beta))
// taps = (taps * 256).astype(int)
// count = 0
// for tap in taps:
//     print(f"assign fir_coefs[{count}] = ", end="")
//     if tap < 0:
//         print(f"-8'sd{abs(tap)};")
//     else:
//         print(f"8'sd{tap};")
//     count += 1
assign fir_coefs[0] = 8'sd0;
assign fir_coefs[1] = 8'sd0;
assign fir_coefs[2] = 8'sd0;
assign fir_coefs[3] = 8'sd0;
assign fir_coefs[4] = 8'sd0;
assign fir_coefs[5] = 8'sd0;
assign fir_coefs[6] = 8'sd0;
assign fir_coefs[7] = 8'sd0;
assign fir_coefs[8] = 8'sd0;
assign fir_coefs[9] = 8'sd0;
assign fir_coefs[10] = 8'sd0;
assign fir_coefs[11] = 8'sd0;
assign fir_coefs[12] = 8'sd0;
assign fir_coefs[13] = 8'sd0;
assign fir_coefs[14] = 8'sd1;
assign fir_coefs[15] = 8'sd1;
assign fir_coefs[16] = 8'sd0;
assign fir_coefs[17] = 8'sd0;
assign fir_coefs[18] = -8'sd1;
assign fir_coefs[19] = -8'sd2;
assign fir_coefs[20] = -8'sd2;
assign fir_coefs[21] = -8'sd1;
assign fir_coefs[22] = 8'sd1;
assign fir_coefs[23] = 8'sd3;
assign fir_coefs[24] = 8'sd4;
assign fir_coefs[25] = 8'sd4;
assign fir_coefs[26] = 8'sd1;
assign fir_coefs[27] = -8'sd2;
assign fir_coefs[28] = -8'sd6;
assign fir_coefs[29] = -8'sd9;
assign fir_coefs[30] = -8'sd9;
assign fir_coefs[31] = -8'sd4;
assign fir_coefs[32] = 8'sd5;
assign fir_coefs[33] = 8'sd18;
assign fir_coefs[34] = 8'sd32;
assign fir_coefs[35] = 8'sd43;
assign fir_coefs[36] = 8'sd50;
assign fir_coefs[37] = 8'sd50;
assign fir_coefs[38] = 8'sd43;
assign fir_coefs[39] = 8'sd32;
assign fir_coefs[40] = 8'sd18;
assign fir_coefs[41] = 8'sd5;
assign fir_coefs[42] = -8'sd4;
assign fir_coefs[43] = -8'sd9;
assign fir_coefs[44] = -8'sd9;
assign fir_coefs[45] = -8'sd6;
assign fir_coefs[46] = -8'sd2;
assign fir_coefs[47] = 8'sd1;
assign fir_coefs[48] = 8'sd4;
assign fir_coefs[49] = 8'sd4;
assign fir_coefs[50] = 8'sd3;
assign fir_coefs[51] = 8'sd1;
assign fir_coefs[52] = -8'sd1;
assign fir_coefs[53] = -8'sd2;
assign fir_coefs[54] = -8'sd2;
assign fir_coefs[55] = -8'sd1;
assign fir_coefs[56] = 8'sd0;
assign fir_coefs[57] = 8'sd0;
assign fir_coefs[58] = 8'sd1;
assign fir_coefs[59] = 8'sd1;
assign fir_coefs[60] = 8'sd0;
assign fir_coefs[61] = 8'sd0;
assign fir_coefs[62] = 8'sd0;
assign fir_coefs[63] = 8'sd0;
assign fir_coefs[64] = 8'sd0;
assign fir_coefs[65] = 8'sd0;
assign fir_coefs[66] = 8'sd0;
assign fir_coefs[67] = 8'sd0;
assign fir_coefs[68] = 8'sd0;
assign fir_coefs[69] = 8'sd0;
assign fir_coefs[70] = 8'sd0;
assign fir_coefs[71] = 8'sd0;
assign fir_coefs[72] = 8'sd0;
assign fir_coefs[73] = 8'sd0;


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
reg signed [16: 0] coll_sum_neg = -1;

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
