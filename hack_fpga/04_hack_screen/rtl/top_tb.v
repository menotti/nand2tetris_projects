`ifdef BENCH
`timescale 1ns / 1ns
`default_nettype none
module top_tb();
    reg clk = 1;
    wire [9:0] leds;
    initial begin
        // $dumpfile("dump.vcd");
        // $dumpvars(0);
        // $monitor("pc=%d, ir= %b, a=%h, d=%h, in=%h out=%h we=%b, leds=%b", 
                //   dut.CPU_0.pc, 
                //          dut.CPU_0.instruction, 
                //                  dut.CPU_0.regA, 
                //                        dut.CPU_0.regD, 
                //                              dut.CPU_0.inM, 
                //                                    dut.CPU_0.outM,
                //                                           dut.CPU_0.loadM,
                //                                                  leds);
        // #100000 $finish;
    end
    always
        #5 clk = ~clk;
    
    top dut(
	    .CLOCK_50(clk),
	    .LEDR(leds));
endmodule
`endif