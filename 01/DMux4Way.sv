module DMux4Way(
    input in,
    input [1:0] sel,
    output a, b, c, d
);

    assign {a, b, c, d} = (~sel[1] & ~sel[0]) ? {  in, 1'b0, 1'b0, 1'b0} : 
                          (~sel[1] &  sel[0]) ? {1'b0,   in, 1'b0, 1'b0} :    
                          ( sel[1] & ~sel[0]) ? {1'b0, 1'b0,   in, 1'b0} : 
                                                {1'b0, 1'b0, 1'b0,   in};

    //assign {d, c, b, a} = in << sel;

endmodule
