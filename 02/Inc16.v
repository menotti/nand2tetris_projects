module Inc16(
    input [15:0] in,
    output [15:0] out);

    wire [15:0] val;
    assign val = 16'h0001;

    Add16 add16_1(in, val, out);

endmodule
