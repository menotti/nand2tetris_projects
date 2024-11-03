`default_nettype none
module Mux4Way16_tb();
    
    integer file;
    
    reg [15:0] a, b, c, d;
    reg [1:0] sel;
    wire [15:0] out;

    reg [81:0] testvectors [7:0];

    Mux4Way16 dut(
	    .a(a),
	    .b(b),
	    .c(c),
	    .d(d),
	    .sel(sel),
	    .out(out)
    );

    task display;
        #1 $fwrite(file, "| %16b | %16b | %16b | %16b |  %2b  | %16b |\n", a, b, c, d, sel, out);
    endtask

    initial begin
        $dumpfile("Mux4Way16_tb.vcd");
        $dumpvars(0, Mux4Way16_tb);
        file = $fopen("Mux4Way16.out","w");
        $fwrite(file, "|        a         |        b         |        c         |        d         | sel  |       out        |\n");

        $readmemb("Mux4Way16.tv", testvectors, 0, 7);

        for(integer i = 0; i < 8; i = i + 1) begin
		a = testvectors[i][81:66];
		b = testvectors[i][65:50];			
		c = testvectors[i][49:34];
		d = testvectors[i][33:18];
		sel = testvectors[i][17:16];
		display();
        end

        $finish();
    end
endmodule



