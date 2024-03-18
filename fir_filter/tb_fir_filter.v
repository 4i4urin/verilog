`timescale 1ns/1ns

module tb_fir_filter ();


reg clk = 0;

// period = 10ns, freq = 100 MegHz
// signal period = 200us, freq = 5 MegHz
initial
    forever #5 clk = ~clk;


reg  signed [7 : 0] signal = 0;
reg ready = 0;
wire signed [7 : 0] filtred_sig;
wire signed [7 : 0] filtred_sig_sep;


fir_filter fir_filter(
    .clk (clk),

    .input_sig (signal),
    .ready (ready),

    .filtred_sig(filtred_sig)
);

fir_filter_sep fir_filter_sep(
    .clk (clk),

    .input_sig (signal),
    .ready (ready),
    
    .filtred_sig(filtred_sig_sep)
);


reg signed [7 : 0] input_signal [0 : 399];
integer File_id;
initial begin
    File_id = $fopen("output_verilog", "w");
    $readmemh("signal.txt", input_signal);
end
// # python 3
// sample_rate = 100.0
// nsamples = 400
// t = arange(nsamples) / sample_rate
// x = cos(2*pi*0.5*t) + 0.2*sin(2*pi*2.5*t+0.1) + \
//         0.2*sin(2*pi*15.3*t) + 0.1*sin(2*pi*16.7*t + 0.1) + \
//             0.1*sin(2*pi*23.45*t+.8)



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
            $fdisplay(File_id, filtred_sig_sep);
            // $fdisplay(File_id, filtred_sig);
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
