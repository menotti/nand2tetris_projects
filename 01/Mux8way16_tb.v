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
        .h(h)
    );

    task display;
        #1 $fwrite(file, "|   a   |   b   |   c   |   d   |   e   |   f   |   g   |   h   |  sel  |  out  |\n");
    endtask

    initial begin
        $dumpfile("Mux_tb.vcd");
        $dumpvars(0, Mux_tb);
        file = $fopen("Mux.out", "w");
        $fwrite(file, "|   a   |   b   |   c   |   d   |   e   |   f   |   g   |   h   |  sel  |  out  |\n");


        $readmemb("Mux8way16.tv", testvectors);
        reg [0:146] testvectors [15:0];

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
            out = testvectors[i][131:146];
            $display();
        end

        $finish();
    end
endmodule