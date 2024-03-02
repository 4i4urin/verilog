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


reg signed [15: 0] collection [0 : 73];
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


reg signed [7 : 0] out_sig = 0;
reg signed [15: 0] out_sig_pos = 0;
reg signed [15: 0] out_sig_neg = 0;

integer ii, neg_i, pos_i;

always @(posedge clk) begin
    delay[0] <= input_sig;
    
    neg_i = 73; pos_i = 0;
    for (ii = 0; ii < 74; ii = ii + 1) begin

        if ( !ii ) begin
            if ( (fir_coefs[0] ^ input_sig) & 16'sh80 ) begin
                collection[neg_i] <= fir_coefs[0] * input_sig;
                neg_i = neg_i - 1; 
            end
            else begin
                collection[pos_i] <= fir_coefs[0] * input_sig;
                pos_i = pos_i + 1;
            end
        end 
        else begin
            if ( (fir_coefs[ii] ^ delay[ii - 1]) & 16'sh80 ) begin
                collection[neg_i] <= fir_coefs[ii] * delay[ii - 1];
                neg_i = neg_i - 1;
            end            
            else begin
                collection[pos_i] <= fir_coefs[ii] * delay[ii - 1];
                pos_i = pos_i + 1;
            end 

            delay[ii] <= delay[ii - 1];
        end
    end

    out_sig_pos = {(15){1'b0}};
    out_sig_neg = {(15){1'b0}};
    for (ii = 0; ii < pos_i; ii = ii + 1)
        out_sig_pos = out_sig_pos + collection[ii];

    for (ii = neg_i; ii < 74; ii = ii + 1)
        out_sig_neg = out_sig_neg + collection[ii];

end

// output_sig = (out_sig_pos + out_sig_neg) / 255
assign output_sig = ((out_sig_pos + out_sig_neg) >>> 8) & 16'shFF;

endmodule
