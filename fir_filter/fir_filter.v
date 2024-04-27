`timescale 1ns/1ns
`define WIDTH 16


module fir_filter (
    input clk,    // Clock

    input signed  [`WIDTH-1 : 0] input_sig,
    input ready,

    output signed [`WIDTH-1 : 0] filtred_sig
);


(* ram_style = "block" *) wire signed [`WIDTH-1 : 0] fir_coefs [0 : 127];
(* ram_style = "block" *) reg signed [`WIDTH-1: 0] delay [0 : 127];

integer i;

//initial 
//   for (i = 0; i < 128; i = i + 1)
//       delay[i] = 0;


reg  signed [2*`WIDTH-1: 0] coll_sum = 0;

reg signed [2*`WIDTH-1 : 0] result = 0;
reg signed [2*`WIDTH-1 : 0] mult = 0;

reg [6 : 0] r_index = 8'h7F;
reg [6 : 0] w_index = 0;
reg [6 : 0] del_index = 0;

reg signed [`WIDTH-1 : 0] m0;
reg signed [`WIDTH-1 : 0] m1;

reg signed [`WIDTH-1 : 0] m0_d;
reg signed [`WIDTH-1 : 0] m1_d;


always @(posedge clk) begin

    if ( r_index == 8'h7F && ready) begin
        result <=  coll_sum  ;// & 18'sh3FF;
        
        w_index <= w_index + 1;
        delay[w_index] <= input_sig;
    end

    if (ready) begin
        r_index <= r_index + 1;
        del_index <= w_index - r_index - 1;

        if (r_index) begin
            m0 <=  fir_coefs[r_index];
            m1 <= delay[del_index];

            m0_d <= m0;
            m1_d <= m1;
            
            
            mult <= m0_d * m1_d ;
            coll_sum <= coll_sum + mult;
        end
        else begin
            coll_sum <= 0;
        end

    end
end


assign filtred_sig = result>>> 12;

// # python3
// from scipy.signal import kaiserord, firwin
// from numpy import round

// sample_rate = 100.0
// nyq_rate = sample_rate / 2.0
// width = 3.0/nyq_rate
// ripple_db = 70.0

// # Compute the order and Kaiser parameter for the FIR filter.
// N, beta = kaiserord(ripple_db, width) # N = 146 decrease to 128
// cutoff_hz = 10.0

// taps = firwin(128, cutoff_hz/nyq_rate, window=('kaiser', beta))
// taps = round( (taps/max(abs(taps))) * (2**12-1))
// count = 0
// for tap in taps:
//     print(f"assign fir_coefs[{count}] = ", end="")
//     if tap < 0:
//         print(f"-`WIDTH'sd{int(abs(tap))};")
//     else:
//         print(f"`WIDTH'sd{int(tap)};")
//     count += 1
assign fir_coefs[0] = `WIDTH'sd1;
assign fir_coefs[1] = `WIDTH'sd1;
assign fir_coefs[2] = `WIDTH'sd1;
assign fir_coefs[3] = `WIDTH'sd1;
assign fir_coefs[4] = -`WIDTH'sd1;
assign fir_coefs[5] = -`WIDTH'sd2;
assign fir_coefs[6] = -`WIDTH'sd4;
assign fir_coefs[7] = -`WIDTH'sd4;
assign fir_coefs[8] = -`WIDTH'sd2;
assign fir_coefs[9] = `WIDTH'sd2;
assign fir_coefs[10] = `WIDTH'sd6;
assign fir_coefs[11] = `WIDTH'sd9;
assign fir_coefs[12] = `WIDTH'sd8;
assign fir_coefs[13] = `WIDTH'sd4;
assign fir_coefs[14] = -`WIDTH'sd4;
assign fir_coefs[15] = -`WIDTH'sd13;
assign fir_coefs[16] = -`WIDTH'sd18;
assign fir_coefs[17] = -`WIDTH'sd16;
assign fir_coefs[18] = -`WIDTH'sd7;
assign fir_coefs[19] = `WIDTH'sd8;
assign fir_coefs[20] = `WIDTH'sd23;
assign fir_coefs[21] = `WIDTH'sd32;
assign fir_coefs[22] = `WIDTH'sd29;
assign fir_coefs[23] = `WIDTH'sd12;
assign fir_coefs[24] = -`WIDTH'sd14;
assign fir_coefs[25] = -`WIDTH'sd39;
assign fir_coefs[26] = -`WIDTH'sd54;
assign fir_coefs[27] = -`WIDTH'sd48;
assign fir_coefs[28] = -`WIDTH'sd20;
assign fir_coefs[29] = `WIDTH'sd22;
assign fir_coefs[30] = `WIDTH'sd63;
assign fir_coefs[31] = `WIDTH'sd85;
assign fir_coefs[32] = `WIDTH'sd75;
assign fir_coefs[33] = `WIDTH'sd31;
assign fir_coefs[34] = -`WIDTH'sd34;
assign fir_coefs[35] = -`WIDTH'sd97;
assign fir_coefs[36] = -`WIDTH'sd131;
assign fir_coefs[37] = -`WIDTH'sd115;
assign fir_coefs[38] = -`WIDTH'sd48;
assign fir_coefs[39] = `WIDTH'sd52;
assign fir_coefs[40] = `WIDTH'sd147;
assign fir_coefs[41] = `WIDTH'sd197;
assign fir_coefs[42] = `WIDTH'sd173;
assign fir_coefs[43] = `WIDTH'sd72;
assign fir_coefs[44] = -`WIDTH'sd78;
assign fir_coefs[45] = -`WIDTH'sd221;
assign fir_coefs[46] = -`WIDTH'sd298;
assign fir_coefs[47] = -`WIDTH'sd262;
assign fir_coefs[48] = -`WIDTH'sd109;
assign fir_coefs[49] = `WIDTH'sd120;
assign fir_coefs[50] = `WIDTH'sd344;
assign fir_coefs[51] = `WIDTH'sd469;
assign fir_coefs[52] = `WIDTH'sd421;
assign fir_coefs[53] = `WIDTH'sd179;
assign fir_coefs[54] = -`WIDTH'sd201;
assign fir_coefs[55] = -`WIDTH'sd596;
assign fir_coefs[56] = -`WIDTH'sd846;
assign fir_coefs[57] = -`WIDTH'sd798;
assign fir_coefs[58] = -`WIDTH'sd364;
assign fir_coefs[59] = `WIDTH'sd448;
assign fir_coefs[60] = `WIDTH'sd1517;
assign fir_coefs[61] = `WIDTH'sd2638;
assign fir_coefs[62] = `WIDTH'sd3568;
assign fir_coefs[63] = `WIDTH'sd4095;
assign fir_coefs[64] = `WIDTH'sd4095;
assign fir_coefs[65] = `WIDTH'sd3568;
assign fir_coefs[66] = `WIDTH'sd2638;
assign fir_coefs[67] = `WIDTH'sd1517;
assign fir_coefs[68] = `WIDTH'sd448;
assign fir_coefs[69] = -`WIDTH'sd364;
assign fir_coefs[70] = -`WIDTH'sd798;
assign fir_coefs[71] = -`WIDTH'sd846;
assign fir_coefs[72] = -`WIDTH'sd596;
assign fir_coefs[73] = -`WIDTH'sd201;
assign fir_coefs[74] = `WIDTH'sd179;
assign fir_coefs[75] = `WIDTH'sd421;
assign fir_coefs[76] = `WIDTH'sd469;
assign fir_coefs[77] = `WIDTH'sd344;
assign fir_coefs[78] = `WIDTH'sd120;
assign fir_coefs[79] = -`WIDTH'sd109;
assign fir_coefs[80] = -`WIDTH'sd262;
assign fir_coefs[81] = -`WIDTH'sd298;
assign fir_coefs[82] = -`WIDTH'sd221;
assign fir_coefs[83] = -`WIDTH'sd78;
assign fir_coefs[84] = `WIDTH'sd72;
assign fir_coefs[85] = `WIDTH'sd173;
assign fir_coefs[86] = `WIDTH'sd197;
assign fir_coefs[87] = `WIDTH'sd147;
assign fir_coefs[88] = `WIDTH'sd52;
assign fir_coefs[89] = -`WIDTH'sd48;
assign fir_coefs[90] = -`WIDTH'sd115;
assign fir_coefs[91] = -`WIDTH'sd131;
assign fir_coefs[92] = -`WIDTH'sd97;
assign fir_coefs[93] = -`WIDTH'sd34;
assign fir_coefs[94] = `WIDTH'sd31;
assign fir_coefs[95] = `WIDTH'sd75;
assign fir_coefs[96] = `WIDTH'sd85;
assign fir_coefs[97] = `WIDTH'sd63;
assign fir_coefs[98] = `WIDTH'sd22;
assign fir_coefs[99] = -`WIDTH'sd20;
assign fir_coefs[100] = -`WIDTH'sd48;
assign fir_coefs[101] = -`WIDTH'sd54;
assign fir_coefs[102] = -`WIDTH'sd39;
assign fir_coefs[103] = -`WIDTH'sd14;
assign fir_coefs[104] = `WIDTH'sd12;
assign fir_coefs[105] = `WIDTH'sd29;
assign fir_coefs[106] = `WIDTH'sd32;
assign fir_coefs[107] = `WIDTH'sd23;
assign fir_coefs[108] = `WIDTH'sd8;
assign fir_coefs[109] = -`WIDTH'sd7;
assign fir_coefs[110] = -`WIDTH'sd16;
assign fir_coefs[111] = -`WIDTH'sd18;
assign fir_coefs[112] = -`WIDTH'sd13;
assign fir_coefs[113] = -`WIDTH'sd4;
assign fir_coefs[114] = `WIDTH'sd4;
assign fir_coefs[115] = `WIDTH'sd8;
assign fir_coefs[116] = `WIDTH'sd9;
assign fir_coefs[117] = `WIDTH'sd6;
assign fir_coefs[118] = `WIDTH'sd2;
assign fir_coefs[119] = -`WIDTH'sd2;
assign fir_coefs[120] = -`WIDTH'sd4;
assign fir_coefs[121] = -`WIDTH'sd4;
assign fir_coefs[122] = -`WIDTH'sd2;
assign fir_coefs[123] = -`WIDTH'sd1;
assign fir_coefs[124] = `WIDTH'sd1;
assign fir_coefs[125] = `WIDTH'sd1;
assign fir_coefs[126] = `WIDTH'sd1;
assign fir_coefs[127] = `WIDTH'sd1;



endmodule
