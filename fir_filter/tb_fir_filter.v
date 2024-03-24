`timescale 1ns/1ns
`define WIDTH 20


module tb_fir_filter ();


reg clk = 0;

// period = 10ns, freq = 100 MegHz
// signal period = 200us, freq = 5 MegHz
initial
    forever #5 clk = ~clk;


reg  signed [`WIDTH - 1 : 0] signal = 0;
reg ready = 0;
wire signed [`WIDTH - 1 : 0] filtred_sig;
wire signed [`WIDTH - 1 : 0] filtred_sig_sep;


socket some_socket(
    .clk (clk),

    .input_sig (signal),
    .ready (ready),

    .filtred_sig(filtred_sig),
    .filtred_sig_sep(filtred_sig_sep)
);


wire signed [17 : 0] input_signal [0 : 399];
integer File_id;
initial begin
    File_id = $fopen("output_verilog", "w");
    // $readmemh("signal.txt", input_signal);
end


reg [15: 0] index = 0;
reg [6 : 0] signal_delay = 0;

always @(posedge clk) begin
    if (index < 400) begin
        signal_delay <= signal_delay + 1;
    
        if ( !signal_delay ) begin
            ready <= 1;
            signal <= input_signal[index];
            index <= index + 1;
            $fdisplay(File_id, filtred_sig_sep);
            // $fdisplay(File_id, filtred_sig);
        end
    end
    else begin
        if (ready) begin
            $display("Ready");
            $fclose(File_id);
        end
            
        signal <= 0;
        ready <= 0;
    end
end


initial
begin
    $dumpfile("test_fir.vcd");
    $dumpvars;
end

// # python 3
// from numpy import cos, sin, pi, absolute, arange

// sample_rate = 100.0
// nsamples = 400
// count = 0
// t = arange(nsamples) / sample_rate
// x = cos(2*pi*0.5*t) + 0.2*sin(2*pi*2.5*t+0.1) + \
//         0.2*sin(2*pi*15.3*t) + 0.1*sin(2*pi*16.7*t + 0.1) + \
//             0.1*sin(2*pi*23.45*t+.8)
// x = x * 65535 / (max(x) - min(x)) - 695
// x = x.astype(int)
// print(max(x), min(x))
// for val in x:
//     print(f"assign input_signal[{count}] = ", end="")
//     if val < 0:
//         print(f"-`WIDTH'sd{abs(val)};")
//     else:
//         print(f"`WIDTH'sd{val};")
//     count += 1
assign input_signal[0] = `WIDTH'sd24086;
assign input_signal[1] = `WIDTH'sd30389;
assign input_signal[2] = `WIDTH'sd28328;
assign input_signal[3] = `WIDTH'sd23073;
assign input_signal[4] = `WIDTH'sd20544;
assign input_signal[5] = `WIDTH'sd20853;
assign input_signal[6] = `WIDTH'sd22840;
assign input_signal[7] = `WIDTH'sd27220;
assign input_signal[8] = `WIDTH'sd31777;
assign input_signal[9] = `WIDTH'sd30514;
assign input_signal[10] = `WIDTH'sd22650;
assign input_signal[11] = `WIDTH'sd16751;
assign input_signal[12] = `WIDTH'sd19949;
assign input_signal[13] = `WIDTH'sd27507;
assign input_signal[14] = `WIDTH'sd29505;
assign input_signal[15] = `WIDTH'sd24444;
assign input_signal[16] = `WIDTH'sd19100;
assign input_signal[17] = `WIDTH'sd17328;
assign input_signal[18] = `WIDTH'sd16898;
assign input_signal[19] = `WIDTH'sd16651;
assign input_signal[20] = `WIDTH'sd18428;
assign input_signal[21] = `WIDTH'sd20709;
assign input_signal[22] = `WIDTH'sd18282;
assign input_signal[23] = `WIDTH'sd11155;
assign input_signal[24] = `WIDTH'sd6827;
assign input_signal[25] = `WIDTH'sd9671;
assign input_signal[26] = `WIDTH'sd14169;
assign input_signal[27] = `WIDTH'sd13511;
assign input_signal[28] = `WIDTH'sd9434;
assign input_signal[29] = `WIDTH'sd7606;
assign input_signal[30] = `WIDTH'sd7920;
assign input_signal[31] = `WIDTH'sd6567;
assign input_signal[32] = `WIDTH'sd4585;
assign input_signal[33] = `WIDTH'sd6275;
assign input_signal[34] = `WIDTH'sd10294;
assign input_signal[35] = `WIDTH'sd10436;
assign input_signal[36] = `WIDTH'sd5832;
assign input_signal[37] = `WIDTH'sd2786;
assign input_signal[38] = `WIDTH'sd4741;
assign input_signal[39] = `WIDTH'sd7561;
assign input_signal[40] = `WIDTH'sd7560;
assign input_signal[41] = `WIDTH'sd7223;
assign input_signal[42] = `WIDTH'sd8813;
assign input_signal[43] = `WIDTH'sd8808;
assign input_signal[44] = `WIDTH'sd4499;
assign input_signal[45] = `WIDTH'sd863;
assign input_signal[46] = `WIDTH'sd3790;
assign input_signal[47] = `WIDTH'sd9929;
assign input_signal[48] = `WIDTH'sd10803;
assign input_signal[49] = `WIDTH'sd5205;
assign input_signal[50] = `WIDTH'sd20;
assign input_signal[51] = -`WIDTH'sd596;
assign input_signal[52] = `WIDTH'sd671;
assign input_signal[53] = `WIDTH'sd1376;
assign input_signal[54] = `WIDTH'sd2627;
assign input_signal[55] = `WIDTH'sd3416;
assign input_signal[56] = -`WIDTH'sd601;
assign input_signal[57] = -`WIDTH'sd8796;
assign input_signal[58] = -`WIDTH'sd12909;
assign input_signal[59] = -`WIDTH'sd8125;
assign input_signal[60] = -`WIDTH'sd1393;
assign input_signal[61] = -`WIDTH'sd2471;
assign input_signal[62] = -`WIDTH'sd10695;
assign input_signal[63] = -`WIDTH'sd17338;
assign input_signal[64] = -`WIDTH'sd18075;
assign input_signal[65] = -`WIDTH'sd15903;
assign input_signal[66] = -`WIDTH'sd13658;
assign input_signal[67] = -`WIDTH'sd11587;
assign input_signal[68] = -`WIDTH'sd11970;
assign input_signal[69] = -`WIDTH'sd17848;
assign input_signal[70] = -`WIDTH'sd25504;
assign input_signal[71] = -`WIDTH'sd26072;
assign input_signal[72] = -`WIDTH'sd17981;
assign input_signal[73] = -`WIDTH'sd11010;
assign input_signal[74] = -`WIDTH'sd13525;
assign input_signal[75] = -`WIDTH'sd21510;
assign input_signal[76] = -`WIDTH'sd25475;
assign input_signal[77] = -`WIDTH'sd23147;
assign input_signal[78] = -`WIDTH'sd19105;
assign input_signal[79] = -`WIDTH'sd16054;
assign input_signal[80] = -`WIDTH'sd13835;
assign input_signal[81] = -`WIDTH'sd14394;
assign input_signal[82] = -`WIDTH'sd19571;
assign input_signal[83] = -`WIDTH'sd24680;
assign input_signal[84] = -`WIDTH'sd22407;
assign input_signal[85] = -`WIDTH'sd14105;
assign input_signal[86] = -`WIDTH'sd9670;
assign input_signal[87] = -`WIDTH'sd14005;
assign input_signal[88] = -`WIDTH'sd20631;
assign input_signal[89] = -`WIDTH'sd21966;
assign input_signal[90] = -`WIDTH'sd19199;
assign input_signal[91] = -`WIDTH'sd17383;
assign input_signal[92] = -`WIDTH'sd16900;
assign input_signal[93] = -`WIDTH'sd15939;
assign input_signal[94] = -`WIDTH'sd16613;
assign input_signal[95] = -`WIDTH'sd21309;
assign input_signal[96] = -`WIDTH'sd25965;
assign input_signal[97] = -`WIDTH'sd24647;
assign input_signal[98] = -`WIDTH'sd19422;
assign input_signal[99] = -`WIDTH'sd18134;
assign input_signal[100] = -`WIDTH'sd22607;
assign input_signal[101] = -`WIDTH'sd26603;
assign input_signal[102] = -`WIDTH'sd26394;
assign input_signal[103] = -`WIDTH'sd25604;
assign input_signal[104] = -`WIDTH'sd27085;
assign input_signal[105] = -`WIDTH'sd27564;
assign input_signal[106] = -`WIDTH'sd24692;
assign input_signal[107] = -`WIDTH'sd22861;
assign input_signal[108] = -`WIDTH'sd26182;
assign input_signal[109] = -`WIDTH'sd30694;
assign input_signal[110] = -`WIDTH'sd30083;
assign input_signal[111] = -`WIDTH'sd25548;
assign input_signal[112] = -`WIDTH'sd23124;
assign input_signal[113] = -`WIDTH'sd23824;
assign input_signal[114] = -`WIDTH'sd23784;
assign input_signal[115] = -`WIDTH'sd22639;
assign input_signal[116] = -`WIDTH'sd23740;
assign input_signal[117] = -`WIDTH'sd25948;
assign input_signal[118] = -`WIDTH'sd23506;
assign input_signal[119] = -`WIDTH'sd16205;
assign input_signal[120] = -`WIDTH'sd11967;
assign input_signal[121] = -`WIDTH'sd15500;
assign input_signal[122] = -`WIDTH'sd20909;
assign input_signal[123] = -`WIDTH'sd20415;
assign input_signal[124] = -`WIDTH'sd14943;
assign input_signal[125] = -`WIDTH'sd10530;
assign input_signal[126] = -`WIDTH'sd8977;
assign input_signal[127] = -`WIDTH'sd8486;
assign input_signal[128] = -`WIDTH'sd9727;
assign input_signal[129] = -`WIDTH'sd13725;
assign input_signal[130] = -`WIDTH'sd15990;
assign input_signal[131] = -`WIDTH'sd11034;
assign input_signal[132] = -`WIDTH'sd2460;
assign input_signal[133] = -`WIDTH'sd419;
assign input_signal[134] = -`WIDTH'sd7539;
assign input_signal[135] = -`WIDTH'sd14815;
assign input_signal[136] = -`WIDTH'sd14163;
assign input_signal[137] = -`WIDTH'sd8218;
assign input_signal[138] = -`WIDTH'sd4047;
assign input_signal[139] = -`WIDTH'sd3571;
assign input_signal[140] = -`WIDTH'sd5155;
assign input_signal[141] = -`WIDTH'sd8871;
assign input_signal[142] = -`WIDTH'sd13774;
assign input_signal[143] = -`WIDTH'sd14396;
assign input_signal[144] = -`WIDTH'sd7501;
assign input_signal[145] = `WIDTH'sd303;
assign input_signal[146] = -`WIDTH'sd531;
assign input_signal[147] = -`WIDTH'sd8950;
assign input_signal[148] = -`WIDTH'sd14223;
assign input_signal[149] = -`WIDTH'sd10601;
assign input_signal[150] = -`WIDTH'sd3527;
assign input_signal[151] = `WIDTH'sd93;
assign input_signal[152] = `WIDTH'sd188;
assign input_signal[153] = -`WIDTH'sd764;
assign input_signal[154] = -`WIDTH'sd2934;
assign input_signal[155] = -`WIDTH'sd5371;
assign input_signal[156] = -`WIDTH'sd3311;
assign input_signal[157] = `WIDTH'sd4633;
assign input_signal[158] = `WIDTH'sd11263;
assign input_signal[159] = `WIDTH'sd9533;
assign input_signal[160] = `WIDTH'sd3231;
assign input_signal[161] = `WIDTH'sd1921;
assign input_signal[162] = `WIDTH'sd7469;
assign input_signal[163] = `WIDTH'sd13043;
assign input_signal[164] = `WIDTH'sd14462;
assign input_signal[165] = `WIDTH'sd14490;
assign input_signal[166] = `WIDTH'sd15226;
assign input_signal[167] = `WIDTH'sd14447;
assign input_signal[168] = `WIDTH'sd12095;
assign input_signal[169] = `WIDTH'sd12917;
assign input_signal[170] = `WIDTH'sd18430;
assign input_signal[171] = `WIDTH'sd22516;
assign input_signal[172] = `WIDTH'sd20175;
assign input_signal[173] = `WIDTH'sd15473;
assign input_signal[174] = `WIDTH'sd14993;
assign input_signal[175] = `WIDTH'sd17795;
assign input_signal[176] = `WIDTH'sd18563;
assign input_signal[177] = `WIDTH'sd17305;
assign input_signal[178] = `WIDTH'sd18166;
assign input_signal[179] = `WIDTH'sd20403;
assign input_signal[180] = `WIDTH'sd18886;
assign input_signal[181] = `WIDTH'sd13818;
assign input_signal[182] = `WIDTH'sd11878;
assign input_signal[183] = `WIDTH'sd15731;
assign input_signal[184] = `WIDTH'sd19667;
assign input_signal[185] = `WIDTH'sd18764;
assign input_signal[186] = `WIDTH'sd15755;
assign input_signal[187] = `WIDTH'sd14816;
assign input_signal[188] = `WIDTH'sd14714;
assign input_signal[189] = `WIDTH'sd13390;
assign input_signal[190] = `WIDTH'sd13839;
assign input_signal[191] = `WIDTH'sd18695;
assign input_signal[192] = `WIDTH'sd23048;
assign input_signal[193] = `WIDTH'sd20385;
assign input_signal[194] = `WIDTH'sd13563;
assign input_signal[195] = `WIDTH'sd11928;
assign input_signal[196] = `WIDTH'sd17962;
assign input_signal[197] = `WIDTH'sd24416;
assign input_signal[198] = `WIDTH'sd25427;
assign input_signal[199] = `WIDTH'sd23082;
assign input_signal[200] = `WIDTH'sd21121;
assign input_signal[201] = `WIDTH'sd19557;
assign input_signal[202] = `WIDTH'sd18862;
assign input_signal[203] = `WIDTH'sd22406;
assign input_signal[204] = `WIDTH'sd29632;
assign input_signal[205] = `WIDTH'sd32767;
assign input_signal[206] = `WIDTH'sd26789;
assign input_signal[207] = `WIDTH'sd18386;
assign input_signal[208] = `WIDTH'sd17933;
assign input_signal[209] = `WIDTH'sd25365;
assign input_signal[210] = `WIDTH'sd31226;
assign input_signal[211] = `WIDTH'sd30072;
assign input_signal[212] = `WIDTH'sd25293;
assign input_signal[213] = `WIDTH'sd21209;
assign input_signal[214] = `WIDTH'sd18363;
assign input_signal[215] = `WIDTH'sd17739;
assign input_signal[216] = `WIDTH'sd21589;
assign input_signal[217] = `WIDTH'sd27028;
assign input_signal[218] = `WIDTH'sd26134;
assign input_signal[219] = `WIDTH'sd17017;
assign input_signal[220] = `WIDTH'sd8805;
assign input_signal[221] = `WIDTH'sd10065;
assign input_signal[222] = `WIDTH'sd17148;
assign input_signal[223] = `WIDTH'sd20125;
assign input_signal[224] = `WIDTH'sd16335;
assign input_signal[225] = `WIDTH'sd11118;
assign input_signal[226] = `WIDTH'sd8037;
assign input_signal[227] = `WIDTH'sd6242;
assign input_signal[228] = `WIDTH'sd6234;
assign input_signal[229] = `WIDTH'sd9896;
assign input_signal[230] = `WIDTH'sd14101;
assign input_signal[231] = `WIDTH'sd12262;
assign input_signal[232] = `WIDTH'sd4667;
assign input_signal[233] = `WIDTH'sd112;
assign input_signal[234] = `WIDTH'sd3779;
assign input_signal[235] = `WIDTH'sd9897;
assign input_signal[236] = `WIDTH'sd10853;
assign input_signal[237] = `WIDTH'sd7675;
assign input_signal[238] = `WIDTH'sd5850;
assign input_signal[239] = `WIDTH'sd5847;
assign input_signal[240] = `WIDTH'sd4798;
assign input_signal[241] = `WIDTH'sd3996;
assign input_signal[242] = `WIDTH'sd6822;
assign input_signal[243] = `WIDTH'sd10858;
assign input_signal[244] = `WIDTH'sd10046;
assign input_signal[245] = `WIDTH'sd4702;
assign input_signal[246] = `WIDTH'sd1809;
assign input_signal[247] = `WIDTH'sd4182;
assign input_signal[248] = `WIDTH'sd6696;
assign input_signal[249] = `WIDTH'sd5517;
assign input_signal[250] = `WIDTH'sd3792;
assign input_signal[251] = `WIDTH'sd4418;
assign input_signal[252] = `WIDTH'sd3994;
assign input_signal[253] = -`WIDTH'sd524;
assign input_signal[254] = -`WIDTH'sd4772;
assign input_signal[255] = -`WIDTH'sd3298;
assign input_signal[256] = `WIDTH'sd931;
assign input_signal[257] = `WIDTH'sd585;
assign input_signal[258] = -`WIDTH'sd4880;
assign input_signal[259] = -`WIDTH'sd9408;
assign input_signal[260] = -`WIDTH'sd10341;
assign input_signal[261] = -`WIDTH'sd10693;
assign input_signal[262] = -`WIDTH'sd11613;
assign input_signal[263] = -`WIDTH'sd10576;
assign input_signal[264] = -`WIDTH'sd8581;
assign input_signal[265] = -`WIDTH'sd11182;
assign input_signal[266] = -`WIDTH'sd18883;
assign input_signal[267] = -`WIDTH'sd23581;
assign input_signal[268] = -`WIDTH'sd19634;
assign input_signal[269] = -`WIDTH'sd12748;
assign input_signal[270] = -`WIDTH'sd12023;
assign input_signal[271] = -`WIDTH'sd17585;
assign input_signal[272] = -`WIDTH'sd22507;
assign input_signal[273] = -`WIDTH'sd23437;
assign input_signal[274] = -`WIDTH'sd22255;
assign input_signal[275] = -`WIDTH'sd19707;
assign input_signal[276] = -`WIDTH'sd15318;
assign input_signal[277] = -`WIDTH'sd12788;
assign input_signal[278] = -`WIDTH'sd17088;
assign input_signal[279] = -`WIDTH'sd25030;
assign input_signal[280] = -`WIDTH'sd26649;
assign input_signal[281] = -`WIDTH'sd18835;
assign input_signal[282] = -`WIDTH'sd10624;
assign input_signal[283] = -`WIDTH'sd10989;
assign input_signal[284] = -`WIDTH'sd17521;
assign input_signal[285] = -`WIDTH'sd22017;
assign input_signal[286] = -`WIDTH'sd21757;
assign input_signal[287] = -`WIDTH'sd19323;
assign input_signal[288] = -`WIDTH'sd15921;
assign input_signal[289] = -`WIDTH'sd12099;
assign input_signal[290] = -`WIDTH'sd11920;
assign input_signal[291] = -`WIDTH'sd18387;
assign input_signal[292] = -`WIDTH'sd25931;
assign input_signal[293] = -`WIDTH'sd25484;
assign input_signal[294] = -`WIDTH'sd17502;
assign input_signal[295] = -`WIDTH'sd12365;
assign input_signal[296] = -`WIDTH'sd16199;
assign input_signal[297] = -`WIDTH'sd23537;
assign input_signal[298] = -`WIDTH'sd26780;
assign input_signal[299] = -`WIDTH'sd25881;
assign input_signal[300] = -`WIDTH'sd24465;
assign input_signal[301] = -`WIDTH'sd22834;
assign input_signal[302] = -`WIDTH'sd20674;
assign input_signal[303] = -`WIDTH'sd21504;
assign input_signal[304] = -`WIDTH'sd27402;
assign input_signal[305] = -`WIDTH'sd32767;
assign input_signal[306] = -`WIDTH'sd30746;
assign input_signal[307] = -`WIDTH'sd23931;
assign input_signal[308] = -`WIDTH'sd21255;
assign input_signal[309] = -`WIDTH'sd25060;
assign input_signal[310] = -`WIDTH'sd28862;
assign input_signal[311] = -`WIDTH'sd28320;
assign input_signal[312] = -`WIDTH'sd26496;
assign input_signal[313] = -`WIDTH'sd26186;
assign input_signal[314] = -`WIDTH'sd24834;
assign input_signal[315] = -`WIDTH'sd20974;
assign input_signal[316] = -`WIDTH'sd18957;
assign input_signal[317] = -`WIDTH'sd21838;
assign input_signal[318] = -`WIDTH'sd24920;
assign input_signal[319] = -`WIDTH'sd22508;
assign input_signal[320] = -`WIDTH'sd16994;
assign input_signal[321] = -`WIDTH'sd14660;
assign input_signal[322] = -`WIDTH'sd15618;
assign input_signal[323] = -`WIDTH'sd15176;
assign input_signal[324] = -`WIDTH'sd13102;
assign input_signal[325] = -`WIDTH'sd13485;
assign input_signal[326] = -`WIDTH'sd15753;
assign input_signal[327] = -`WIDTH'sd14194;
assign input_signal[328] = -`WIDTH'sd8086;
assign input_signal[329] = -`WIDTH'sd4506;
assign input_signal[330] = -`WIDTH'sd7732;
assign input_signal[331] = -`WIDTH'sd12588;
assign input_signal[332] = -`WIDTH'sd12644;
assign input_signal[333] = -`WIDTH'sd9189;
assign input_signal[334] = -`WIDTH'sd6957;
assign input_signal[335] = -`WIDTH'sd6173;
assign input_signal[336] = -`WIDTH'sd5019;
assign input_signal[337] = -`WIDTH'sd5667;
assign input_signal[338] = -`WIDTH'sd10418;
assign input_signal[339] = -`WIDTH'sd14592;
assign input_signal[340] = -`WIDTH'sd11444;
assign input_signal[341] = -`WIDTH'sd3424;
assign input_signal[342] = -`WIDTH'sd469;
assign input_signal[343] = -`WIDTH'sd6128;
assign input_signal[344] = -`WIDTH'sd12875;
assign input_signal[345] = -`WIDTH'sd13316;
assign input_signal[346] = -`WIDTH'sd9016;
assign input_signal[347] = -`WIDTH'sd5045;
assign input_signal[348] = -`WIDTH'sd2586;
assign input_signal[349] = -`WIDTH'sd1488;
assign input_signal[350] = -`WIDTH'sd3934;
assign input_signal[351] = -`WIDTH'sd9441;
assign input_signal[352] = -`WIDTH'sd11058;
assign input_signal[353] = -`WIDTH'sd3827;
assign input_signal[354] = `WIDTH'sd6008;
assign input_signal[355] = `WIDTH'sd7832;
assign input_signal[356] = `WIDTH'sd1174;
assign input_signal[357] = -`WIDTH'sd4076;
assign input_signal[358] = -`WIDTH'sd1572;
assign input_signal[359] = `WIDTH'sd4971;
assign input_signal[360] = `WIDTH'sd9909;
assign input_signal[361] = `WIDTH'sd12463;
assign input_signal[362] = `WIDTH'sd13002;
assign input_signal[363] = `WIDTH'sd10123;
assign input_signal[364] = `WIDTH'sd5759;
assign input_signal[365] = `WIDTH'sd6661;
assign input_signal[366] = `WIDTH'sd15047;
assign input_signal[367] = `WIDTH'sd22805;
assign input_signal[368] = `WIDTH'sd21433;
assign input_signal[369] = `WIDTH'sd14034;
assign input_signal[370] = `WIDTH'sd10614;
assign input_signal[371] = `WIDTH'sd14186;
assign input_signal[372] = `WIDTH'sd18949;
assign input_signal[373] = `WIDTH'sd20687;
assign input_signal[374] = `WIDTH'sd20887;
assign input_signal[375] = `WIDTH'sd20388;
assign input_signal[376] = `WIDTH'sd17222;
assign input_signal[377] = `WIDTH'sd12899;
assign input_signal[378] = `WIDTH'sd13222;
assign input_signal[379] = `WIDTH'sd19105;
assign input_signal[380] = `WIDTH'sd23101;
assign input_signal[381] = `WIDTH'sd19737;
assign input_signal[382] = `WIDTH'sd13726;
assign input_signal[383] = `WIDTH'sd12470;
assign input_signal[384] = `WIDTH'sd15297;
assign input_signal[385] = `WIDTH'sd16629;
assign input_signal[386] = `WIDTH'sd15915;
assign input_signal[387] = `WIDTH'sd16792;
assign input_signal[388] = `WIDTH'sd18604;
assign input_signal[389] = `WIDTH'sd17038;
assign input_signal[390] = `WIDTH'sd12952;
assign input_signal[391] = `WIDTH'sd12542;
assign input_signal[392] = `WIDTH'sd17293;
assign input_signal[393] = `WIDTH'sd21131;
assign input_signal[394] = `WIDTH'sd20094;
assign input_signal[395] = `WIDTH'sd17943;
assign input_signal[396] = `WIDTH'sd18642;
assign input_signal[397] = `WIDTH'sd19859;
assign input_signal[398] = `WIDTH'sd18856;
assign input_signal[399] = `WIDTH'sd18923;



endmodule
