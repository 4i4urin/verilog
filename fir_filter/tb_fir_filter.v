`timescale 1ns/1ns

module tb_fir_filter ();


reg clk = 0;

// period = 10ns, freq = 100 MegHz
// signal period = 200us, freq = 5 MegHz
initial
    forever #5 clk = ~clk;


reg  signed [17 : 0] signal = 0;
reg ready = 0;
wire signed [17 : 0] filtred_sig;
wire signed [17 : 0] filtred_sig_sep;


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
            // $fdisplay(File_id, filtred_sig_sep);
            $fdisplay(File_id, filtred_sig);
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
// x = x * 255 / (max(x) - min(x)) - 3
// x = x.astype(int)
// for val in x:
//     print(f"assign input_signal[{count}] = ", end="")
//     if val < 0:
//         print(f"-18'sd{abs(val)};")
//     else:
//         print(f"18'sd{val};")
//     count += 1
assign input_signal[0] = 18'sd93;
assign input_signal[1] = 18'sd117;
assign input_signal[2] = 18'sd109;
assign input_signal[3] = 18'sd89;
assign input_signal[4] = 18'sd79;
assign input_signal[5] = 18'sd80;
assign input_signal[6] = 18'sd88;
assign input_signal[7] = 18'sd105;
assign input_signal[8] = 18'sd123;
assign input_signal[9] = 18'sd118;
assign input_signal[10] = 18'sd87;
assign input_signal[11] = 18'sd64;
assign input_signal[12] = 18'sd77;
assign input_signal[13] = 18'sd106;
assign input_signal[14] = 18'sd114;
assign input_signal[15] = 18'sd94;
assign input_signal[16] = 18'sd74;
assign input_signal[17] = 18'sd67;
assign input_signal[18] = 18'sd65;
assign input_signal[19] = 18'sd64;
assign input_signal[20] = 18'sd71;
assign input_signal[21] = 18'sd80;
assign input_signal[22] = 18'sd70;
assign input_signal[23] = 18'sd43;
assign input_signal[24] = 18'sd26;
assign input_signal[25] = 18'sd37;
assign input_signal[26] = 18'sd54;
assign input_signal[27] = 18'sd52;
assign input_signal[28] = 18'sd36;
assign input_signal[29] = 18'sd29;
assign input_signal[30] = 18'sd30;
assign input_signal[31] = 18'sd25;
assign input_signal[32] = 18'sd17;
assign input_signal[33] = 18'sd24;
assign input_signal[34] = 18'sd39;
assign input_signal[35] = 18'sd40;
assign input_signal[36] = 18'sd22;
assign input_signal[37] = 18'sd10;
assign input_signal[38] = 18'sd18;
assign input_signal[39] = 18'sd29;
assign input_signal[40] = 18'sd29;
assign input_signal[41] = 18'sd27;
assign input_signal[42] = 18'sd33;
assign input_signal[43] = 18'sd33;
assign input_signal[44] = 18'sd17;
assign input_signal[45] = 18'sd3;
assign input_signal[46] = 18'sd14;
assign input_signal[47] = 18'sd38;
assign input_signal[48] = 18'sd41;
assign input_signal[49] = 18'sd19;
assign input_signal[50] = 18'sd0;
assign input_signal[51] = -18'sd2;
assign input_signal[52] = 18'sd2;
assign input_signal[53] = 18'sd5;
assign input_signal[54] = 18'sd9;
assign input_signal[55] = 18'sd12;
assign input_signal[56] = -18'sd2;
assign input_signal[57] = -18'sd34;
assign input_signal[58] = -18'sd50;
assign input_signal[59] = -18'sd31;
assign input_signal[60] = -18'sd5;
assign input_signal[61] = -18'sd9;
assign input_signal[62] = -18'sd41;
assign input_signal[63] = -18'sd67;
assign input_signal[64] = -18'sd70;
assign input_signal[65] = -18'sd62;
assign input_signal[66] = -18'sd53;
assign input_signal[67] = -18'sd45;
assign input_signal[68] = -18'sd46;
assign input_signal[69] = -18'sd69;
assign input_signal[70] = -18'sd99;
assign input_signal[71] = -18'sd101;
assign input_signal[72] = -18'sd70;
assign input_signal[73] = -18'sd43;
assign input_signal[74] = -18'sd52;
assign input_signal[75] = -18'sd83;
assign input_signal[76] = -18'sd99;
assign input_signal[77] = -18'sd90;
assign input_signal[78] = -18'sd74;
assign input_signal[79] = -18'sd62;
assign input_signal[80] = -18'sd54;
assign input_signal[81] = -18'sd56;
assign input_signal[82] = -18'sd76;
assign input_signal[83] = -18'sd96;
assign input_signal[84] = -18'sd87;
assign input_signal[85] = -18'sd55;
assign input_signal[86] = -18'sd37;
assign input_signal[87] = -18'sd54;
assign input_signal[88] = -18'sd80;
assign input_signal[89] = -18'sd85;
assign input_signal[90] = -18'sd75;
assign input_signal[91] = -18'sd67;
assign input_signal[92] = -18'sd66;
assign input_signal[93] = -18'sd62;
assign input_signal[94] = -18'sd64;
assign input_signal[95] = -18'sd83;
assign input_signal[96] = -18'sd101;
assign input_signal[97] = -18'sd96;
assign input_signal[98] = -18'sd75;
assign input_signal[99] = -18'sd70;
assign input_signal[100] = -18'sd88;
assign input_signal[101] = -18'sd103;
assign input_signal[102] = -18'sd102;
assign input_signal[103] = -18'sd99;
assign input_signal[104] = -18'sd105;
assign input_signal[105] = -18'sd107;
assign input_signal[106] = -18'sd96;
assign input_signal[107] = -18'sd89;
assign input_signal[108] = -18'sd102;
assign input_signal[109] = -18'sd119;
assign input_signal[110] = -18'sd117;
assign input_signal[111] = -18'sd99;
assign input_signal[112] = -18'sd90;
assign input_signal[113] = -18'sd92;
assign input_signal[114] = -18'sd92;
assign input_signal[115] = -18'sd88;
assign input_signal[116] = -18'sd92;
assign input_signal[117] = -18'sd101;
assign input_signal[118] = -18'sd91;
assign input_signal[119] = -18'sd63;
assign input_signal[120] = -18'sd46;
assign input_signal[121] = -18'sd60;
assign input_signal[122] = -18'sd81;
assign input_signal[123] = -18'sd79;
assign input_signal[124] = -18'sd58;
assign input_signal[125] = -18'sd41;
assign input_signal[126] = -18'sd35;
assign input_signal[127] = -18'sd33;
assign input_signal[128] = -18'sd38;
assign input_signal[129] = -18'sd53;
assign input_signal[130] = -18'sd62;
assign input_signal[131] = -18'sd43;
assign input_signal[132] = -18'sd9;
assign input_signal[133] = -18'sd1;
assign input_signal[134] = -18'sd29;
assign input_signal[135] = -18'sd57;
assign input_signal[136] = -18'sd55;
assign input_signal[137] = -18'sd32;
assign input_signal[138] = -18'sd16;
assign input_signal[139] = -18'sd14;
assign input_signal[140] = -18'sd20;
assign input_signal[141] = -18'sd34;
assign input_signal[142] = -18'sd53;
assign input_signal[143] = -18'sd56;
assign input_signal[144] = -18'sd29;
assign input_signal[145] = 18'sd0;
assign input_signal[146] = -18'sd2;
assign input_signal[147] = -18'sd35;
assign input_signal[148] = -18'sd55;
assign input_signal[149] = -18'sd41;
assign input_signal[150] = -18'sd14;
assign input_signal[151] = 18'sd0;
assign input_signal[152] = 18'sd0;
assign input_signal[153] = -18'sd3;
assign input_signal[154] = -18'sd11;
assign input_signal[155] = -18'sd21;
assign input_signal[156] = -18'sd13;
assign input_signal[157] = 18'sd17;
assign input_signal[158] = 18'sd43;
assign input_signal[159] = 18'sd36;
assign input_signal[160] = 18'sd12;
assign input_signal[161] = 18'sd7;
assign input_signal[162] = 18'sd28;
assign input_signal[163] = 18'sd50;
assign input_signal[164] = 18'sd55;
assign input_signal[165] = 18'sd56;
assign input_signal[166] = 18'sd58;
assign input_signal[167] = 18'sd55;
assign input_signal[168] = 18'sd46;
assign input_signal[169] = 18'sd49;
assign input_signal[170] = 18'sd71;
assign input_signal[171] = 18'sd87;
assign input_signal[172] = 18'sd78;
assign input_signal[173] = 18'sd59;
assign input_signal[174] = 18'sd58;
assign input_signal[175] = 18'sd68;
assign input_signal[176] = 18'sd71;
assign input_signal[177] = 18'sd67;
assign input_signal[178] = 18'sd70;
assign input_signal[179] = 18'sd79;
assign input_signal[180] = 18'sd73;
assign input_signal[181] = 18'sd53;
assign input_signal[182] = 18'sd45;
assign input_signal[183] = 18'sd60;
assign input_signal[184] = 18'sd76;
assign input_signal[185] = 18'sd72;
assign input_signal[186] = 18'sd61;
assign input_signal[187] = 18'sd57;
assign input_signal[188] = 18'sd56;
assign input_signal[189] = 18'sd51;
assign input_signal[190] = 18'sd53;
assign input_signal[191] = 18'sd72;
assign input_signal[192] = 18'sd89;
assign input_signal[193] = 18'sd79;
assign input_signal[194] = 18'sd52;
assign input_signal[195] = 18'sd46;
assign input_signal[196] = 18'sd69;
assign input_signal[197] = 18'sd94;
assign input_signal[198] = 18'sd98;
assign input_signal[199] = 18'sd89;
assign input_signal[200] = 18'sd81;
assign input_signal[201] = 18'sd75;
assign input_signal[202] = 18'sd73;
assign input_signal[203] = 18'sd86;
assign input_signal[204] = 18'sd115;
assign input_signal[205] = 18'sd127;
assign input_signal[206] = 18'sd103;
assign input_signal[207] = 18'sd71;
assign input_signal[208] = 18'sd69;
assign input_signal[209] = 18'sd98;
assign input_signal[210] = 18'sd121;
assign input_signal[211] = 18'sd116;
assign input_signal[212] = 18'sd98;
assign input_signal[213] = 18'sd82;
assign input_signal[214] = 18'sd71;
assign input_signal[215] = 18'sd68;
assign input_signal[216] = 18'sd83;
assign input_signal[217] = 18'sd104;
assign input_signal[218] = 18'sd101;
assign input_signal[219] = 18'sd65;
assign input_signal[220] = 18'sd33;
assign input_signal[221] = 18'sd38;
assign input_signal[222] = 18'sd66;
assign input_signal[223] = 18'sd78;
assign input_signal[224] = 18'sd63;
assign input_signal[225] = 18'sd42;
assign input_signal[226] = 18'sd30;
assign input_signal[227] = 18'sd23;
assign input_signal[228] = 18'sd23;
assign input_signal[229] = 18'sd38;
assign input_signal[230] = 18'sd54;
assign input_signal[231] = 18'sd47;
assign input_signal[232] = 18'sd17;
assign input_signal[233] = 18'sd0;
assign input_signal[234] = 18'sd14;
assign input_signal[235] = 18'sd38;
assign input_signal[236] = 18'sd41;
assign input_signal[237] = 18'sd29;
assign input_signal[238] = 18'sd22;
assign input_signal[239] = 18'sd22;
assign input_signal[240] = 18'sd18;
assign input_signal[241] = 18'sd15;
assign input_signal[242] = 18'sd26;
assign input_signal[243] = 18'sd41;
assign input_signal[244] = 18'sd38;
assign input_signal[245] = 18'sd18;
assign input_signal[246] = 18'sd6;
assign input_signal[247] = 18'sd15;
assign input_signal[248] = 18'sd25;
assign input_signal[249] = 18'sd21;
assign input_signal[250] = 18'sd14;
assign input_signal[251] = 18'sd16;
assign input_signal[252] = 18'sd15;
assign input_signal[253] = -18'sd2;
assign input_signal[254] = -18'sd18;
assign input_signal[255] = -18'sd13;
assign input_signal[256] = 18'sd3;
assign input_signal[257] = 18'sd1;
assign input_signal[258] = -18'sd19;
assign input_signal[259] = -18'sd36;
assign input_signal[260] = -18'sd40;
assign input_signal[261] = -18'sd41;
assign input_signal[262] = -18'sd45;
assign input_signal[263] = -18'sd41;
assign input_signal[264] = -18'sd33;
assign input_signal[265] = -18'sd43;
assign input_signal[266] = -18'sd73;
assign input_signal[267] = -18'sd92;
assign input_signal[268] = -18'sd76;
assign input_signal[269] = -18'sd49;
assign input_signal[270] = -18'sd47;
assign input_signal[271] = -18'sd68;
assign input_signal[272] = -18'sd87;
assign input_signal[273] = -18'sd91;
assign input_signal[274] = -18'sd86;
assign input_signal[275] = -18'sd76;
assign input_signal[276] = -18'sd59;
assign input_signal[277] = -18'sd50;
assign input_signal[278] = -18'sd66;
assign input_signal[279] = -18'sd97;
assign input_signal[280] = -18'sd103;
assign input_signal[281] = -18'sd73;
assign input_signal[282] = -18'sd41;
assign input_signal[283] = -18'sd43;
assign input_signal[284] = -18'sd68;
assign input_signal[285] = -18'sd85;
assign input_signal[286] = -18'sd84;
assign input_signal[287] = -18'sd75;
assign input_signal[288] = -18'sd62;
assign input_signal[289] = -18'sd47;
assign input_signal[290] = -18'sd46;
assign input_signal[291] = -18'sd71;
assign input_signal[292] = -18'sd101;
assign input_signal[293] = -18'sd99;
assign input_signal[294] = -18'sd68;
assign input_signal[295] = -18'sd48;
assign input_signal[296] = -18'sd63;
assign input_signal[297] = -18'sd91;
assign input_signal[298] = -18'sd104;
assign input_signal[299] = -18'sd101;
assign input_signal[300] = -18'sd95;
assign input_signal[301] = -18'sd89;
assign input_signal[302] = -18'sd80;
assign input_signal[303] = -18'sd83;
assign input_signal[304] = -18'sd106;
assign input_signal[305] = -18'sd127;
assign input_signal[306] = -18'sd119;
assign input_signal[307] = -18'sd93;
assign input_signal[308] = -18'sd83;
assign input_signal[309] = -18'sd97;
assign input_signal[310] = -18'sd112;
assign input_signal[311] = -18'sd110;
assign input_signal[312] = -18'sd103;
assign input_signal[313] = -18'sd102;
assign input_signal[314] = -18'sd96;
assign input_signal[315] = -18'sd81;
assign input_signal[316] = -18'sd74;
assign input_signal[317] = -18'sd85;
assign input_signal[318] = -18'sd97;
assign input_signal[319] = -18'sd87;
assign input_signal[320] = -18'sd66;
assign input_signal[321] = -18'sd57;
assign input_signal[322] = -18'sd61;
assign input_signal[323] = -18'sd59;
assign input_signal[324] = -18'sd51;
assign input_signal[325] = -18'sd52;
assign input_signal[326] = -18'sd61;
assign input_signal[327] = -18'sd55;
assign input_signal[328] = -18'sd31;
assign input_signal[329] = -18'sd17;
assign input_signal[330] = -18'sd30;
assign input_signal[331] = -18'sd49;
assign input_signal[332] = -18'sd49;
assign input_signal[333] = -18'sd36;
assign input_signal[334] = -18'sd27;
assign input_signal[335] = -18'sd24;
assign input_signal[336] = -18'sd19;
assign input_signal[337] = -18'sd22;
assign input_signal[338] = -18'sd40;
assign input_signal[339] = -18'sd57;
assign input_signal[340] = -18'sd44;
assign input_signal[341] = -18'sd13;
assign input_signal[342] = -18'sd2;
assign input_signal[343] = -18'sd24;
assign input_signal[344] = -18'sd50;
assign input_signal[345] = -18'sd52;
assign input_signal[346] = -18'sd35;
assign input_signal[347] = -18'sd19;
assign input_signal[348] = -18'sd10;
assign input_signal[349] = -18'sd6;
assign input_signal[350] = -18'sd15;
assign input_signal[351] = -18'sd37;
assign input_signal[352] = -18'sd43;
assign input_signal[353] = -18'sd15;
assign input_signal[354] = 18'sd23;
assign input_signal[355] = 18'sd30;
assign input_signal[356] = 18'sd4;
assign input_signal[357] = -18'sd16;
assign input_signal[358] = -18'sd6;
assign input_signal[359] = 18'sd19;
assign input_signal[360] = 18'sd38;
assign input_signal[361] = 18'sd48;
assign input_signal[362] = 18'sd50;
assign input_signal[363] = 18'sd39;
assign input_signal[364] = 18'sd22;
assign input_signal[365] = 18'sd25;
assign input_signal[366] = 18'sd58;
assign input_signal[367] = 18'sd88;
assign input_signal[368] = 18'sd83;
assign input_signal[369] = 18'sd54;
assign input_signal[370] = 18'sd41;
assign input_signal[371] = 18'sd54;
assign input_signal[372] = 18'sd73;
assign input_signal[373] = 18'sd80;
assign input_signal[374] = 18'sd80;
assign input_signal[375] = 18'sd79;
assign input_signal[376] = 18'sd66;
assign input_signal[377] = 18'sd49;
assign input_signal[378] = 18'sd51;
assign input_signal[379] = 18'sd74;
assign input_signal[380] = 18'sd89;
assign input_signal[381] = 18'sd76;
assign input_signal[382] = 18'sd53;
assign input_signal[383] = 18'sd48;
assign input_signal[384] = 18'sd59;
assign input_signal[385] = 18'sd64;
assign input_signal[386] = 18'sd61;
assign input_signal[387] = 18'sd65;
assign input_signal[388] = 18'sd72;
assign input_signal[389] = 18'sd66;
assign input_signal[390] = 18'sd50;
assign input_signal[391] = 18'sd48;
assign input_signal[392] = 18'sd66;
assign input_signal[393] = 18'sd81;
assign input_signal[394] = 18'sd77;
assign input_signal[395] = 18'sd69;
assign input_signal[396] = 18'sd72;
assign input_signal[397] = 18'sd76;
assign input_signal[398] = 18'sd73;
assign input_signal[399] = 18'sd73;



endmodule
