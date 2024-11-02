`default_nettype none
module Mux8way16_tb();
    
    integer file;

    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;
    wire [15:0] out;

    Mux8way16 dut(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h),
        .sel(sel),
        .out(out)
    );

    task display;
        #1 $fwrite(file, "|   %1b   |   %1b   |   %1b   |   %1b   |   %1b   |   %1b   |   %1b   |   %1b   |  %1b  |  %1b  |\n");
    endtask

    initial begin
        $dumpfile("Mux8way16_tb.vcd");
        $dumpvars(0, Mux8way16_tb);
        file = $fopen("Mux8way16.out", "w");
        $fwrite(file, "|   a   |   b   |   c   |   d   |   e   |   f   |   g   |   h   |  sel  |  out  |\n");

        reg [0:130] testvectors [15:0];
        $readmemb("Mux8way16.tv", testvectors);

        for(integer i = 0; i < 16; i = i + 1) begin
            a = testvectors[i][0:15];
            b = testvectors[i][16:31];
            c = testvectors[i][32:47];
            d = testvectors[i][48:63];
            e = testvectors[i][64:79];
            f = testvectors[i][80:95];
            g = testvectors[i][96:111];
            h = testvectors[i][112:127];
            sel = testvectors[i][128:130];
            $display();
        end

        $finish();
    end
endmodule