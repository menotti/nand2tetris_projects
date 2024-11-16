module FullAdder(
    input a, b, carry_in,
    output sum, carry_out);

    wire sum1;
    wire [1:0] carry;

    HalfAdder halfadder1(a, b, sum1, carry[0]);
    HalfAdder halfadder2(sum1, carry_in, sum, carry[1]);
    assign carry_out = carry[0] | carry[1];

endmodule
