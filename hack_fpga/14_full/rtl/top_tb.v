`ifdef BENCH
`timescale 1ns / 1ns
`default_nettype none
module top_tb();
    reg clk = 1;
    wire [9:0] leds;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, top_tb);
        #500 $finish;
    end
    always
        #5 clk = ~clk;
    
    top dut(
	    .CLOCK_50(clk),
	    .LEDR(leds));
endmodule
`endif