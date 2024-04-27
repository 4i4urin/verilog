`timescale 1ns/1ns
`define WIDTH 16


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


integer File_id;

initial begin
    // $readmemh("signal.txt", input_signal);
    File_id = $fopen("input.txt", "r");
end


reg [6 : 0] signal_delay = 0;

always @(posedge clk) begin
    begin
        signal_delay <= signal_delay + 1;
    
        if ( !signal_delay ) begin
            ready <= 1;
            
            $fscanf(File_id, "%d\n", signal); 
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


endmodule
