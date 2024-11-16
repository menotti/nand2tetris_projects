`timescale 1ns / 1ns
`default_nettype none
module Register_tb();
    
    integer file;
    string stime, tick_tock;

    reg load, clk = 1;
    reg signed [15:0] in;
    wire signed [15:0] out;    
    reg [47:0] testvectors [0:147];
    reg [31:0] vectornum = 0;

    Register dut(
	    .clk(clk),
	    .in(in),
        .load(load),
	    .out(out)
    );

    task display;
        in    = testvectors[vectornum][47:32];
        load  = testvectors[vectornum][16];
        vectornum = vectornum + 1;
        $sformat(stime, "%0d%s", vectornum>>1, tick_tock);
        $fwrite(file, "| %-4s | %6d |  %1b  | %6d |\n", stime, in, load, out);
    endtask

    initial begin
        $dumpfile("Register_tb.vcd");
        $dumpvars(0, Register_tb);
        file = $fopen("Register.out","w");
        $fwrite(file, "| time |   in   |load |  out   |\n");
        $readmemh("Register.tv", testvectors);
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



