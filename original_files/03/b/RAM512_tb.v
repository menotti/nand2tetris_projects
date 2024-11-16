`timescale 1ns / 1ns
`default_nettype none

module RAM512_tb();
    
    integer file;
    integer i = 0;
    integer time_count;
    integer clk_cycle;     
    integer clk_level;

    string stime;
    string tick_tock;

    reg clk = 0;
    reg clk_prev;
    reg signed [15:0] in;
    reg load;
    reg [8:0] address;
    wire signed [15:0] out;

    reg [79:0] testvectors [318:0];

    RAM512 dut(
        .clk(clk),
        .load(load),
        .in(in),
        .address(address),
        .out(out)
    );

    task apply;
	clk     = testvectors[i][64];
	in      = testvectors[i][63:48];
        load    = testvectors[i][32];
        address = testvectors[i][24:16];
    endtask

    task write;
	$sformat(stime, "%0d%s", time_count, tick_tock);
	$fwrite(file, "| %-4s | %6d |  %1b  |  %3d  | %6d |\n", stime, in, load, address, out);
    endtask

    initial begin
        $dumpfile("RAM512_tb.vcd");
        $dumpvars(0, RAM512_tb);
        file = $fopen("RAM512.out", "w");
	$fwrite(file, "| time |   in   |load |address|  out   |\n");
        $readmemh("RAM512.tv", testvectors, 0, 318);

	i = 0;
	apply();
	time_count = 0;
	tick_tock = "+";
	clk_level = 1;
	clk_cycle = 1;
	write();
	clk_prev = clk;

	for (i = 1; i < 319; i = i + 1) begin
		apply();
		if (clk_prev !== clk) begin 
			clk_cycle = clk_cycle + 1;
			if (clk_level == 1) begin
				tick_tock = " ";
				clk_level = 0;
			end
			else begin
				tick_tock = "+";
				clk_level = 1;
			end
		end
		if (clk_cycle == 2) begin
			clk_cycle = 0;
			time_count = time_count + 1;
		end
		clk_prev = clk;
		#1;
		write();
	end
    end
endmodule
