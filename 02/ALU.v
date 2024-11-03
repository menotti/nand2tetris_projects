module ALU(
    input [15:0] x, y,
    input zx, nx, zy, ny, f, no,
    output [15:0] out,
    output zr, ng);

    wire [15:0] outzx, outnx, outzy, outny, outno;

    assign  outzx = zx ? (16'h0000) : (x);
    assign  outnx = nx ? (~outzx) : (outzx);

    assign  outzy = zy ? (16'h0000) : (y);
    assign  outny = ny ? (~outzy) : (outzy);

    assign out = f ? (outnx + outny) : (outnx && outny);

    assign outno = no ? (~out) : (out);

    assign zr = (outno == 16'h0000) ? 1 : 0;
    assign ng = (outno[15] == 1) ? 1 : 0;

endmodule
