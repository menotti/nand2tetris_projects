`timescale 1ns / 1ns
`default_nettype none
module PC_tb();
    
    integer file;
    string stime, tick_tock;

    reg reset, load, inc, clk = 1;
    reg signed [15:0] in;
    wire signed [15:0] out;    
    reg [79:0] testvectors [0:29];
    reg [31:0] vectornum = 0;

    PC dut(
	    .clk(clk),
        .reset(reset),
        .load(load),
        .inc(inc),
	    .in(in),
	    .out(out)
    );

    task display;
        in    = testvectors[vectornum][79:64];
        reset = testvectors[vectornum][48];
        load  = testvectors[vectornum][32];
        inc   = testvectors[vectornum][16];
        vectornum = vectornum + 1;
        $sformat(stime, "%0d%s", vectornum>>1, tick_tock);
        $fwrite(file, "| %-4s | %6d |  %1b  |  %1b  |  %1b  | %6d |\n", stime, in, reset, load, inc, out);
    endtask

    initial begin
        $dumpfile("PC_tb.vcd");
        $dumpvars(0, PC_tb);
        file = $fopen("PC.out","w");
        $fwrite(file, "| time |   in   |reset|load | inc |  out   |\n");
        $readmemh("PC.tv", testvectors);
        forever #0.5 clk = !clk;
    end

    always @(posedge clk) begin
        tick_tock = " ";
        display();
        if (testvectors[vectornum][0] === 1'bx)
            $finish;
        // else if (out !== testvectors[vectornum][15:0])
        //     $finish_and_return(-1);
    end

    always @(negedge clk) begin
        tick_tock = "+";
        display();
    end

endmodule



