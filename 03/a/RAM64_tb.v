`timescale 1ns / 1ns
`default_nettype none

module RAM64_tb();

    integer file;
    string stime, tick_tock;

    reg signed [15:0] in;
    reg address [5:0] address;
    reg load, clk = 1;
    wire signed [15:0] out;
    reg [63:0] testvectors [318:0];
    reg [31:0] vectornum = 0;

    RAM64 dut(
        .in(in),
        .address(address),
        .load(load),
        .clk(clk),
        .out(out)
    );

    task display;
        in =      testvectors[vectornum][63:48];
        load =    testvectors[vectornum][32];
        address = testvectors[vectornum][31:16];
        vectornum = vectornum + 1;
        $sformat(stime, "%0d%s", vectornum>>1, tick_tock);
        $fwrite(file, "| %-4s |  %6d   | %1b |  %2d  |  %6d   |\n", stime, in, load, address, out);
    endtask

    initial begin
        $dumpfile("RAM64.vcd");
        $dumpvars(0, RAM64);
        file = $fopen("RAM64.out","w");
        $fwrite(file, "| time |   in   |load |address|  out   |\n");
        $readmemh("RAM64.tv", testvectors);
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