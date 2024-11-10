module RegisterRAM8(
    input clk, load,
    input [15:0] in, 
    output reg [15:0] out = 0);

    always@(negedge clk)
        if (load)
            out = in;
endmodule

