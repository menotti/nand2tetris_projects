module DMux8Way(
    input in,
    input [2:0] sel,
    output a,b,c,d,e,f,g,h
);


    assign {h, g, f, e, d, c, b, a} = in << sel;

endmodule
