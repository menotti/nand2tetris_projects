module Mux4Way16 (
    input [15:0] a, b, c, d,
    input [1:0] sel,
    output [15:0] out
);

    assign out = (sel[1] == 0) ? (sel[0] == 0 ? a : b) : (sel[0] == 0 ? c : d);
    
endmodule
