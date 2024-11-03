`default_nettype none
module DMux_tb();
    
    integer file;

    reg in, sel;
    wire a, b;
    
    reg [3:0] testvectors [3:0];

    DMux dut(
	    .in(in),
	    .sel(sel),
	    .a(a),
	    .b(b)
    );

    task display;
        #1 $fwrite(file, "|   %1b   |   %1b   |   %1b   |   %1b   |\n", in, sel, a, b);
    endtask

    initial begin
        $dumpfile("DMux_tb.vcd");
        $dumpvars(0, DMux_tb);
        file = $fopen("DMux.out","w");
        $fwrite(file, "|  in   |  sel  |   a   |   b   |\n");

        $readmemb("DMux.tv", testvectors, 0, 3);

        for(integer i = 0; i < 4; i = i + 1) begin
		in = testvectors[i][3];
		sel = testvectors[i][2];
		display();
        end

        $finish();
    end
endmodule



