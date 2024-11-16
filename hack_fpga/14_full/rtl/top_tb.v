`ifdef BENCH
`timescale 1ns / 1ns
`default_nettype none
module top_tb();
    reg clk = 1;
    wire [9:0] leds;
    initial begin
        $monitor("leds=%b d=%h isIO=%b", leds, dut.CPU_0.regD, dut.isIO);
        forever #5 clk = ~clk;
    end
    top dut(
	    .CLOCK_50(clk),
	    .LEDR(leds));
endmodule
`endif