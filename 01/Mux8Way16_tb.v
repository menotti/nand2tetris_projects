`default_nettype none
module Mux8Way16_tb();
    
    integer file;

    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;
    wire [15:0] out;


    reg [146:0] testvectors [15:0];

    Mux8Way16 dut(
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
        #1 $fwrite(file, "| %1b | %1b | %1b | %1b | %1b | %1b | %1b | %1b |  %1b  | %1b |\n", a, b, c, d, e, f, g, h, sel, out);
    endtask

    initial begin
        $dumpfile("Mux8way16_tb.vcd");
        $dumpvars(0, Mux8Way16_tb);
        file = $fopen("Mux8Way16.out","w");
        $fwrite(file, "|        a         |        b         |        c         |        d         |        e         |        f         |        g         |        h         |  sel  |       out        |\n");

        $readmemb("Mux8Way16.tv", testvectors, 0, 15);

        for(integer i = 0; i < 16; i = i + 1) begin
            a = testvectors[i][146:131];
            b = testvectors[i][130:115];
            c = testvectors[i][114:99];
            d = testvectors[i][98:83];
            e = testvectors[i][82:67];
            f = testvectors[i][66:51];
            g = testvectors[i][50:35];
            h = testvectors[i][34:19];
            sel = testvectors[i][18:16];
            display();
        end

        $finish();
    end
endmodule
