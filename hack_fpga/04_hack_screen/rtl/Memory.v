module Memory(
    input  wire clk,
    input  wire [15:0] address,
    input  wire [15:0] vaddr,
    input  wire [15:0] dataW,
    output reg [15:0] dataR,
    output reg [15:0] vdata,
    input  wire load);

    reg [15:0] RAM [0:32767];
    // 0x0000-0x3FFF: RAM   (16K words = 32KB)
    // 0x4000-0x5FFF: Screen (8k words = 16KB)
    // 0x6000-0x7FFF: Unused (8k words = 16KB)

    `ifdef BENCH
    integer i;
    initial 
        for(i=0; i<32767; i++) 
            RAM[i] = 0;
    `endif

    always @(posedge clk)
    begin
        dataR <=  RAM[address[14:0]];
        vdata <=  RAM[vaddr[14:0]];
        if (load) 
            RAM[address[14:0]] <= dataW;
    end
endmodule
