module Register(
    input clk, load,
    input [15:0] in, 
    output reg [15:0] out = 0);

    always@(posedge clk)
        if (load)
            out = in;
endmodule
