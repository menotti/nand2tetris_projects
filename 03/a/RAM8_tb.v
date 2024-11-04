`timescale 1ns / 1ns
`default_nettype none
module RAM8_tb();
    
    integer file;
    integer i;

    reg clk;
    reg signed [15:0] in;
    reg load;
    reg [2:0] address;
    wire signed [15:0] out;
    reg reset;


    reg [79:0] testvectors [0:171];

    RAM8 dut(
	    .clk(),
	    .load(load),
	    .in(in),
	    .address(address),
	    .out(out)
    );

    task display;
        $fwrite(file, "%04h_%04h_%04h_%04h_%04h_\n", clk, in, load, address, out);
    endtask

    initial begin
        $dumpfile("RAM8_tb.vcd");
        $dumpvars(0, RAM8_tb);
        file = $fopen("RAM8.out","w");
        $readmemh("RAM8.tv", testvectors);

	reset = 0; #1 reset = 1; #1 reset = 0;

	for(i = 0; i < 172; i = i + 1) begin
		clk = testvectors[i][64];
		in    = testvectors[i][63:48];
		load  = testvectors[i][32];
		address = testvectors[i][18:16];
		display();
	end
    end
endmodule




