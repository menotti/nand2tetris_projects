module Bit(
    input clk, in, load, 
    output reg out = 0);

    always@(posedge clk)
        if (load)
            out = in;
endmodule