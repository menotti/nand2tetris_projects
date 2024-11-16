`default_nettype none
module Inc16_tb();
    
    integer file, i;

    reg [15:0] in;
    wire [15:0] out; 
    
    reg [31:0] testvectors [3:0];

    Inc16 dut(
	    .in(in),
	    .out(out)
    );

    task display;
        #1 $fwrite(file, "| %16b | %16b |\n", in, out);
    endtask

    initial begin
        $dumpfile("Inc16_tb.vcd");
        $dumpvars(0, Inc16_tb);
        file = $fopen("Inc16.out","w");
        $fwrite(file, "|        in        |       out        |\n");

        $readmemb("Inc16.tv", testvectors, 0, 3);

        for (i = 0; i < 4; i = i + 1) begin
            in = testvectors[i][31:16];
            display();
        end

        $finish();
    end
endmodule

