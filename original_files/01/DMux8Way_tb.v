`default_nettype none
module DMux8Way_tb();
    
    integer file, i;

    reg in;
    reg [2:0] sel;
    wire a, b, c, d, e, f, g, h;
    
    reg [11:0] testvectors [15:0];

    DMux8Way dut(
	    .in(in),
	    .sel(sel),
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
        #1 $fwrite(file, "|  %1b  |  %3b  |  %1b  |  %1b  |  %1b  |  %1b  |  %1b  |  %1b  |  %1b  |  %1b  |\n", in, sel, a, b, c, d, e, f, g, h);
    endtask

    initial begin
        $dumpfile("DMux8Way_tb.vcd");
        $dumpvars(0, DMux8Way_tb);
        file = $fopen("DMux8Way.out","w");
        $fwrite(file, "| in  |  sel  |  a  |  b  |  c  |  d  |  e  |  f  |  g  |  h  |\n");

        $readmemb("DMux8Way.tv", testvectors, 0, 15);

        for (i = 0; i < 16; i = i + 1) begin
            in = testvectors[i][11];
            sel = testvectors[i][10:8];
            display();
        end

        $finish();
    end
endmodule


