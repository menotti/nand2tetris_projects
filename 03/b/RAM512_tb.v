`timescale 1ns / 1ns
`default_nettype none

module RAM512_tb();

    integer file;
    string stime, tick_tock;

    reg clk = 1;
    reg load;
    reg signed [15:0] in;
    reg [8:0] address;
    wire signed [15:0] out;
    reg [79:0] testvectors [318:0];
    reg [31:0] vectornum = 0;

    RAM512 dut (
        .in(in),
        .address(address),
        .load(load),
        .clk(clk),
        .out(out)
    );

    task display;
        
        in       = testvectors[vectornum][79:64];
        load     = testvectors[vectornum][48];
        address  = testvectors[vectornum][47:39];
        vectornum = vectornum + 1;
        
        // Formata e escreve a linha de saída
        $sformat(stime, "%0d%s", vectornum>>1, tick_tock);
        $fwrite(file, "| %-4s | %6d | %1b | %3d | %6d |\n", stime, in, load, address, out);
    endtask

    initial begin
        $dumpfile("RAM512_tb.vcd");
        $dumpvars(0, RAM512_tb);
        file = $fopen("RAM512.out", "w");
        $fwrite(file, "| time |   in   |load |address|  out   |\n");
        $readmemh("RAM512.tv", testvectors);
        forever #0.5 clk = !clk;
    end

    always @(posedge clk) begin
        tick_tock = " ";
        display();
        if (testvectors[vectornum][0] === 1'bx) begin
            $finish;
        end
    end

    always @(negedge clk) begin
        tick_tock = "+";
        display();
    end

endmodule