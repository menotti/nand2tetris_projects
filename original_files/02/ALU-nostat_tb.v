`default_nettype none
module ALUnostat_tb();
    
    integer file, i;

    reg [15:0] x, y;
    reg zx, nx, zy, ny, f, no;
    wire [15:0] out;

    reg [53:0] testvectors [35:0];

    ALUnostat dut(
	    .x(x),
	    .y(y),
	    .zx(zx),
	    .nx(nx),
	    .zy(zy),
	    .ny(ny),
	    .f(f),
	    .no(no),
	    .out(out)
    );

    task display;
        #1 $fwrite(file, "| %16b | %16b | %1b | %1b | %1b | %1b | %1b | %1b | %16b |\n", x, y, zx, nx, zy, ny, f, no, out);
    endtask

    initial begin
        $dumpfile("ALU-nostat_tb.vcd");
        $dumpvars(0, ALUnostat_tb);
        file = $fopen("ALU-nostat.out","w");
        $fwrite(file, "|        x         |        y         |zx |nx |zy |ny | f |no |       out        |\n");

        $readmemb("ALU-nostat.tv", testvectors, 0, 35);

        for (i = 0; i < 36; i = i + 1) begin
            x = testvectors[i][53:38];
            y = testvectors[i][37:22];
            zx = testvectors[i][21];
            nx = testvectors[i][20];
            zy = testvectors[i][19];
            ny = testvectors[i][18];
            f = testvectors[i][17];
            no = testvectors[i][16];
            display();
        end

        $finish();
    end
endmodule




