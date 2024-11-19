module Memory(
    input  wire clk,
    input  wire [15:0] address,
    input  wire [15:0] dataW,
    output reg [15:0] dataR,
    input  wire load);

    reg [15:0] RAM [0:8191];

    `ifdef BENCH
    integer i;
    initial 
        for(i=0; i<8192; i++) 
            RAM[i] = 0;
    `endif

    always @(posedge clk)
    begin
        dataR <=  RAM[address[12:0]];
        if (load) 
            RAM[address[12:0]] <= dataW;
    end
endmodule
