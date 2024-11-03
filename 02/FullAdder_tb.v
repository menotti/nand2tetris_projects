`default_nettype none
module FullAdder_tb();
    
    integer file, i;

    reg a, b, carry_in;
    wire sum, carry_out;
    
    reg [4:0] testvectors [7:0];

    FullAdder dut(
	    .a(a),
	    .b(b),
	    .carry_in(carry_in),
	    .sum(sum),
	    .carry_out(carry_out)
    );

    task display;
        #1 $fwrite(file, "|   %1b   |   %1b   |   %1b   |   %1b   |   %1b   |\n", a, b, carry_in, sum, carry_out);
    endtask

    initial begin
        $dumpfile("FullAdder_tb.vcd");
        $dumpvars(0, FullAdder_tb);
        file = $fopen("FullAdder.out","w");
        $fwrite(file, "|   a   |   b   |   c   |  sum  | carry |\n");

        $readmemb("FullAdder.tv", testvectors, 0, 7);

        for (i = 0; i < 8; i = i + 1) begin
            a = testvectors[i][4];
            b = testvectors[i][3];
            carry_in = testvectors[i][2];
            display();
        end

        $finish();
    end
endmodule



