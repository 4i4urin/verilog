`timescale 1ns/1ns


module fir_filter (
    input clk,    // Clock

    input signed  [7 : 0] input_sig,

    output signed [7 : 0] output_sig
);


reg signed [7 : 0] fir_coefs [0 : 73];
initial begin
    $readmemh("fir_coefs.txt", fir_coefs);
end



reg signed [17: 0] collection [0 : 73];
reg signed [7: 0] delay [0 : 73];
reg init_flag = 0;

integer i;
always @(posedge clk) begin
    if (init_flag == 0) begin
        for (i = 0; i < 74; i = i + 1) begin
            collection[i] <= 0;
            delay[i] <= 0;
        end
        init_flag <= 1;
    end
end


reg signed [7: 0] out_sig = 0;

integer ii;

always @(posedge clk) begin
    delay[0] <= input_sig;
    collection[0] <= fir_coefs[0] * input_sig ;

    for (ii = 1; ii < 74; ii = ii + 1) begin
        collection[ii] <= fir_coefs[ii] * delay[ii - 1] ;
        delay[ii] <= delay[ii - 1];
    end
    

    out_sig <= ( (
        collection[ 0] + collection[ 1] + collection[ 2] + collection[ 3] + collection[ 4] + collection[ 5] + collection[ 6] + collection[ 7] + collection[ 8] + collection[ 9] + 
        collection[10] + collection[11] + collection[12] + collection[13] + collection[14] + collection[15] + collection[16] + collection[17] + collection[18] + collection[19] + 
        collection[20] + collection[21] + collection[22] + collection[23] + collection[24] + collection[25] + collection[26] + collection[27] + collection[28] + collection[29] + 
        collection[30] + collection[31] + collection[32] + collection[33] + collection[34] + collection[35] + collection[36] + collection[37] + collection[38] + collection[39] + 
        collection[40] + collection[41] + collection[42] + collection[43] + collection[44] + collection[45] + collection[46] + collection[47] + collection[48] + collection[49] + 
        collection[50] + collection[51] + collection[52] + collection[53] + collection[54] + collection[55] + collection[56] + collection[57] + collection[58] + collection[59] + 
        collection[60] + collection[61] + collection[62] + collection[63] + collection[64] + collection[65] + collection[66] + collection[67] + collection[68] + collection[69] +
        collection[70] + collection[71] + collection[72] + collection[73] ) >>> 8 ) & 16'shFF;

end


assign output_sig = out_sig;

endmodule
