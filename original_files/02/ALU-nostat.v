module ALUnostat(
    input [15:0] x, y,
    input zx, nx, zy, ny, f, no,
    output [15:0] out);

    wire [15:0] outzx, outnx, outzy, outny, outf;

    assign  outzx = zx ? (16'h0000) : (x);
    assign  outnx = nx ? (~outzx) : (outzx);

    assign  outzy = zy ? (16'h0000) : (y);
    assign  outny = ny ? (~outzy) : (outzy);

    assign outf = f ? (outnx + outny) : (outnx & outny);

    assign out = no ? (~outf) : (outf);

endmodule
