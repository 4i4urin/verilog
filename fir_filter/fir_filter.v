`timescale 1ns/1ns
`define WIDTH 18


module fir_filter (
    input clk,    // Clock

    input signed  [`WIDTH-1 : 0] input_sig,
    input ready,

    output signed [`WIDTH-1 : 0] filtred_sig
);

wire signed [`WIDTH-1 : 0] fir_coefs [0 : 127];

reg signed [`WIDTH-1: 0] delay [0 : 127];


integer i;

initial 
    for (i = 0; i < 128; i = i + 1)
        delay[i] = 0;

reg signed [`WIDTH*2-1: 0] coll_sum = 0;
reg signed [`WIDTH*2-1: 0] result = 0;

reg [6 : 0] r_index = 8'h7F;
reg [6 : 0] w_index = 0;
reg [6 : 0] del_index = 0;


always @(posedge clk) begin

    if (ready) begin
        r_index <= r_index + 1;
        del_index <= w_index - r_index - 1;
        if ( r_index )
            coll_sum <= coll_sum + fir_coefs[r_index] * delay[del_index ];
        else
            coll_sum <= fir_coefs[r_index] * delay[del_index];
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

// taps = firwin(128, cutoff_hz/nyq_rate, window=('kaiser', beta))
// taps = (taps * 65535).astype(int)
// count = 0
// for tap in taps:
//     print(f"assign fir_coefs[{count}] = ", end="")
//     if tap < 0:
//         print(f"-`WIDTH'sd{abs(tap)};")
//     else:
//         print(f"`WIDTH'sd{tap};")
//     count += 1
assign fir_coefs[0] = `WIDTH'sd1;
assign fir_coefs[1] = `WIDTH'sd3;
assign fir_coefs[2] = `WIDTH'sd3;
assign fir_coefs[3] = `WIDTH'sd1;
assign fir_coefs[4] = -`WIDTH'sd2;
assign fir_coefs[5] = -`WIDTH'sd7;
assign fir_coefs[6] = -`WIDTH'sd11;
assign fir_coefs[7] = -`WIDTH'sd11;
assign fir_coefs[8] = -`WIDTH'sd5;
assign fir_coefs[9] = `WIDTH'sd6;
assign fir_coefs[10] = `WIDTH'sd19;
assign fir_coefs[11] = `WIDTH'sd28;
assign fir_coefs[12] = `WIDTH'sd26;
assign fir_coefs[13] = `WIDTH'sd11;
assign fir_coefs[14] = -`WIDTH'sd13;
assign fir_coefs[15] = -`WIDTH'sd40;
assign fir_coefs[16] = -`WIDTH'sd56;
assign fir_coefs[17] = -`WIDTH'sd51;
assign fir_coefs[18] = -`WIDTH'sd22;
assign fir_coefs[19] = `WIDTH'sd24;
assign fir_coefs[20] = `WIDTH'sd73;
assign fir_coefs[21] = `WIDTH'sd101;
assign fir_coefs[22] = `WIDTH'sd91;
assign fir_coefs[23] = `WIDTH'sd38;
assign fir_coefs[24] = -`WIDTH'sd42;
assign fir_coefs[25] = -`WIDTH'sd123;
assign fir_coefs[26] = -`WIDTH'sd169;
assign fir_coefs[27] = -`WIDTH'sd150;
assign fir_coefs[28] = -`WIDTH'sd63;
assign fir_coefs[29] = `WIDTH'sd69;
assign fir_coefs[30] = `WIDTH'sd198;
assign fir_coefs[31] = `WIDTH'sd268;
assign fir_coefs[32] = `WIDTH'sd236;
assign fir_coefs[33] = `WIDTH'sd98;
assign fir_coefs[34] = -`WIDTH'sd107;
assign fir_coefs[35] = -`WIDTH'sd306;
assign fir_coefs[36] = -`WIDTH'sd411;
assign fir_coefs[37] = -`WIDTH'sd361;
assign fir_coefs[38] = -`WIDTH'sd149;
assign fir_coefs[39] = `WIDTH'sd162;
assign fir_coefs[40] = `WIDTH'sd461;
assign fir_coefs[41] = `WIDTH'sd619;
assign fir_coefs[42] = `WIDTH'sd543;
assign fir_coefs[43] = `WIDTH'sd225;
assign fir_coefs[44] = -`WIDTH'sd244;
assign fir_coefs[45] = -`WIDTH'sd696;
assign fir_coefs[46] = -`WIDTH'sd936;
assign fir_coefs[47] = -`WIDTH'sd825;
assign fir_coefs[48] = -`WIDTH'sd344;
assign fir_coefs[49] = `WIDTH'sd377;
assign fir_coefs[50] = `WIDTH'sd1084;
assign fir_coefs[51] = `WIDTH'sd1477;
assign fir_coefs[52] = `WIDTH'sd1323;
assign fir_coefs[53] = `WIDTH'sd563;
assign fir_coefs[54] = -`WIDTH'sd632;
assign fir_coefs[55] = -`WIDTH'sd1877;
assign fir_coefs[56] = -`WIDTH'sd2662;
assign fir_coefs[57] = -`WIDTH'sd2512;
assign fir_coefs[58] = -`WIDTH'sd1144;
assign fir_coefs[59] = `WIDTH'sd1410;
assign fir_coefs[60] = `WIDTH'sd4776;
assign fir_coefs[61] = `WIDTH'sd8303;
assign fir_coefs[62] = `WIDTH'sd11231;
assign fir_coefs[63] = `WIDTH'sd12889;
assign fir_coefs[64] = `WIDTH'sd12889;
assign fir_coefs[65] = `WIDTH'sd11231;
assign fir_coefs[66] = `WIDTH'sd8303;
assign fir_coefs[67] = `WIDTH'sd4776;
assign fir_coefs[68] = `WIDTH'sd1410;
assign fir_coefs[69] = -`WIDTH'sd1144;
assign fir_coefs[70] = -`WIDTH'sd2512;
assign fir_coefs[71] = -`WIDTH'sd2662;
assign fir_coefs[72] = -`WIDTH'sd1877;
assign fir_coefs[73] = -`WIDTH'sd632;
assign fir_coefs[74] = `WIDTH'sd563;
assign fir_coefs[75] = `WIDTH'sd1323;
assign fir_coefs[76] = `WIDTH'sd1477;
assign fir_coefs[77] = `WIDTH'sd1084;
assign fir_coefs[78] = `WIDTH'sd377;
assign fir_coefs[79] = -`WIDTH'sd344;
assign fir_coefs[80] = -`WIDTH'sd825;
assign fir_coefs[81] = -`WIDTH'sd936;
assign fir_coefs[82] = -`WIDTH'sd696;
assign fir_coefs[83] = -`WIDTH'sd244;
assign fir_coefs[84] = `WIDTH'sd225;
assign fir_coefs[85] = `WIDTH'sd543;
assign fir_coefs[86] = `WIDTH'sd619;
assign fir_coefs[87] = `WIDTH'sd461;
assign fir_coefs[88] = `WIDTH'sd162;
assign fir_coefs[89] = -`WIDTH'sd149;
assign fir_coefs[90] = -`WIDTH'sd361;
assign fir_coefs[91] = -`WIDTH'sd411;
assign fir_coefs[92] = -`WIDTH'sd306;
assign fir_coefs[93] = -`WIDTH'sd107;
assign fir_coefs[94] = `WIDTH'sd98;
assign fir_coefs[95] = `WIDTH'sd236;
assign fir_coefs[96] = `WIDTH'sd268;
assign fir_coefs[97] = `WIDTH'sd198;
assign fir_coefs[98] = `WIDTH'sd69;
assign fir_coefs[99] = -`WIDTH'sd63;
assign fir_coefs[100] = -`WIDTH'sd150;
assign fir_coefs[101] = -`WIDTH'sd169;
assign fir_coefs[102] = -`WIDTH'sd123;
assign fir_coefs[103] = -`WIDTH'sd42;
assign fir_coefs[104] = `WIDTH'sd38;
assign fir_coefs[105] = `WIDTH'sd91;
assign fir_coefs[106] = `WIDTH'sd101;
assign fir_coefs[107] = `WIDTH'sd73;
assign fir_coefs[108] = `WIDTH'sd24;
assign fir_coefs[109] = -`WIDTH'sd22;
assign fir_coefs[110] = -`WIDTH'sd51;
assign fir_coefs[111] = -`WIDTH'sd56;
assign fir_coefs[112] = -`WIDTH'sd40;
assign fir_coefs[113] = -`WIDTH'sd13;
assign fir_coefs[114] = `WIDTH'sd11;
assign fir_coefs[115] = `WIDTH'sd26;
assign fir_coefs[116] = `WIDTH'sd28;
assign fir_coefs[117] = `WIDTH'sd19;
assign fir_coefs[118] = `WIDTH'sd6;
assign fir_coefs[119] = -`WIDTH'sd5;
assign fir_coefs[120] = -`WIDTH'sd11;
assign fir_coefs[121] = -`WIDTH'sd11;
assign fir_coefs[122] = -`WIDTH'sd7;
assign fir_coefs[123] = -`WIDTH'sd2;
assign fir_coefs[124] = `WIDTH'sd1;
assign fir_coefs[125] = `WIDTH'sd3;
assign fir_coefs[126] = `WIDTH'sd3;
assign fir_coefs[127] = `WIDTH'sd1;

endmodule
