`default_nettype none
module ALU_tb();
    
    integer file, i;

    reg [15:0] x, y;
    reg zx, nx, zy, ny, f, no;
    wire [15:0] out;
    wire zr, ng;

    reg [55:0] testvectors [35:0];

    ALU dut(
	    .x(x),
	    .y(y),
	    .zx(zx),
	    .nx(nx),
	    .zy(zy),
	    .ny(ny),
	    .f(f),
	    .no(no),
	    .out(out),
	    .zr(zr),
	    .ng(ng)
    );

    task display;
        #1 $fwrite(file, "| %16b | %16b | %1b | %1b | %1b | %1b | %1b | %1b | %16b | %1b | %1b |\n", x, y, zx, nx, zy, ny, f, no, out, zr, ng);
    endtask

    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);
        file = $fopen("ALU.out","w");
        $fwrite(file, "|        x         |        y         |zx |nx |zy |ny | f |no |       out        |zr |ng |\n");

        $readmemb("ALU.tv", testvectors, 0, 35);

        for (i = 0; i < 36; i = i + 1) begin
            x = testvectors[i][55:40];
            y = testvectors[i][39:24];
            zx = testvectors[i][23];
            nx = testvectors[i][22];
            zy = testvectors[i][21];
            ny = testvectors[i][20];
            f = testvectors[i][19];
            no = testvectors[i][18];
            display();
        end

        $finish();
    end
endmodule



