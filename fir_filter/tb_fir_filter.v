`timescale 1ns/1ns
`define WIDTH 24


module tb_fir_filter ();


reg clk = 0;

// period = 10ns, freq = 100 MegHz
// signal period = 200us, freq = 5 MegHz
initial
    forever #5 clk = ~clk;


reg  signed [`WIDTH - 1 : 0] signal = 0;
reg ready = 0;

wire signed [`WIDTH - 1 : 0] some;

socket some_socket(
    .clk (clk),

    .input_sig (signal),
    .ready (ready),
    .some (some)
);


integer File_id,File_id2;

initial begin
    File_id = $fopen("output_verilog", "w");
    // $readmemh("signal.txt", input_signal);
    File_id2 = $fopen("input.txt", "r");
end


reg [63: 0] index = 0;
reg [6 : 0] signal_delay = 0;

always @(posedge clk) begin
    begin
        signal_delay <= signal_delay + 1;
    
        if ( !signal_delay ) begin
            ready <= 1;
            
            $fscanf(File_id2, "%d\n", signal); 

            
            index <= index + 1;
//            $fdisplay(File_id, filtred_sig_sep);
            // $fdisplay(File_id, filtred_sig);
        end
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
// print(max(x), min(x))
// for val in x:
//     print(f"assign input_signal[{count}] = ", end="")
//     if val < 0:
//         print(f"-`WIDTH'sd{abs(val)};")
//     else:
//         print(f"`WIDTH'sd{val};")
//     count += 1

endmodule
