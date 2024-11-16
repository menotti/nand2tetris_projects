/*
 * The module mem provides access to memory RAM 
 * and memory mapped IO
 * In our Minimal-Hack-Project we will use 4Kx16 Bit RAM
 * 
 * address | memory
 * ----------------
 * 0-4047  | RAM
 * 8192    | but
 * 8193    | led
 *
 * WRITE:
 * When load is set to 1, 16 bit dataW are stored to Memory address
 * at next clock cycle. M[address] <= dataW
 * READ:
 * dataR provides data stored in Memory at address.
 * dataR = M[address]
 *
 */

module Memory(
    input  wire clk,
    input  wire [15:0] address,
    input  wire [15:0] vaddr,
    input  wire [15:0] dataW,
    output reg [15:0] dataR,
    output reg [15:0] vdata,
    input  wire load);

    reg [15:0] RAM [0:16383];

    `ifdef BENCH
    integer i;
    initial 
        for(i=0; i<16384; i++) 
            RAM[i] = 0;
    `endif

    always @(posedge clk)
    begin
        dataR <=  RAM[address[13:0]];
        vdata <=  RAM[vaddr[13:0]];
        if (load) 
            RAM[address[13:0]] <= dataW;
    end
endmodule
