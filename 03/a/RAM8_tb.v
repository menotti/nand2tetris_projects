`timescale 1ns / 1ns
`default_nettype none

module RAM8_tb();
    
    integer file;
    integer i = 0;
    integer times2 = 0;
    integer time_count;
    integer titock;
    integer level;
    string stime;
    string tick_tock;

    reg clk = 0;
    reg signed [15:0] in;
    reg load;
    reg [2:0] address;
    wire signed [15:0] out;
    reg clk2;

    reg [79:0] testvectors [171:0];

    RAM8 dut(
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
        address = testvectors[i][18:16];
    endtask

    task write;
	$sformat(stime, "%0d%s", time_count, tick_tock);
	$fwrite(file, "| %-4s | %6d |  %1b  |   %0d   | %6d |\n", stime, in, load, address, out);
    endtask

    initial begin
        $dumpfile("RAM8_tb.vcd");
        $dumpvars(0, RAM8_tb);
        file = $fopen("RAM8.out", "w");
	$fwrite(file, "| time |   in   |load |address|  out   |\n");
        $readmemh("RAM8.tv", testvectors, 0, 171);


	i = 0;
	apply();
	time_count = 0;
	tick_tock = "+";
	level = 1;
	titock = 1;
	write();
	clk2 = clk;

	for (i = 1; i < 172; i = i + 1) begin
		apply();
		if (clk2 !== clk) begin 
			titock = titock + 1;
			if (level == 1) begin
				tick_tock = " ";
				level = 0;
			end
			else begin
				tick_tock = "+";
				level = 1;
			end
		end
		if (titock == 2) begin
			titock = 0;
			time_count = time_count + 1;
		end
		clk2 = clk;
		#1;
		write();
		#1;
	end
    end
endmodule

