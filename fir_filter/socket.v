`timescale 1ns / 1ps
`define WIDTH 24


module socket (
    input clk,

    input signed [`WIDTH - 1 : 0] input_sig,
    input ready,
    
    output signed [`WIDTH - 1 : 0] some
);

reg signed [`WIDTH - 1 : 0] result;

wire signed [`WIDTH - 1 : 0] fir_sig;
wire signed [`WIDTH - 1 : 0] fir_sig_sep;


always @(posedge clk) begin
    result <= fir_sig ^ fir_sig_sep;
end
assign some = result;


socket_fir fir_filter(
    .clk (clk),

    .input_sig (input_sig),
    .ready (ready),

    .some (fir_sig)
);

socket_fir_sep fir_filter_sep(
    .clk (clk),

    .input_sig (input_sig),
    .ready (ready),

    .some (fir_sig_sep)
);

endmodule


//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
module socket_fir (
    input clk,

    input signed [`WIDTH - 1 : 0] input_sig,
    input ready,
    
    output signed [`WIDTH - 1 : 0] some
);


wire signed [`WIDTH - 1 : 0] fir_sig_0;
wire signed [`WIDTH - 1 : 0] fir_sig_1;
wire signed [`WIDTH - 1 : 0] fir_sig_2;
wire signed [`WIDTH - 1 : 0] fir_sig_3;
wire signed [`WIDTH - 1 : 0] fir_sig_4;
wire signed [`WIDTH - 1 : 0] fir_sig_5;
wire signed [`WIDTH - 1 : 0] fir_sig_6;
// wire signed [`WIDTH - 1 : 0] fir_sig_7;
// wire signed [`WIDTH - 1 : 0] fir_sig_8;
// wire signed [`WIDTH - 1 : 0] fir_sig_9;

reg signed [`WIDTH - 1 : 0] input_sig_0;
reg signed [`WIDTH - 1 : 0] input_sig_1;
reg signed [`WIDTH - 1 : 0] input_sig_2;
reg signed [`WIDTH - 1 : 0] input_sig_3;
reg signed [`WIDTH - 1 : 0] input_sig_4;
reg signed [`WIDTH - 1 : 0] input_sig_5;
reg signed [`WIDTH - 1 : 0] input_sig_6;
// reg signed [`WIDTH - 1 : 0] input_sig_7;
// reg signed [`WIDTH - 1 : 0] input_sig_8;
// reg signed [`WIDTH - 1 : 0] input_sig_9;


reg signed [`WIDTH - 1 : 0] stub_sig;
always @(posedge clk) begin
    input_sig_0 <= input_sig;
    if (input_sig < 0) begin
        input_sig_1 <= input_sig + 1;
        input_sig_2 <= input_sig + 2;
        input_sig_3 <= input_sig + 3;
        input_sig_4 <= input_sig + 4;
        input_sig_5 <= input_sig + 5;
        input_sig_6 <= input_sig + 6;
        // input_sig_7 <= input_sig + 7;
        // input_sig_8 <= input_sig + 8;
        // input_sig_9 <= input_sig + 9;
    end
    else begin
        input_sig_1 <= input_sig - 1;
        input_sig_2 <= input_sig - 2;
        input_sig_3 <= input_sig - 3;
        input_sig_4 <= input_sig - 4;
        input_sig_5 <= input_sig - 5;
        input_sig_6 <= input_sig - 6;
        // input_sig_7 <= input_sig - 7;
        // input_sig_8 <= input_sig - 8;
        // input_sig_9 <= input_sig - 9;
    end

    stub_sig <= fir_sig_0 ^ fir_sig_1 ^ fir_sig_2 ^ fir_sig_3 ^ fir_sig_4 ^
         fir_sig_5 ^ fir_sig_6;// ^ fir_sig_7 ^ fir_sig_8 ^ fir_sig_9;
end

assign some = stub_sig;

fir_filter fir_filter_0(
    .clk (clk),

    .input_sig (input_sig_0),
    .ready (ready),

    .filtred_sig (fir_sig_0)
);
fir_filter fir_filter_1(
    .clk (clk),

    .input_sig (input_sig_1),
    .ready (ready),

    .filtred_sig (fir_sig_1)
);
fir_filter fir_filter_2(
    .clk (clk),

    .input_sig (input_sig_2),
    .ready (ready),

    .filtred_sig (fir_sig_2)
);
fir_filter fir_filter_3(
    .clk (clk),

    .input_sig (input_sig_3),
    .ready (ready),

    .filtred_sig (fir_sig_3)
);
fir_filter fir_filter_4(
    .clk (clk),

    .input_sig (input_sig_4),
    .ready (ready),

    .filtred_sig (fir_sig_4)
);
fir_filter fir_filter_5(
    .clk (clk),

    .input_sig (input_sig_5),
    .ready (ready),

    .filtred_sig (fir_sig_5)
);
fir_filter fir_filter_6(
    .clk (clk),

    .input_sig (input_sig_6),
    .ready (ready),

    .filtred_sig (fir_sig_6)
);
// fir_filter fir_filter_7(
//     .clk (clk),

//     .input_sig (input_sig_7),
//     .ready (ready),

//     .filtred_sig (fir_sig_7)
// );
// fir_filter fir_filter_8(
//     .clk (clk),

//     .input_sig (input_sig_8),
//     .ready (ready),

//     .filtred_sig (fir_sig_8)
// );
// fir_filter fir_filter_9(
//     .clk (clk),

//     .input_sig (input_sig_9),
//     .ready (ready),

//     .filtred_sig (fir_sig_9)
// );

endmodule 


//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
module socket_fir_sep (
    input clk,

    input signed [`WIDTH - 1 : 0] input_sig,
    input ready,
    
    output signed [`WIDTH - 1 : 0] some
);


wire signed [`WIDTH - 1 : 0] fir_sig_sep_0;
wire signed [`WIDTH - 1 : 0] fir_sig_sep_1;
wire signed [`WIDTH - 1 : 0] fir_sig_sep_2;
wire signed [`WIDTH - 1 : 0] fir_sig_sep_3;
wire signed [`WIDTH - 1 : 0] fir_sig_sep_4;
wire signed [`WIDTH - 1 : 0] fir_sig_sep_5;
wire signed [`WIDTH - 1 : 0] fir_sig_sep_6;
// wire signed [`WIDTH - 1 : 0] fir_sig_sep_7;
// wire signed [`WIDTH - 1 : 0] fir_sig_sep_8;
// wire signed [`WIDTH - 1 : 0] fir_sig_sep_9;

reg signed [`WIDTH - 1 : 0] input_sig_0;
reg signed [`WIDTH - 1 : 0] input_sig_1;
reg signed [`WIDTH - 1 : 0] input_sig_2;
reg signed [`WIDTH - 1 : 0] input_sig_3;
reg signed [`WIDTH - 1 : 0] input_sig_4;
reg signed [`WIDTH - 1 : 0] input_sig_5;
reg signed [`WIDTH - 1 : 0] input_sig_6;
// reg signed [`WIDTH - 1 : 0] input_sig_7;
// reg signed [`WIDTH - 1 : 0] input_sig_8;
// reg signed [`WIDTH - 1 : 0] input_sig_9;



reg signed [`WIDTH - 1 : 0] stub_sig;
always @(posedge clk) begin
    input_sig_0 <= input_sig;
    if (input_sig < 0) begin
        input_sig_1 <= input_sig + 1;
        input_sig_2 <= input_sig + 2;
        input_sig_3 <= input_sig + 3;
        input_sig_4 <= input_sig + 4;
        input_sig_5 <= input_sig + 5;
        input_sig_6 <= input_sig + 6;
        // input_sig_7 <= input_sig + 7;
        // input_sig_8 <= input_sig + 8;
        // input_sig_9 <= input_sig + 9;
    end
    else begin
        input_sig_1 <= input_sig - 1;
        input_sig_2 <= input_sig - 2;
        input_sig_3 <= input_sig - 3;
        input_sig_4 <= input_sig - 4;
        input_sig_5 <= input_sig - 5;
        input_sig_6 <= input_sig - 6;
        // input_sig_7 <= input_sig - 7;
        // input_sig_8 <= input_sig - 8;
        // input_sig_9 <= input_sig - 9;
    end
        
    stub_sig <= fir_sig_sep_0 ^ fir_sig_sep_1 ^ fir_sig_sep_2 ^ fir_sig_sep_3 ^ fir_sig_sep_4 ^
        fir_sig_sep_5 ^ fir_sig_sep_6;// ^ fir_sig_sep_7 ^ fir_sig_sep_8 ^ fir_sig_sep_9;
end

assign some = stub_sig;


fir_filter_sep fir_filter_sep_0(
    .clk (clk),

    .input_sig (input_sig_0),
    .ready (ready),

    .filtred_sig (fir_sig_sep_0)
);
fir_filter_sep fir_filter_sep_1(
    .clk (clk),

    .input_sig (input_sig_1),
    .ready (ready),

    .filtred_sig (fir_sig_sep_1)
);
fir_filter_sep fir_filter_sep_2(
    .clk (clk),

    .input_sig (input_sig_2),
    .ready (ready),

    .filtred_sig (fir_sig_sep_2)
);
fir_filter_sep fir_filter_sep_3(
    .clk (clk),

    .input_sig (input_sig_3),
    .ready (ready),

    .filtred_sig (fir_sig_sep_3)
);
fir_filter_sep fir_filter_sep_4(
    .clk (clk),

    .input_sig (input_sig_4),
    .ready (ready),

    .filtred_sig (fir_sig_sep_4)
);
fir_filter_sep fir_filter_sep_5(
    .clk (clk),

    .input_sig (input_sig_5),
    .ready (ready),

    .filtred_sig (fir_sig_sep_5)
);
fir_filter_sep fir_filter_sep_6(
    .clk (clk),

    .input_sig (input_sig_6),
    .ready (ready),

    .filtred_sig (fir_sig_sep_6)
);
// fir_filter_sep fir_filter_sep_7(
//     .clk (clk),

//     .input_sig (input_sig_7),
//     .ready (ready),

//     .filtred_sig (fir_sig_sep_7)
// );
// fir_filter_sep fir_filter_sep_8(
//     .clk (clk),

//     .input_sig (input_sig_8),
//     .ready (ready),

//     .filtred_sig (fir_sig_sep_8)
// );
// fir_filter_sep fir_filter_sep_9(
//     .clk (clk),

//     .input_sig (input_sig_9),
//     .ready (ready),

//     .filtred_sig (fir_sig_sep_9)
// );

endmodule 
