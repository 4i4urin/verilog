`timescale 1ns/1ns


module fir_filter (
    input clk,    // Clock

    input signed  [7 : 0] input_sig,
    input ready,

    output signed [7 : 0] output_sig
);


reg signed [7 : 0] fir_coefs [0 : 79];
initial begin
    $readmemh("fir_coefs.txt", fir_coefs);
end


reg signed [15: 0] collection [0 : 19];
reg signed [7: 0] delay [0 : 79];
reg init_flag = 0;

integer i;
always @(posedge clk) begin
    if (init_flag == 0) begin
        for (i = 0; i < 80; i = i + 1)
            delay[i] <= 0;

        for (i = 0; i < 20; i = i + 1)
            collection[i] <= 0;
        init_flag <= 1;
    end
end


reg signed [15: 0] coll_sum = 0;
reg signed [7: 0] result = 0;
reg [6 : 0] index = 0;

integer ii;

always @(posedge clk) begin

    if (index < 75 && ready)
        index <= index + 4;
    else begin
        index <= 0;
        result <= (coll_sum >>> 8) & 16'shFF;

        delay[0] <= input_sig;
        for (ii = 1; ii < 80; ii = ii + 1) 
            delay[ii] <= delay[ii - 1];
    end

    if (ready) begin
        collection[index >> 2] <= 
            fir_coefs[index    ] * delay[index    ] + 
            fir_coefs[index + 1] * delay[index + 1] +
            fir_coefs[index + 2] * delay[index + 2] + 
            fir_coefs[index + 3] * delay[index + 3];

        if (index)
            coll_sum <= coll_sum + collection[index >> 2];
        else 
            coll_sum <= 0;
    end
end


assign output_sig = result;

endmodule
