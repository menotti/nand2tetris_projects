`default_nettype none
module Add16_tb();
    
    integer file, i;

    reg [15:0] a, b;
    wire [15:0] out;    
    reg [47:0] testvectors [5:0];

    Add16 dut(
	    .a(a),
	    .b(b),
	    .out(out)
    );

    task display;
        #1 $fwrite(file, "| %16b | %16b | %16b |\n", a, b, out);
    endtask

    initial begin
        $dumpfile("Add16_tb.vcd");
        $dumpvars(0, Add16_tb);
        file = $fopen("Add16.out","w");
        $fwrite(file, "|        a         |        b         |       out        |\n");

        $readmemb("Add16.tv", testvectors, 0, 5);

        for (i = 0; i < 6; i = i + 1) begin
            a = testvectors[i][47:32];
            b = testvectors[i][31:16];
            display();
        end

        $finish();
    end
endmodule



