`timescale 1ns / 1ps

module socket (
    input clk,

    input signed [17 : 0] input_sig,
    input ready,

    output signed [17 : 0] filtred_sig,
    output signed [17 : 0] filtred_sig_sep  
);

fir_filter fir_filter(
    .clk (clk),

    .input_sig (input_sig),
    .ready (ready),

    .filtred_sig (filtred_sig)
);

// fir_filter_sep fir_filter_sep(
//     .clk (clk),

//     .input_sig (input_sig),
//     .ready (ready),

//     .filtred_sig (filtred_sig_sep)
// );

endmodule