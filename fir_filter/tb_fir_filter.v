`timescale 1ns/1ns
`define WIDTH 24


module tb_fir_filter ();


reg clk = 0;

// period = 10ns, freq = 100 MegHz
// signal period = 200us, freq = 5 MegHz
initial
    forever #5 clk = ~clk;


reg  signed [`WIDTH - 1 : 0] signal = 0;
reg ready = 0;
//wire signed [`WIDTH - 1 : 0] filtred_sig;
//wire signed [`WIDTH - 1 : 0] filtred_sig_sep;
wire signed [`WIDTH - 1 : 0] some;

socket some_socket(
    .clk (clk),

    .input_sig (signal),
    .ready (ready),
    .some (some)
);


wire signed [17 : 0] input_signal [0 : 399];
integer File_id;

initial begin
    File_id = $fopen("input.txt", "r");
end


reg [6 : 0] signal_delay = 0;

always @(posedge clk) begin
    begin
        signal_delay <= signal_delay + 1;
    
        if ( !signal_delay ) begin
            ready <= 1;

            $fscanf(File_id, "%d\n", signal); 
            
        end
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
// x = x * 255 / (max(x) - min(x)) - 3
// x = x.astype(int)
// print(max(x), min(x))
// for val in x:
//     print(f"assign input_signal[{count}] = ", end="")
//     if val < 0:
//         print(f"-`WIDTH'sd{abs(val)};")
//     else:
//         print(f"`WIDTH'sd{val};")
//     count += 1
//assign input_signal[0] = `WIDTH'sd93;
//assign input_signal[1] = `WIDTH'sd117;
//assign input_signal[2] = `WIDTH'sd109;
//assign input_signal[3] = `WIDTH'sd89;
//assign input_signal[4] = `WIDTH'sd79;
//assign input_signal[5] = `WIDTH'sd80;
//assign input_signal[6] = `WIDTH'sd88;
//assign input_signal[7] = `WIDTH'sd105;
//assign input_signal[8] = `WIDTH'sd123;
//assign input_signal[9] = `WIDTH'sd118;
//assign input_signal[10] = `WIDTH'sd87;
//assign input_signal[11] = `WIDTH'sd64;
//assign input_signal[12] = `WIDTH'sd77;
//assign input_signal[13] = `WIDTH'sd106;
//assign input_signal[14] = `WIDTH'sd114;
//assign input_signal[15] = `WIDTH'sd94;
//assign input_signal[16] = `WIDTH'sd74;
//assign input_signal[17] = `WIDTH'sd67;
//assign input_signal[18] = `WIDTH'sd65;
//assign input_signal[19] = `WIDTH'sd64;
//assign input_signal[20] = `WIDTH'sd71;
//assign input_signal[21] = `WIDTH'sd80;
//assign input_signal[22] = `WIDTH'sd70;
//assign input_signal[23] = `WIDTH'sd43;
//assign input_signal[24] = `WIDTH'sd26;
//assign input_signal[25] = `WIDTH'sd37;
//assign input_signal[26] = `WIDTH'sd54;
//assign input_signal[27] = `WIDTH'sd52;
//assign input_signal[28] = `WIDTH'sd36;
//assign input_signal[29] = `WIDTH'sd29;
//assign input_signal[30] = `WIDTH'sd30;
//assign input_signal[31] = `WIDTH'sd25;
//assign input_signal[32] = `WIDTH'sd17;
//assign input_signal[33] = `WIDTH'sd24;
//assign input_signal[34] = `WIDTH'sd39;
//assign input_signal[35] = `WIDTH'sd40;
//assign input_signal[36] = `WIDTH'sd22;
//assign input_signal[37] = `WIDTH'sd10;
//assign input_signal[38] = `WIDTH'sd18;
//assign input_signal[39] = `WIDTH'sd29;
//assign input_signal[40] = `WIDTH'sd29;
//assign input_signal[41] = `WIDTH'sd27;
//assign input_signal[42] = `WIDTH'sd33;
//assign input_signal[43] = `WIDTH'sd33;
//assign input_signal[44] = `WIDTH'sd17;
//assign input_signal[45] = `WIDTH'sd3;
//assign input_signal[46] = `WIDTH'sd14;
//assign input_signal[47] = `WIDTH'sd38;
//assign input_signal[48] = `WIDTH'sd41;
//assign input_signal[49] = `WIDTH'sd19;
//assign input_signal[50] = `WIDTH'sd0;
//assign input_signal[51] = -`WIDTH'sd2;
//assign input_signal[52] = `WIDTH'sd2;
//assign input_signal[53] = `WIDTH'sd5;
//assign input_signal[54] = `WIDTH'sd9;
//assign input_signal[55] = `WIDTH'sd12;
//assign input_signal[56] = -`WIDTH'sd2;
//assign input_signal[57] = -`WIDTH'sd34;
//assign input_signal[58] = -`WIDTH'sd50;
//assign input_signal[59] = -`WIDTH'sd31;
//assign input_signal[60] = -`WIDTH'sd5;
//assign input_signal[61] = -`WIDTH'sd9;
//assign input_signal[62] = -`WIDTH'sd41;
//assign input_signal[63] = -`WIDTH'sd67;
//assign input_signal[64] = -`WIDTH'sd70;
//assign input_signal[65] = -`WIDTH'sd62;
//assign input_signal[66] = -`WIDTH'sd53;
//assign input_signal[67] = -`WIDTH'sd45;
//assign input_signal[68] = -`WIDTH'sd46;
//assign input_signal[69] = -`WIDTH'sd69;
//assign input_signal[70] = -`WIDTH'sd99;
//assign input_signal[71] = -`WIDTH'sd101;
//assign input_signal[72] = -`WIDTH'sd70;
//assign input_signal[73] = -`WIDTH'sd43;
//assign input_signal[74] = -`WIDTH'sd52;
//assign input_signal[75] = -`WIDTH'sd83;
//assign input_signal[76] = -`WIDTH'sd99;
//assign input_signal[77] = -`WIDTH'sd90;
//assign input_signal[78] = -`WIDTH'sd74;
//assign input_signal[79] = -`WIDTH'sd62;
//assign input_signal[80] = -`WIDTH'sd54;
//assign input_signal[81] = -`WIDTH'sd56;
//assign input_signal[82] = -`WIDTH'sd76;
//assign input_signal[83] = -`WIDTH'sd96;
//assign input_signal[84] = -`WIDTH'sd87;
//assign input_signal[85] = -`WIDTH'sd55;
//assign input_signal[86] = -`WIDTH'sd37;
//assign input_signal[87] = -`WIDTH'sd54;
//assign input_signal[88] = -`WIDTH'sd80;
//assign input_signal[89] = -`WIDTH'sd85;
//assign input_signal[90] = -`WIDTH'sd75;
//assign input_signal[91] = -`WIDTH'sd67;
//assign input_signal[92] = -`WIDTH'sd66;
//assign input_signal[93] = -`WIDTH'sd62;
//assign input_signal[94] = -`WIDTH'sd64;
//assign input_signal[95] = -`WIDTH'sd83;
//assign input_signal[96] = -`WIDTH'sd101;
//assign input_signal[97] = -`WIDTH'sd96;
//assign input_signal[98] = -`WIDTH'sd75;
//assign input_signal[99] = -`WIDTH'sd70;
//assign input_signal[100] = -`WIDTH'sd88;
//assign input_signal[101] = -`WIDTH'sd103;
//assign input_signal[102] = -`WIDTH'sd102;
//assign input_signal[103] = -`WIDTH'sd99;
//assign input_signal[104] = -`WIDTH'sd105;
//assign input_signal[105] = -`WIDTH'sd107;
//assign input_signal[106] = -`WIDTH'sd96;
//assign input_signal[107] = -`WIDTH'sd89;
//assign input_signal[108] = -`WIDTH'sd102;
//assign input_signal[109] = -`WIDTH'sd119;
//assign input_signal[110] = -`WIDTH'sd117;
//assign input_signal[111] = -`WIDTH'sd99;
//assign input_signal[112] = -`WIDTH'sd90;
//assign input_signal[113] = -`WIDTH'sd92;
//assign input_signal[114] = -`WIDTH'sd92;
//assign input_signal[115] = -`WIDTH'sd88;
//assign input_signal[116] = -`WIDTH'sd92;
//assign input_signal[117] = -`WIDTH'sd101;
//assign input_signal[118] = -`WIDTH'sd91;
//assign input_signal[119] = -`WIDTH'sd63;
//assign input_signal[120] = -`WIDTH'sd46;
//assign input_signal[121] = -`WIDTH'sd60;
//assign input_signal[122] = -`WIDTH'sd81;
//assign input_signal[123] = -`WIDTH'sd79;
//assign input_signal[124] = -`WIDTH'sd58;
//assign input_signal[125] = -`WIDTH'sd41;
//assign input_signal[126] = -`WIDTH'sd35;
//assign input_signal[127] = -`WIDTH'sd33;
//assign input_signal[128] = -`WIDTH'sd38;
//assign input_signal[129] = -`WIDTH'sd53;
//assign input_signal[130] = -`WIDTH'sd62;
//assign input_signal[131] = -`WIDTH'sd43;
//assign input_signal[132] = -`WIDTH'sd9;
//assign input_signal[133] = -`WIDTH'sd1;
//assign input_signal[134] = -`WIDTH'sd29;
//assign input_signal[135] = -`WIDTH'sd57;
//assign input_signal[136] = -`WIDTH'sd55;
//assign input_signal[137] = -`WIDTH'sd32;
//assign input_signal[138] = -`WIDTH'sd16;
//assign input_signal[139] = -`WIDTH'sd14;
//assign input_signal[140] = -`WIDTH'sd20;
//assign input_signal[141] = -`WIDTH'sd34;
//assign input_signal[142] = -`WIDTH'sd53;
//assign input_signal[143] = -`WIDTH'sd56;
//assign input_signal[144] = -`WIDTH'sd29;
//assign input_signal[145] = `WIDTH'sd0;
//assign input_signal[146] = -`WIDTH'sd2;
//assign input_signal[147] = -`WIDTH'sd35;
//assign input_signal[148] = -`WIDTH'sd55;
//assign input_signal[149] = -`WIDTH'sd41;
//assign input_signal[150] = -`WIDTH'sd14;
//assign input_signal[151] = `WIDTH'sd0;
//assign input_signal[152] = `WIDTH'sd0;
//assign input_signal[153] = -`WIDTH'sd3;
//assign input_signal[154] = -`WIDTH'sd11;
//assign input_signal[155] = -`WIDTH'sd21;
//assign input_signal[156] = -`WIDTH'sd13;
//assign input_signal[157] = `WIDTH'sd17;
//assign input_signal[158] = `WIDTH'sd43;
//assign input_signal[159] = `WIDTH'sd36;
//assign input_signal[160] = `WIDTH'sd12;
//assign input_signal[161] = `WIDTH'sd7;
//assign input_signal[162] = `WIDTH'sd28;
//assign input_signal[163] = `WIDTH'sd50;
//assign input_signal[164] = `WIDTH'sd55;
//assign input_signal[165] = `WIDTH'sd56;
//assign input_signal[166] = `WIDTH'sd58;
//assign input_signal[167] = `WIDTH'sd55;
//assign input_signal[168] = `WIDTH'sd46;
//assign input_signal[169] = `WIDTH'sd49;
//assign input_signal[170] = `WIDTH'sd71;
//assign input_signal[171] = `WIDTH'sd87;
//assign input_signal[172] = `WIDTH'sd78;
//assign input_signal[173] = `WIDTH'sd59;
//assign input_signal[174] = `WIDTH'sd58;
//assign input_signal[175] = `WIDTH'sd68;
//assign input_signal[176] = `WIDTH'sd71;
//assign input_signal[177] = `WIDTH'sd67;
//assign input_signal[178] = `WIDTH'sd70;
//assign input_signal[179] = `WIDTH'sd79;
//assign input_signal[180] = `WIDTH'sd73;
//assign input_signal[181] = `WIDTH'sd53;
//assign input_signal[182] = `WIDTH'sd45;
//assign input_signal[183] = `WIDTH'sd60;
//assign input_signal[184] = `WIDTH'sd76;
//assign input_signal[185] = `WIDTH'sd72;
//assign input_signal[186] = `WIDTH'sd61;
//assign input_signal[187] = `WIDTH'sd57;
//assign input_signal[188] = `WIDTH'sd56;
//assign input_signal[189] = `WIDTH'sd51;
//assign input_signal[190] = `WIDTH'sd53;
//assign input_signal[191] = `WIDTH'sd72;
//assign input_signal[192] = `WIDTH'sd89;
//assign input_signal[193] = `WIDTH'sd79;
//assign input_signal[194] = `WIDTH'sd52;
//assign input_signal[195] = `WIDTH'sd46;
//assign input_signal[196] = `WIDTH'sd69;
//assign input_signal[197] = `WIDTH'sd94;
//assign input_signal[198] = `WIDTH'sd98;
//assign input_signal[199] = `WIDTH'sd89;
//assign input_signal[200] = `WIDTH'sd81;
//assign input_signal[201] = `WIDTH'sd75;
//assign input_signal[202] = `WIDTH'sd73;
//assign input_signal[203] = `WIDTH'sd86;
//assign input_signal[204] = `WIDTH'sd115;
//assign input_signal[205] = `WIDTH'sd127;
//assign input_signal[206] = `WIDTH'sd103;
//assign input_signal[207] = `WIDTH'sd71;
//assign input_signal[208] = `WIDTH'sd69;
//assign input_signal[209] = `WIDTH'sd98;
//assign input_signal[210] = `WIDTH'sd121;
//assign input_signal[211] = `WIDTH'sd116;
//assign input_signal[212] = `WIDTH'sd98;
//assign input_signal[213] = `WIDTH'sd82;
//assign input_signal[214] = `WIDTH'sd71;
//assign input_signal[215] = `WIDTH'sd68;
//assign input_signal[216] = `WIDTH'sd83;
//assign input_signal[217] = `WIDTH'sd104;
//assign input_signal[218] = `WIDTH'sd101;
//assign input_signal[219] = `WIDTH'sd65;
//assign input_signal[220] = `WIDTH'sd33;
//assign input_signal[221] = `WIDTH'sd38;
//assign input_signal[222] = `WIDTH'sd66;
//assign input_signal[223] = `WIDTH'sd78;
//assign input_signal[224] = `WIDTH'sd63;
//assign input_signal[225] = `WIDTH'sd42;
//assign input_signal[226] = `WIDTH'sd30;
//assign input_signal[227] = `WIDTH'sd23;
//assign input_signal[228] = `WIDTH'sd23;
//assign input_signal[229] = `WIDTH'sd38;
//assign input_signal[230] = `WIDTH'sd54;
//assign input_signal[231] = `WIDTH'sd47;
//assign input_signal[232] = `WIDTH'sd17;
//assign input_signal[233] = `WIDTH'sd0;
//assign input_signal[234] = `WIDTH'sd14;
//assign input_signal[235] = `WIDTH'sd38;
//assign input_signal[236] = `WIDTH'sd41;
//assign input_signal[237] = `WIDTH'sd29;
//assign input_signal[238] = `WIDTH'sd22;
//assign input_signal[239] = `WIDTH'sd22;
//assign input_signal[240] = `WIDTH'sd18;
//assign input_signal[241] = `WIDTH'sd15;
//assign input_signal[242] = `WIDTH'sd26;
//assign input_signal[243] = `WIDTH'sd41;
//assign input_signal[244] = `WIDTH'sd38;
//assign input_signal[245] = `WIDTH'sd18;
//assign input_signal[246] = `WIDTH'sd6;
//assign input_signal[247] = `WIDTH'sd15;
//assign input_signal[248] = `WIDTH'sd25;
//assign input_signal[249] = `WIDTH'sd21;
//assign input_signal[250] = `WIDTH'sd14;
//assign input_signal[251] = `WIDTH'sd16;
//assign input_signal[252] = `WIDTH'sd15;
//assign input_signal[253] = -`WIDTH'sd2;
//assign input_signal[254] = -`WIDTH'sd18;
//assign input_signal[255] = -`WIDTH'sd13;
//assign input_signal[256] = `WIDTH'sd3;
//assign input_signal[257] = `WIDTH'sd1;
//assign input_signal[258] = -`WIDTH'sd19;
//assign input_signal[259] = -`WIDTH'sd36;
//assign input_signal[260] = -`WIDTH'sd40;
//assign input_signal[261] = -`WIDTH'sd41;
//assign input_signal[262] = -`WIDTH'sd45;
//assign input_signal[263] = -`WIDTH'sd41;
//assign input_signal[264] = -`WIDTH'sd33;
//assign input_signal[265] = -`WIDTH'sd43;
//assign input_signal[266] = -`WIDTH'sd73;
//assign input_signal[267] = -`WIDTH'sd92;
//assign input_signal[268] = -`WIDTH'sd76;
//assign input_signal[269] = -`WIDTH'sd49;
//assign input_signal[270] = -`WIDTH'sd47;
//assign input_signal[271] = -`WIDTH'sd68;
//assign input_signal[272] = -`WIDTH'sd87;
//assign input_signal[273] = -`WIDTH'sd91;
//assign input_signal[274] = -`WIDTH'sd86;
//assign input_signal[275] = -`WIDTH'sd76;
//assign input_signal[276] = -`WIDTH'sd59;
//assign input_signal[277] = -`WIDTH'sd50;
//assign input_signal[278] = -`WIDTH'sd66;
//assign input_signal[279] = -`WIDTH'sd97;
//assign input_signal[280] = -`WIDTH'sd103;
//assign input_signal[281] = -`WIDTH'sd73;
//assign input_signal[282] = -`WIDTH'sd41;
//assign input_signal[283] = -`WIDTH'sd43;
//assign input_signal[284] = -`WIDTH'sd68;
//assign input_signal[285] = -`WIDTH'sd85;
//assign input_signal[286] = -`WIDTH'sd84;
//assign input_signal[287] = -`WIDTH'sd75;
//assign input_signal[288] = -`WIDTH'sd62;
//assign input_signal[289] = -`WIDTH'sd47;
//assign input_signal[290] = -`WIDTH'sd46;
//assign input_signal[291] = -`WIDTH'sd71;
//assign input_signal[292] = -`WIDTH'sd101;
//assign input_signal[293] = -`WIDTH'sd99;
//assign input_signal[294] = -`WIDTH'sd68;
//assign input_signal[295] = -`WIDTH'sd48;
//assign input_signal[296] = -`WIDTH'sd63;
//assign input_signal[297] = -`WIDTH'sd91;
//assign input_signal[298] = -`WIDTH'sd104;
//assign input_signal[299] = -`WIDTH'sd101;
//assign input_signal[300] = -`WIDTH'sd95;
//assign input_signal[301] = -`WIDTH'sd89;
//assign input_signal[302] = -`WIDTH'sd80;
//assign input_signal[303] = -`WIDTH'sd83;
//assign input_signal[304] = -`WIDTH'sd106;
//assign input_signal[305] = -`WIDTH'sd127;
//assign input_signal[306] = -`WIDTH'sd119;
//assign input_signal[307] = -`WIDTH'sd93;
//assign input_signal[308] = -`WIDTH'sd83;
//assign input_signal[309] = -`WIDTH'sd97;
//assign input_signal[310] = -`WIDTH'sd112;
//assign input_signal[311] = -`WIDTH'sd110;
//assign input_signal[312] = -`WIDTH'sd103;
//assign input_signal[313] = -`WIDTH'sd102;
//assign input_signal[314] = -`WIDTH'sd96;
//assign input_signal[315] = -`WIDTH'sd81;
//assign input_signal[316] = -`WIDTH'sd74;
//assign input_signal[317] = -`WIDTH'sd85;
//assign input_signal[318] = -`WIDTH'sd97;
//assign input_signal[319] = -`WIDTH'sd87;
//assign input_signal[320] = -`WIDTH'sd66;
//assign input_signal[321] = -`WIDTH'sd57;
//assign input_signal[322] = -`WIDTH'sd61;
//assign input_signal[323] = -`WIDTH'sd59;
//assign input_signal[324] = -`WIDTH'sd51;
//assign input_signal[325] = -`WIDTH'sd52;
//assign input_signal[326] = -`WIDTH'sd61;
//assign input_signal[327] = -`WIDTH'sd55;
//assign input_signal[328] = -`WIDTH'sd31;
//assign input_signal[329] = -`WIDTH'sd17;
//assign input_signal[330] = -`WIDTH'sd30;
//assign input_signal[331] = -`WIDTH'sd49;
//assign input_signal[332] = -`WIDTH'sd49;
//assign input_signal[333] = -`WIDTH'sd36;
//assign input_signal[334] = -`WIDTH'sd27;
//assign input_signal[335] = -`WIDTH'sd24;
//assign input_signal[336] = -`WIDTH'sd19;
//assign input_signal[337] = -`WIDTH'sd22;
//assign input_signal[338] = -`WIDTH'sd40;
//assign input_signal[339] = -`WIDTH'sd57;
//assign input_signal[340] = -`WIDTH'sd44;
//assign input_signal[341] = -`WIDTH'sd13;
//assign input_signal[342] = -`WIDTH'sd2;
//assign input_signal[343] = -`WIDTH'sd24;
//assign input_signal[344] = -`WIDTH'sd50;
//assign input_signal[345] = -`WIDTH'sd52;
//assign input_signal[346] = -`WIDTH'sd35;
//assign input_signal[347] = -`WIDTH'sd19;
//assign input_signal[348] = -`WIDTH'sd10;
//assign input_signal[349] = -`WIDTH'sd6;
//assign input_signal[350] = -`WIDTH'sd15;
//assign input_signal[351] = -`WIDTH'sd37;
//assign input_signal[352] = -`WIDTH'sd43;
//assign input_signal[353] = -`WIDTH'sd15;
//assign input_signal[354] = `WIDTH'sd23;
//assign input_signal[355] = `WIDTH'sd30;
//assign input_signal[356] = `WIDTH'sd4;
//assign input_signal[357] = -`WIDTH'sd16;
//assign input_signal[358] = -`WIDTH'sd6;
//assign input_signal[359] = `WIDTH'sd19;
//assign input_signal[360] = `WIDTH'sd38;
//assign input_signal[361] = `WIDTH'sd48;
//assign input_signal[362] = `WIDTH'sd50;
//assign input_signal[363] = `WIDTH'sd39;
//assign input_signal[364] = `WIDTH'sd22;
//assign input_signal[365] = `WIDTH'sd25;
//assign input_signal[366] = `WIDTH'sd58;
//assign input_signal[367] = `WIDTH'sd88;
//assign input_signal[368] = `WIDTH'sd83;
//assign input_signal[369] = `WIDTH'sd54;
//assign input_signal[370] = `WIDTH'sd41;
//assign input_signal[371] = `WIDTH'sd54;
//assign input_signal[372] = `WIDTH'sd73;
//assign input_signal[373] = `WIDTH'sd80;
//assign input_signal[374] = `WIDTH'sd80;
//assign input_signal[375] = `WIDTH'sd79;
//assign input_signal[376] = `WIDTH'sd66;
//assign input_signal[377] = `WIDTH'sd49;
//assign input_signal[378] = `WIDTH'sd51;
//assign input_signal[379] = `WIDTH'sd74;
//assign input_signal[380] = `WIDTH'sd89;
//assign input_signal[381] = `WIDTH'sd76;
//assign input_signal[382] = `WIDTH'sd53;
//assign input_signal[383] = `WIDTH'sd48;
//assign input_signal[384] = `WIDTH'sd59;
//assign input_signal[385] = `WIDTH'sd64;
//assign input_signal[386] = `WIDTH'sd61;
//assign input_signal[387] = `WIDTH'sd65;
//assign input_signal[388] = `WIDTH'sd72;
//assign input_signal[389] = `WIDTH'sd66;
//assign input_signal[390] = `WIDTH'sd50;
//assign input_signal[391] = `WIDTH'sd48;
//assign input_signal[392] = `WIDTH'sd66;
//assign input_signal[393] = `WIDTH'sd81;
//assign input_signal[394] = `WIDTH'sd77;
//assign input_signal[395] = `WIDTH'sd69;
//assign input_signal[396] = `WIDTH'sd72;
//assign input_signal[397] = `WIDTH'sd76;
//assign input_signal[398] = `WIDTH'sd73;
//assign input_signal[399] = `WIDTH'sd73;


endmodule
