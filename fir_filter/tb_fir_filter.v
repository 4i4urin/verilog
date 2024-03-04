`timescale 1ns/1ns

module tb_fir_filter ();


reg clk = 0;

// period = 10ns, freq = 100 MegHz
// signal period = 200us, freq = 5 MegHz
initial
    forever #5 clk = ~clk;


reg  signed [7 : 0] signal = 0;
reg ready = 0;
wire signed [7 : 0] output_sig;
wire signed [7 : 0] output_sig_upd;


fir_filter fir_filter(
    .clk (clk),

    .input_sig (signal),
    .ready (ready),

    .output_sig(output_sig)
);

fir_filter_sep fir_filter_sep(
    .clk (clk),

    .input_sig (signal),

    .output_sig(output_sig_upd)
);


reg signed [7 : 0] input_signal [0 : 399];
integer File_id;
initial begin
    File_id = $fopen("output_verilog", "w");
    $readmemh("signal.txt", input_signal);
end



reg [15: 0] index = 0;
reg [5 : 0] signal_delay = 0;

always @(posedge clk) begin
    if (index < 400) begin
        if (signal_delay < 19) 
            signal_delay <= signal_delay + 1;
        else begin
            ready <= 1;
            signal <= input_signal[index];
            index <= index + 1; 
            signal_delay <= 0;
            // $fdisplay(File_id, output_sig_upd);
            $fdisplay(File_id, output_sig);
        end 
    end
    else begin
        if (ready) begin
            $fclose(File_id);
            $display("Ready");
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


endmodule
