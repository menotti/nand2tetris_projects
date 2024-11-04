module PC(
    input clk, reset, load, inc,
    input [15:0] in, 
    output reg [15:0] out = 0);

    always@(posedge clk)
        if (reset)
            out = 0;
        else if (load)
            out = in;
        else if (inc)
            out = out + 1;
        else
            out = out;
endmodule