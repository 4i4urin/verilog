`timescale 1ns/1ns


module fir_filter (
    input clk,    // Clock

    input signed  [17 : 0] input_sig,
    input ready,

    output signed [17 : 0] filtred_sig
);

wire signed [17 : 0] fir_coefs [0 : 127];

reg signed [17: 0] delay [0 : 127];
reg init_flag = 0;


reg signed [17: 0] coll_sum = 0;
reg signed [17: 0] tact_calc = 0;
reg signed [17: 0] result = 0;

reg [6 : 0] index = 0;

integer i;

always @(posedge clk) begin

    if (ready) begin
        index <= index + 1;
        coll_sum <= coll_sum + fir_coefs[index] * delay[index];
    end       

    if ( !index ) begin
        result <= (coll_sum >>> 8);// & 18'sh3FF;
        coll_sum <= 0;

        delay[0] <= input_sig;
        for (i = 1; i < 128; i = i + 1) 
            delay[i] <= delay[i - 1];
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

// taps = firwin(128, cutoff_hz/nyq_rate, window=('kaiser', beta))
// taps = (taps * 256).astype(int)
// count = 0
// for tap in taps:
//     print(f"assign fir_coefs[{count}] = ", end="")
//     if tap < 0:
//         print(f"-18'sd{abs(tap)};")
//     else:
//         print(f"18'sd{tap};")
//     count += 1
assign fir_coefs[0] = 18'sd0;
assign fir_coefs[1] = 18'sd0;
assign fir_coefs[2] = 18'sd0;
assign fir_coefs[3] = 18'sd0;
assign fir_coefs[4] = 18'sd0;
assign fir_coefs[5] = 18'sd0;
assign fir_coefs[6] = 18'sd0;
assign fir_coefs[7] = 18'sd0;
assign fir_coefs[8] = 18'sd0;
assign fir_coefs[9] = 18'sd0;
assign fir_coefs[10] = 18'sd0;
assign fir_coefs[11] = 18'sd0;
assign fir_coefs[12] = 18'sd0;
assign fir_coefs[13] = 18'sd0;
assign fir_coefs[14] = 18'sd0;
assign fir_coefs[15] = 18'sd0;
assign fir_coefs[16] = 18'sd0;
assign fir_coefs[17] = 18'sd0;
assign fir_coefs[18] = 18'sd0;
assign fir_coefs[19] = 18'sd0;
assign fir_coefs[20] = 18'sd0;
assign fir_coefs[21] = 18'sd0;
assign fir_coefs[22] = 18'sd0;
assign fir_coefs[23] = 18'sd0;
assign fir_coefs[24] = 18'sd0;
assign fir_coefs[25] = 18'sd0;
assign fir_coefs[26] = 18'sd0;
assign fir_coefs[27] = 18'sd0;
assign fir_coefs[28] = 18'sd0;
assign fir_coefs[29] = 18'sd0;
assign fir_coefs[30] = 18'sd0;
assign fir_coefs[31] = 18'sd1;
assign fir_coefs[32] = 18'sd0;
assign fir_coefs[33] = 18'sd0;
assign fir_coefs[34] = 18'sd0;
assign fir_coefs[35] = -18'sd1;
assign fir_coefs[36] = -18'sd1;
assign fir_coefs[37] = -18'sd1;
assign fir_coefs[38] = 18'sd0;
assign fir_coefs[39] = 18'sd0;
assign fir_coefs[40] = 18'sd1;
assign fir_coefs[41] = 18'sd2;
assign fir_coefs[42] = 18'sd2;
assign fir_coefs[43] = 18'sd0;
assign fir_coefs[44] = 18'sd0;
assign fir_coefs[45] = -18'sd2;
assign fir_coefs[46] = -18'sd3;
assign fir_coefs[47] = -18'sd3;
assign fir_coefs[48] = -18'sd1;
assign fir_coefs[49] = 18'sd1;
assign fir_coefs[50] = 18'sd4;
assign fir_coefs[51] = 18'sd5;
assign fir_coefs[52] = 18'sd5;
assign fir_coefs[53] = 18'sd2;
assign fir_coefs[54] = -18'sd2;
assign fir_coefs[55] = -18'sd7;
assign fir_coefs[56] = -18'sd10;
assign fir_coefs[57] = -18'sd9;
assign fir_coefs[58] = -18'sd4;
assign fir_coefs[59] = 18'sd5;
assign fir_coefs[60] = 18'sd18;
assign fir_coefs[61] = 18'sd32;
assign fir_coefs[62] = 18'sd43;
assign fir_coefs[63] = 18'sd50;
assign fir_coefs[64] = 18'sd50;
assign fir_coefs[65] = 18'sd43;
assign fir_coefs[66] = 18'sd32;
assign fir_coefs[67] = 18'sd18;
assign fir_coefs[68] = 18'sd5;
assign fir_coefs[69] = -18'sd4;
assign fir_coefs[70] = -18'sd9;
assign fir_coefs[71] = -18'sd10;
assign fir_coefs[72] = -18'sd7;
assign fir_coefs[73] = -18'sd2;
assign fir_coefs[74] = 18'sd2;
assign fir_coefs[75] = 18'sd5;
assign fir_coefs[76] = 18'sd5;
assign fir_coefs[77] = 18'sd4;
assign fir_coefs[78] = 18'sd1;
assign fir_coefs[79] = -18'sd1;
assign fir_coefs[80] = -18'sd3;
assign fir_coefs[81] = -18'sd3;
assign fir_coefs[82] = -18'sd2;
assign fir_coefs[83] = 18'sd0;
assign fir_coefs[84] = 18'sd0;
assign fir_coefs[85] = 18'sd2;
assign fir_coefs[86] = 18'sd2;
assign fir_coefs[87] = 18'sd1;
assign fir_coefs[88] = 18'sd0;
assign fir_coefs[89] = 18'sd0;
assign fir_coefs[90] = -18'sd1;
assign fir_coefs[91] = -18'sd1;
assign fir_coefs[92] = -18'sd1;
assign fir_coefs[93] = 18'sd0;
assign fir_coefs[94] = 18'sd0;
assign fir_coefs[95] = 18'sd0;
assign fir_coefs[96] = 18'sd1;
assign fir_coefs[97] = 18'sd0;
assign fir_coefs[98] = 18'sd0;
assign fir_coefs[99] = 18'sd0;
assign fir_coefs[100] = 18'sd0;
assign fir_coefs[101] = 18'sd0;
assign fir_coefs[102] = 18'sd0;
assign fir_coefs[103] = 18'sd0;
assign fir_coefs[104] = 18'sd0;
assign fir_coefs[105] = 18'sd0;
assign fir_coefs[106] = 18'sd0;
assign fir_coefs[107] = 18'sd0;
assign fir_coefs[108] = 18'sd0;
assign fir_coefs[109] = 18'sd0;
assign fir_coefs[110] = 18'sd0;
assign fir_coefs[111] = 18'sd0;
assign fir_coefs[112] = 18'sd0;
assign fir_coefs[113] = 18'sd0;
assign fir_coefs[114] = 18'sd0;
assign fir_coefs[115] = 18'sd0;
assign fir_coefs[116] = 18'sd0;
assign fir_coefs[117] = 18'sd0;
assign fir_coefs[118] = 18'sd0;
assign fir_coefs[119] = 18'sd0;
assign fir_coefs[120] = 18'sd0;
assign fir_coefs[121] = 18'sd0;
assign fir_coefs[122] = 18'sd0;
assign fir_coefs[123] = 18'sd0;
assign fir_coefs[124] = 18'sd0;
assign fir_coefs[125] = 18'sd0;
assign fir_coefs[126] = 18'sd0;
assign fir_coefs[127] = 18'sd0;


endmodule
