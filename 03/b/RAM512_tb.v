`timescale 1ns / 1ns
`default_nettype none

module RAM512_tb();

    integer i;
    integer file;
    string stime, tick_tock;

    reg load;
    reg signed [15:0] in;
    reg [8:0] address;
    wire signed [15:0] out;
    reg [79:0] testvectors [318:0];
    reg clock;

    RAM512 dut (
        .in(in),
        .address(address),
        .load(load),
        .clk(clock),
        .out(out)
    );

    reg [15:0] ttime;
    task display;
        ttime     = testvectors[i][79:64];
        in       = testvectors[i][63:48];
        load     = testvectors[i][32];
        address  = testvectors[i][31:16];
        $sformat(stime, "%0d%s", i, tick_tock);
        $fwrite(file, "| %-4s | %6d | %1b | %3d | %6d |\n", stime, in, load, address, out);
    endtask

    initial begin
        $dumpfile("RAM512_tb.vcd");
        $dumpvars(0, RAM512_tb);
        file = $fopen("RAM512.out", "w");
        $fwrite(file, "| time |   in   |load |address|  out   |\n");

        $readmemh("RAM512.tv", testvectors, 0, 318);

        for (i = 0; i < 319; i = i + 1) begin
            ttime = testvectors[i][79:64];
            case(ttime)
                16'b0000000000000000: begin
                    clock = 0;
                    tick_tock = " ";
                end
                16'b0000000000000001: begin
                    clock = 1;
                    tick_tock = "+";
                end
            endcase

            display();
            #1;

            if (testvectors[i][0] === 1'bx) begin
                $finish;
            end
        end
    end

endmodule