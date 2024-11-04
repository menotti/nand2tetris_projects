module RAM8(input clk, load
	    input [15:0] in,
	    input [2:0] address, 
	    output [15:0] out);
    
    wire [15:0] r1_o, r2_o, r3_o, r4_o, r5_o, r6_o, r7_o, r8_o; 

    Register r1 (clk, load, in, r1_o);
    Register r2 (clk, load, in, r2_o);
    Register r3 (clk, load, in, r3_o);
    Register r4 (clk, load, in, r4_o);
    Register r5 (clk, load, in, r5_o);
    Register r6 (clk, load, in, r6_o);
    Register r7 (clk, load, in, r7_o);
    Register r8 (clk, load, in, r8_o);

    Mux8Way16 mx (r1_o, r2_o, r3_o, r4_o, r5_o, r6_o, r7_o, r8_o, address, out);

endmodule
