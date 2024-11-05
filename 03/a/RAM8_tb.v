`timescale 1ns / 1ns
`default_nettype none

module RAM8_tb();
    
    integer file;
    integer i = 0;

    reg clk;
    reg signed [15:0] in;
    reg load;
    reg [2:0] address;
    wire signed [15:0] out;

    reg [79:0] testvectors [171:0];

    RAM8 dut(
        .clk(clk),
        .load(load),
        .in(in),
        .address(address),
        .out(out)
    );

    task apply;
	in    = testvectors[i][63:48];
        load  = testvectors[i][32];
        address = testvectors[i][18:16];
    endtask

    task write;
	$fwrite(file, "%04h_%04h_%04h_%04h\n", in, load, address, out);
    endtask

    task tick;
	    clk = 0;
    endtask

    task tock;
	    clk = 1;
    endtask

    initial begin
        $dumpfile("RAM8_tb.vcd");
        $dumpvars(0, RAM8_tb);
        file = $fopen("RAM8.out", "w");
        $readmemh("RAM8.tv", testvectors);

    end


    always begin
	if (i == 172) $finish;
	apply();
	#100
	tick();
	#100
	write();
	tick();
	i = i + 1;
    end

endmodule

