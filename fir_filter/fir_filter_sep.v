`timescale 1ns/1ns
`define WIDTH 24


module fir_filter_sep (
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


reg  [2*`WIDTH-1: 0] coll_sum_pos = 0;
reg  [2*`WIDTH-1: 0] coll_sum_neg =0;

reg signed [2*`WIDTH-1 : 0] result = 0;
reg  [2*`WIDTH-1 : 0] mult = 0;

reg [6 : 0] r_index = 8'h7F;
reg [6 : 0] w_index = 0;
reg [6 : 0] del_index = 0;

reg signed [`WIDTH-1 : 0] m0;
reg signed [`WIDTH-1 : 0] m1;
reg signed [`WIDTH-1 : 0] m0_abs;
reg signed [`WIDTH-1 : 0] m1_abs;

wire  [`WIDTH-2 : 0] m0_unsigned = m0_abs[`WIDTH-2 : 0];
wire  [`WIDTH-2 : 0] m1_unsigned = m1_abs[`WIDTH-2 : 0];
reg s0,s1,mult_s;


always @(posedge clk) begin

    if ( r_index == 8'h7F && ready) begin
        result <=   $signed({1'b0,coll_sum_pos}) - $signed({1'b0,coll_sum_neg}) ;// & 18'sh3FF;
        // result <= coll_sum_pos - coll_sum_neg;
        
        w_index <= w_index + 1;
        delay[w_index] <= input_sig;
    end

    if (ready) begin
        r_index <= r_index + 1;

        del_index <= w_index - r_index - 1;

        if (r_index) begin
            m0 <=  fir_coefs[r_index];
            m1 <= delay[del_index];
            
            m0_abs <= m0[`WIDTH-1] ? -m0 : m0;
            m1_abs <= m1[`WIDTH-1] ? -m1 : m1;
            
            s0 <= m0[`WIDTH-1];
            s1 <= m1[`WIDTH-1];
            mult <= m0_unsigned * m1_unsigned ;
            mult_s <= s1 ^ s0;
            if ( mult_s )
                coll_sum_neg <= coll_sum_neg + mult;
            else
                coll_sum_pos <= coll_sum_pos + mult;
        end
        else begin
            coll_sum_pos <= 0;
            coll_sum_neg <= 0;
        end

    end
end


assign filtred_sig = result >>> 16;

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
// taps = round( (taps/max(abs(taps))) * (2**16-1))
// count = 0
// for tap in taps:
//     print(f"assign fir_coefs[{count}] = ", end="")
//     if tap < 0:
//         print(f"-`WIDTH'sd{int(abs(tap))};")
//     else:
//         print(f"`WIDTH'sd{int(tap)};")
//     count += 1
assign fir_coefs[0] = `WIDTH'sd10;
assign fir_coefs[1] = `WIDTH'sd18;
assign fir_coefs[2] = `WIDTH'sd19;
assign fir_coefs[3] = `WIDTH'sd10;
assign fir_coefs[4] = -`WIDTH'sd12;
assign fir_coefs[5] = -`WIDTH'sd40;
assign fir_coefs[6] = -`WIDTH'sd60;
assign fir_coefs[7] = -`WIDTH'sd59;
assign fir_coefs[8] = -`WIDTH'sd27;
assign fir_coefs[9] = `WIDTH'sd32;
assign fir_coefs[10] = `WIDTH'sd99;
assign fir_coefs[11] = `WIDTH'sd143;
assign fir_coefs[12] = `WIDTH'sd134;
assign fir_coefs[13] = `WIDTH'sd59;
assign fir_coefs[14] = -`WIDTH'sd68;
assign fir_coefs[15] = -`WIDTH'sd203;
assign fir_coefs[16] = -`WIDTH'sd286;
assign fir_coefs[17] = -`WIDTH'sd262;
assign fir_coefs[18] = -`WIDTH'sd113;
assign fir_coefs[19] = `WIDTH'sd127;
assign fir_coefs[20] = `WIDTH'sd372;
assign fir_coefs[21] = `WIDTH'sd514;
assign fir_coefs[22] = `WIDTH'sd463;
assign fir_coefs[23] = `WIDTH'sd197;
assign fir_coefs[24] = -`WIDTH'sd218;
assign fir_coefs[25] = -`WIDTH'sd630;
assign fir_coefs[26] = -`WIDTH'sd859;
assign fir_coefs[27] = -`WIDTH'sd765;
assign fir_coefs[28] = -`WIDTH'sd321;
assign fir_coefs[29] = `WIDTH'sd352;
assign fir_coefs[30] = `WIDTH'sd1010;
assign fir_coefs[31] = `WIDTH'sd1364;
assign fir_coefs[32] = `WIDTH'sd1205;
assign fir_coefs[33] = `WIDTH'sd502;
assign fir_coefs[34] = -`WIDTH'sd546;
assign fir_coefs[35] = -`WIDTH'sd1557;
assign fir_coefs[36] = -`WIDTH'sd2091;
assign fir_coefs[37] = -`WIDTH'sd1838;
assign fir_coefs[38] = -`WIDTH'sd762;
assign fir_coefs[39] = `WIDTH'sd827;
assign fir_coefs[40] = `WIDTH'sd2349;
assign fir_coefs[41] = `WIDTH'sd3150;
assign fir_coefs[42] = `WIDTH'sd2764;
assign fir_coefs[43] = `WIDTH'sd1146;
assign fir_coefs[44] = -`WIDTH'sd1244;
assign fir_coefs[45] = -`WIDTH'sd3541;
assign fir_coefs[46] = -`WIDTH'sd4763;
assign fir_coefs[47] = -`WIDTH'sd4199;
assign fir_coefs[48] = -`WIDTH'sd1752;
assign fir_coefs[49] = `WIDTH'sd1917;
assign fir_coefs[50] = `WIDTH'sd5513;
assign fir_coefs[51] = `WIDTH'sd7511;
assign fir_coefs[52] = `WIDTH'sd6731;
assign fir_coefs[53] = `WIDTH'sd2865;
assign fir_coefs[54] = -`WIDTH'sd3216;
assign fir_coefs[55] = -`WIDTH'sd9544;
assign fir_coefs[56] = -`WIDTH'sd13538;
assign fir_coefs[57] = -`WIDTH'sd12775;
assign fir_coefs[58] = -`WIDTH'sd5821;
assign fir_coefs[59] = `WIDTH'sd7170;
assign fir_coefs[60] = `WIDTH'sd24284;
assign fir_coefs[61] = `WIDTH'sd42219;
assign fir_coefs[62] = `WIDTH'sd57103;
assign fir_coefs[63] = `WIDTH'sd65535;
assign fir_coefs[64] = `WIDTH'sd65535;
assign fir_coefs[65] = `WIDTH'sd57103;
assign fir_coefs[66] = `WIDTH'sd42219;
assign fir_coefs[67] = `WIDTH'sd24284;
assign fir_coefs[68] = `WIDTH'sd7170;
assign fir_coefs[69] = -`WIDTH'sd5821;
assign fir_coefs[70] = -`WIDTH'sd12775;
assign fir_coefs[71] = -`WIDTH'sd13538;
assign fir_coefs[72] = -`WIDTH'sd9544;
assign fir_coefs[73] = -`WIDTH'sd3216;
assign fir_coefs[74] = `WIDTH'sd2865;
assign fir_coefs[75] = `WIDTH'sd6731;
assign fir_coefs[76] = `WIDTH'sd7511;
assign fir_coefs[77] = `WIDTH'sd5513;
assign fir_coefs[78] = `WIDTH'sd1917;
assign fir_coefs[79] = -`WIDTH'sd1752;
assign fir_coefs[80] = -`WIDTH'sd4199;
assign fir_coefs[81] = -`WIDTH'sd4763;
assign fir_coefs[82] = -`WIDTH'sd3541;
assign fir_coefs[83] = -`WIDTH'sd1244;
assign fir_coefs[84] = `WIDTH'sd1146;
assign fir_coefs[85] = `WIDTH'sd2764;
assign fir_coefs[86] = `WIDTH'sd3150;
assign fir_coefs[87] = `WIDTH'sd2349;
assign fir_coefs[88] = `WIDTH'sd827;
assign fir_coefs[89] = -`WIDTH'sd762;
assign fir_coefs[90] = -`WIDTH'sd1838;
assign fir_coefs[91] = -`WIDTH'sd2091;
assign fir_coefs[92] = -`WIDTH'sd1557;
assign fir_coefs[93] = -`WIDTH'sd546;
assign fir_coefs[94] = `WIDTH'sd502;
assign fir_coefs[95] = `WIDTH'sd1205;
assign fir_coefs[96] = `WIDTH'sd1364;
assign fir_coefs[97] = `WIDTH'sd1010;
assign fir_coefs[98] = `WIDTH'sd352;
assign fir_coefs[99] = -`WIDTH'sd321;
assign fir_coefs[100] = -`WIDTH'sd765;
assign fir_coefs[101] = -`WIDTH'sd859;
assign fir_coefs[102] = -`WIDTH'sd630;
assign fir_coefs[103] = -`WIDTH'sd218;
assign fir_coefs[104] = `WIDTH'sd197;
assign fir_coefs[105] = `WIDTH'sd463;
assign fir_coefs[106] = `WIDTH'sd514;
assign fir_coefs[107] = `WIDTH'sd372;
assign fir_coefs[108] = `WIDTH'sd127;
assign fir_coefs[109] = -`WIDTH'sd113;
assign fir_coefs[110] = -`WIDTH'sd262;
assign fir_coefs[111] = -`WIDTH'sd286;
assign fir_coefs[112] = -`WIDTH'sd203;
assign fir_coefs[113] = -`WIDTH'sd68;
assign fir_coefs[114] = `WIDTH'sd59;
assign fir_coefs[115] = `WIDTH'sd134;
assign fir_coefs[116] = `WIDTH'sd143;
assign fir_coefs[117] = `WIDTH'sd99;
assign fir_coefs[118] = `WIDTH'sd32;
assign fir_coefs[119] = -`WIDTH'sd27;
assign fir_coefs[120] = -`WIDTH'sd59;
assign fir_coefs[121] = -`WIDTH'sd60;
assign fir_coefs[122] = -`WIDTH'sd40;
assign fir_coefs[123] = -`WIDTH'sd12;
assign fir_coefs[124] = `WIDTH'sd10;
assign fir_coefs[125] = `WIDTH'sd19;
assign fir_coefs[126] = `WIDTH'sd18;
assign fir_coefs[127] = `WIDTH'sd10;


endmodule
