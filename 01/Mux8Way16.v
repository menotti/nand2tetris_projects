module Mux8Way16(
    input [15:0] a, b, c, d, e, f, g, h,
    input [2:0] sel,
    output [15:0] out
);


    assign out = (sel[2] == 0) ? (sel[1] == 0 ? (sel[0] == 0 ? a : b) : (sel[0] == 0 ? c : d)) : (sel[1] == 0 ? (sel[0] == 0 ? e : f) : (sel[0] == 0 ? g : h));

endmodule
