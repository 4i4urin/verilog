`timescale 1ns/1ns


module fir_filter_sep (
    input clk,    // Clock

    input signed  [7 : 0] input_sig,

    output signed [7 : 0] output_sig
);


reg signed [7 : 0] fir_coefs [0 : 73];
initial begin
    $readmemh("fir_coefs.txt", fir_coefs);
end



reg signed [7: 0] collection_pos [0 : 73];
reg signed [7: 0] collection_neg [0 : 73];
reg signed [7: 0] delay [0 : 73];
reg init_flag = 0;

integer i;
always @(posedge clk) begin
    if (init_flag == 0) begin
        for (i = 0; i < 74; i = i + 1) begin
            collection_pos[i] <= 0;
            collection_neg[i] <= 0;
            delay[i] <= 0;
        end
        init_flag <= 1;
    end
end


reg signed [15: 0] out_sig_pos = 0;
reg signed [15: 0] out_sig_neg = 0;
integer ii;

always @(posedge clk) begin
    delay[0] <= input_sig;
    // collection[0] <= ( (fir_coefs[0] * input_sig) / 256;
    collection_pos[0] <=
        ( ((fir_coefs[0] * input_sig) >>> 8) & 16'shFF ) & 16'sh80 ?
        0 : ( (fir_coefs[0] * input_sig) >>> 8 ) & 16'shFF ;

    collection_neg[0] <=
        ( ((fir_coefs[0] * input_sig) >>> 8) & 16'shFF ) & 16'sh80 ?
        ( ((fir_coefs[0] * input_sig) >>> 8) & 16'shFF ) + 16'sh1 : 0 ;

    for (ii = 1; ii < 74; ii = ii + 1) begin
        // collection[ii] <= ( (fir_coefs[ii] * delay[ii - 1]) / 256;
        collection_pos[ii] <=
            ( ((fir_coefs[ii] * delay[ii - 1]) >>> 8) & 16'shFF ) & 16'sh80 ?
            0 : ( (fir_coefs[ii] * delay[ii - 1]) >>> 8 ) & 16'shFF ;

        collection_neg[ii] <=
            ( ((fir_coefs[ii] * delay[ii - 1]) >>> 8) & 16'shFF ) & 16'sh80 ?
            ( ((fir_coefs[ii] * delay[ii - 1]) >>> 8) & 16'shFF ) + 16'sh1 : 0 ;

        delay[ii] <= delay[ii - 1];
    end
    

    out_sig_pos <= (
        collection_pos[ 0] + collection_pos[ 1] + collection_pos[ 2] + collection_pos[ 3] + collection_pos[ 4] + collection_pos[ 5] + collection_pos[ 6] + collection_pos[ 7] + collection_pos[ 8] + collection_pos[ 9] + 
        collection_pos[10] + collection_pos[11] + collection_pos[12] + collection_pos[13] + collection_pos[14] + collection_pos[15] + collection_pos[16] + collection_pos[17] + collection_pos[18] + collection_pos[19] + 
        collection_pos[20] + collection_pos[21] + collection_pos[22] + collection_pos[23] + collection_pos[24] + collection_pos[25] + collection_pos[26] + collection_pos[27] + collection_pos[28] + collection_pos[29] + 
        collection_pos[30] + collection_pos[31] + collection_pos[32] + collection_pos[33] + collection_pos[34] + collection_pos[35] + collection_pos[36] + collection_pos[37] + collection_pos[38] + collection_pos[39] + 
        collection_pos[40] + collection_pos[41] + collection_pos[42] + collection_pos[43] + collection_pos[44] + collection_pos[45] + collection_pos[46] + collection_pos[47] + collection_pos[48] + collection_pos[49] + 
        collection_pos[50] + collection_pos[51] + collection_pos[52] + collection_pos[53] + collection_pos[54] + collection_pos[55] + collection_pos[56] + collection_pos[57] + collection_pos[58] + collection_pos[59] + 
        collection_pos[60] + collection_pos[61] + collection_pos[62] + collection_pos[63] + collection_pos[64] + collection_pos[65] + collection_pos[66] + collection_pos[67] + collection_pos[68] + collection_pos[69] +
        collection_pos[70] + collection_pos[71] + collection_pos[72] + collection_pos[73] );

    out_sig_neg <= (
        collection_neg[ 0] + collection_neg[ 1] + collection_neg[ 2] + collection_neg[ 3] + collection_neg[ 4] + collection_neg[ 5] + collection_neg[ 6] + collection_neg[ 7] + collection_neg[ 8] + collection_neg[ 9] + 
        collection_neg[10] + collection_neg[11] + collection_neg[12] + collection_neg[13] + collection_neg[14] + collection_neg[15] + collection_neg[16] + collection_neg[17] + collection_neg[18] + collection_neg[19] + 
        collection_neg[20] + collection_neg[21] + collection_neg[22] + collection_neg[23] + collection_neg[24] + collection_neg[25] + collection_neg[26] + collection_neg[27] + collection_neg[28] + collection_neg[29] + 
        collection_neg[30] + collection_neg[31] + collection_neg[32] + collection_neg[33] + collection_neg[34] + collection_neg[35] + collection_neg[36] + collection_neg[37] + collection_neg[38] + collection_neg[39] + 
        collection_neg[40] + collection_neg[41] + collection_neg[42] + collection_neg[43] + collection_neg[44] + collection_neg[45] + collection_neg[46] + collection_neg[47] + collection_neg[48] + collection_neg[49] + 
        collection_neg[50] + collection_neg[51] + collection_neg[52] + collection_neg[53] + collection_neg[54] + collection_neg[55] + collection_neg[56] + collection_neg[57] + collection_neg[58] + collection_neg[59] + 
        collection_neg[60] + collection_neg[61] + collection_neg[62] + collection_neg[63] + collection_neg[64] + collection_neg[65] + collection_neg[66] + collection_neg[67] + collection_neg[68] + collection_neg[69] +
        collection_neg[70] + collection_neg[71] + collection_neg[72] + collection_neg[73] );

end


assign output_sig = out_sig_pos + out_sig_neg;

endmodule
