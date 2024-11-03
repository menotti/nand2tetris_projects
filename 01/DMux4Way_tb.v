`default_nettype none
module DMux4Way_tb();
    
    integer file;

    reg in;
    reg [1:0] sel;
    wire a, b, c, d;
    
    reg [6:0] testvectors [7:0];

    DMux4Way dut(
	    .in(in),
	    .sel(sel),
	    .a(a),
	    .b(b),
	    .c(c),
	    .d(d)
    );

    task display;
        #1 $fwrite(file, "|  %1b  |  %2b  |  %1b  |  %1b  |  %1b  |  %1b  |\n", in, sel, a, b, c, d);
    endtask

    initial begin
        $dumpfile("DMux4Way_tb.vcd");
        $dumpvars(0, DMux4Way_tb);
        file = $fopen("DMux4Way.out","w");
        $fwrite(file, "| in  | sel  |  a  |  b  |  c  |  d  |\n");

        $readmemb("DMux4Way.tv", testvectors, 0, 7);

        for(integer i = 0; i < 8; i = i + 1) begin
		in = testvectors[i][6];
		sel = testvectors[i][5:4];
		display();
        end

        $finish();
    end
endmodule

