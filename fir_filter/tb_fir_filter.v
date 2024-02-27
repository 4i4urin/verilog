`timescale 1ns/1ns

module tb_fir_filter ();


reg clk = 0;


initial
    forever #5 clk = ~clk;


reg  signed [7 : 0] signal = 0;
wire signed [7 : 0] output_sig;


fir_filter fir_filter(
    .clk (clk),

    .input_sig (signal),

    .output_sig(output_sig)
);


reg signed [7 : 0] input_signal [0 : 399];
integer File_id;
initial begin
    File_id = $fopen("output_verilog", "w");
    $readmemh("signal.txt", input_signal);
end



reg [15 : 0] index = 0;

always @(posedge clk) begin
    if (index < 400) begin
        signal <= input_signal[index];
        index <= index + 1;
        $fdisplay(File_id, output_sig);
    end
    else begin
        $fclose(File_id);
        signal <= 0;
    end
        
end


initial
begin
    $dumpfile("test_fir.vcd");
    $dumpvars;
end


endmodule
