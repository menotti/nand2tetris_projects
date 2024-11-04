module RAM64(
    input clk, load
    input [15:0] in,
    input [5:0] address,
    output reg [15:0] out);

    wire [15:0] r1_o, r2_o, r3_o, r4_o, r5_o, r6_o, r7_o, r8_o

    RAM8 r1(clk, load, address[2:0], r1_o);
    RAM8 r2(clk, load, address[2:0], r2_o);
    RAM8 r3(clk, load, address[2:0], r3_o);
    RAM8 r4(clk, load, address[2:0], r4_o);
    RAM8 r5(clk, load, address[2:0], r5_o);
    RAM8 r6(clk, load, address[2:0], r6_o);
    RAM8 r7(clk, load, address[2:0], r7_o);
    RAM8 r8(clk, load, address[2:0], r8_o);

    Mux8Way16 mux1(r1_o, r2_o, r3_o, r4_o, r5_o, r6_o, r7_o, r8_o, address[5:3], out);

endmodule