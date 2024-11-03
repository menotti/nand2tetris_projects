`default_nettype none
module HalfAdder_tb();
    
    integer file;

    reg a, b;
    wire sum, carry;

    reg [3:0] testvectors [3:0];

    HalfAdder dut(
	    .a(a),
	    .b(b),
	    .sum(sum),
	    .carry(carry)
    );

    task display;
        #1 $fwrite(file, "|   %1b   |   %1b   |   %1b   |   %1b   |\n", a, b, sum, carry);
    endtask

    initial begin
        $dumpfile("HalfAdder_tb.vcd");
        $dumpvars(0, HalfAdder_tb);
        file = $fopen("HalfAdder.out","w");
        $fwrite(file, "|   a   |   b   |  sum  | carry |\n");

        $readmemb("HalfAdder.tv", testvectors, 0, 3);

        for(integer i = 0; i < 4; i = i + 1) begin
		a = testvectors[i][3];
		b = testvectors[i][2];
		display();
        end

        $finish();
    end
endmodule



