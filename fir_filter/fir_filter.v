`timescale 1ns/1ns
`define WIDTH 18


module fir_filter (
    input clk,    // Clock

    input signed  [`WIDTH-1 : 0] input_sig,
    input ready,

    output signed [`WIDTH-1 : 0] filtred_sig
);

wire signed [`WIDTH-1 : 0] fir_coefs [0 : 63];

reg signed [`WIDTH-1: 0] delay [0 : 63];


integer i;

initial 
    for (i = 0; i < 64; i = i + 1)
        delay[i] = 0;

reg signed [`WIDTH-1: 0] coll_sum = 0;
reg signed [`WIDTH-1: 0] result = 0;

reg [5 : 0] r_index = 8'h7F;
reg [5 : 0] w_index = 0;


always @(posedge clk) begin

    if (ready) begin
        r_index <= r_index + 1;
        if ( r_index )
            coll_sum <= coll_sum + fir_coefs[r_index] * delay[(w_index - r_index - 1) & 8'h7F];
        else
            coll_sum <= fir_coefs[r_index] * delay[(w_index - r_index - 1) & 8'h7F];
    end       

    if ( r_index == 8'h7F && ready) begin
        result <= (coll_sum >>> 16);// & 18'sh3FF;
        
        w_index <= w_index + 1;
        delay[w_index] <= input_sig;
    end
end


assign filtred_sig = result;

// # python3
// from scipy.signal import kaiserord, firwin

// sample_rate = 100.0
// nyq_rate = sample_rate / 2.0
// width = 3.0/nyq_rate
// ripple_db = 70.0

// # Compute the order and Kaiser parameter for the FIR filter.
// N, beta = kaiserord(ripple_db, width) # N = 146 decrease to 128
// cutoff_hz = 10.0

// taps = firwin(64, cutoff_hz/nyq_rate, window=('kaiser', beta))
// taps = (taps * 255).astype(int)
// count = 0
// for tap in taps:
//     print(f"assign fir_coefs[{count}] = ", end="")
//     if tap < 0:
//         print(f"-`WIDTH'sd{abs(tap)};")
//     else:
//         print(f"`WIDTH'sd{tap};")
//     count += 1
assign fir_coefs[0] = `WIDTH'sd0;
assign fir_coefs[1] = `WIDTH'sd0;
assign fir_coefs[2] = `WIDTH'sd0;
assign fir_coefs[3] = `WIDTH'sd0;
assign fir_coefs[4] = `WIDTH'sd0;
assign fir_coefs[5] = `WIDTH'sd0;
assign fir_coefs[6] = `WIDTH'sd0;
assign fir_coefs[7] = `WIDTH'sd0;
assign fir_coefs[8] = `WIDTH'sd0;
assign fir_coefs[9] = `WIDTH'sd0;
assign fir_coefs[10] = `WIDTH'sd0;
assign fir_coefs[11] = `WIDTH'sd0;
assign fir_coefs[12] = `WIDTH'sd0;
assign fir_coefs[13] = -`WIDTH'sd1;
assign fir_coefs[14] = -`WIDTH'sd1;
assign fir_coefs[15] = -`WIDTH'sd1;
assign fir_coefs[16] = `WIDTH'sd0;
assign fir_coefs[17] = `WIDTH'sd0;
assign fir_coefs[18] = `WIDTH'sd2;
assign fir_coefs[19] = `WIDTH'sd3;
assign fir_coefs[20] = `WIDTH'sd3;
assign fir_coefs[21] = `WIDTH'sd1;
assign fir_coefs[22] = -`WIDTH'sd1;
assign fir_coefs[23] = -`WIDTH'sd6;
assign fir_coefs[24] = -`WIDTH'sd9;
assign fir_coefs[25] = -`WIDTH'sd8;
assign fir_coefs[26] = -`WIDTH'sd4;
assign fir_coefs[27] = `WIDTH'sd5;
assign fir_coefs[28] = `WIDTH'sd18;
assign fir_coefs[29] = `WIDTH'sd31;
assign fir_coefs[30] = `WIDTH'sd43;
assign fir_coefs[31] = `WIDTH'sd50;
assign fir_coefs[32] = `WIDTH'sd50;
assign fir_coefs[33] = `WIDTH'sd43;
assign fir_coefs[34] = `WIDTH'sd31;
assign fir_coefs[35] = `WIDTH'sd18;
assign fir_coefs[36] = `WIDTH'sd5;
assign fir_coefs[37] = -`WIDTH'sd4;
assign fir_coefs[38] = -`WIDTH'sd8;
assign fir_coefs[39] = -`WIDTH'sd9;
assign fir_coefs[40] = -`WIDTH'sd6;
assign fir_coefs[41] = -`WIDTH'sd1;
assign fir_coefs[42] = `WIDTH'sd1;
assign fir_coefs[43] = `WIDTH'sd3;
assign fir_coefs[44] = `WIDTH'sd3;
assign fir_coefs[45] = `WIDTH'sd2;
assign fir_coefs[46] = `WIDTH'sd0;
assign fir_coefs[47] = `WIDTH'sd0;
assign fir_coefs[48] = -`WIDTH'sd1;
assign fir_coefs[49] = -`WIDTH'sd1;
assign fir_coefs[50] = -`WIDTH'sd1;
assign fir_coefs[51] = `WIDTH'sd0;
assign fir_coefs[52] = `WIDTH'sd0;
assign fir_coefs[53] = `WIDTH'sd0;
assign fir_coefs[54] = `WIDTH'sd0;
assign fir_coefs[55] = `WIDTH'sd0;
assign fir_coefs[56] = `WIDTH'sd0;
assign fir_coefs[57] = `WIDTH'sd0;
assign fir_coefs[58] = `WIDTH'sd0;
assign fir_coefs[59] = `WIDTH'sd0;
assign fir_coefs[60] = `WIDTH'sd0;
assign fir_coefs[61] = `WIDTH'sd0;
assign fir_coefs[62] = `WIDTH'sd0;
assign fir_coefs[63] = `WIDTH'sd0;

endmodule
