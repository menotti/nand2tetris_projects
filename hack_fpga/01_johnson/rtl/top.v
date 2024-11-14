module top (
    input CLOCK_50,
    output [9:0] LEDR);
    integer count = 0;
    always@(posedge CLOCK_50)
        count <= count + 1;
    reg [9:0] johnson = 10'b0000000000;
    always@(posedge count[19])
        johnson <= {johnson, ~johnson[9]};
    assign LEDR = johnson;
endmodule