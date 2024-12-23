module RAM8(input clk, load,
	    input [15:0] in,
	    input [2:0] address, 
	    output [15:0] out);
    
    // reg [15:0] ram [7:0];
    // always@(negedge clk)
    //     if (load)
    //         ram[address] <= in;
    // assign out = ram[address];
    wire [15:0] r1_o, r2_o, r3_o, r4_o, r5_o, r6_o, r7_o, r8_o; 
    wire load1, load2, load3, load4, load5, load6, load7, load8;

    DMux8Way dmx (load, address, load1, load2, load3, load4, load5, load6, load7, load8);

    RegisterRAM8 r1 (clk, load1, in, r1_o);
    RegisterRAM8 r2 (clk, load2, in, r2_o);
    RegisterRAM8 r3 (clk, load3, in, r3_o);
    RegisterRAM8 r4 (clk, load4, in, r4_o);
    RegisterRAM8 r5 (clk, load5, in, r5_o);
    RegisterRAM8 r6 (clk, load6, in, r6_o);
    RegisterRAM8 r7 (clk, load7, in, r7_o);
    RegisterRAM8 r8 (clk, load8, in, r8_o);

    Mux8Way16 mx (r1_o, r2_o, r3_o, r4_o, r5_o, r6_o, r7_o, r8_o, address, out);

endmodule


