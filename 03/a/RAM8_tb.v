`timescale 1ns / 1ns
`default_nettype none
module RAM8_tb();
    
    integer file;
    string stime, tick_tock;

    reg clk = 1;
    reg signed [15:0] in;
    reg load;
    reg [2:0] address;
    wire signed [15:0] out;

    reg [63:0] testvectors [0:172];
    reg [31:0] vectornum = 0;

    RAM8 dut(
	    .in(in),
	    .load(load),
	    .address(address),
	    .out(out)
    );

    task display;
        in    = testvectors[vectornum][63:48];
        load  = testvectors[vectornum][32];
	address = testvectors[vectornum][18:16];
        vectornum = vectornum + 1;
        $sformat(stime, "%0d%s", vectornum>>1, tick_tock);
        $fwrite(file, "| %-4s | %6d |  %1b  |   %d   | %6d |\n", stime, in, load, address, out);
    endtask

    initial begin
        $dumpfile("RAM8_tb.vcd");
        $dumpvars(0, RAM8_tb);
        file = $fopen("RAM8.out","w");
        $fwrite(file, "| time |   in   |load |address|  out   |\n");
        $readmemh("RAM8.tv", testvectors);
        forever #0.5 clk = !clk;
    end

    always @(posedge clk) begin
        tick_tock = " ";
        display();
        if (testvectors[vectornum][0] === 1'bx)
            $finish;
    end

    always @(negedge clk) begin
        tick_tock = "+";
        display();
    end

endmodule




