`timescale 1ns / 1ns
`default_nettype none
module Bit_tb();
    
    integer file;
    string stime, tick_tock;

    reg in, load, clk = 1;
    wire out;    
    reg [2:0] testvectors [0:213];
    reg [31:0] vectornum = 0;

    Bit dut(
	    .clk(clk),
	    .in(in),
        .load(load),
	    .out(out)
    );

    task display;
        in    = testvectors[vectornum][2];
        load  = testvectors[vectornum][1];
        vectornum = vectornum + 1;
        $sformat(stime, "%0d%s", vectornum>>1, tick_tock);
        $fwrite(file, "| %-4s |  %1b  |  %1b  |  %1b  |\n", stime, in, load, out);
    endtask

    initial begin
        $dumpfile("Bit_tb.vcd");
        $dumpvars(0, Bit_tb);
        file = $fopen("Bit.out","w");
        $fwrite(file, "| time | in  |load | out |\n");
        $readmemb("Bit.tv", testvectors);
        forever #0.5 clk = !clk;
    end

    always @(posedge clk) begin
        tick_tock = " ";
        display();
        if (testvectors[vectornum][0] === 1'bx)
            $finish;
        // else if (out !== testvectors[vectornum][0])
        //     $finish_and_return(-1);
    end

    always @(negedge clk) begin
        tick_tock = "+";
        display();
    end

endmodule



