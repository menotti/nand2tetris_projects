/** 
 * The module hack is our top-level module
 * It connects the external pins of our fpga (hack.pcf)
 * to the internal components (cpu,mem,clk,rst,rom)
 *
 */

`default_nettype none
module top( 
    input CLOCK_50, // 50 MHz clock
    input [3:0] SW,
    output reg [9:0] LEDR = 0);

    // reset logic
    wire reset;
    Reset Reset_0(.clk(CLOCK_50),.reset(reset));

    // hack cpu (nand2tetris)
    wire [15:0] pc;
    wire [15:0] instruction;
    wire [15:0] addressM;
    wire [15:0] inM;
    wire loadM;
    wire [15:0] outM;
    CPU CPU_0(                        
        .clk(CLOCK_50),
        .inM(from_mem_or_io),       // M value input  (M = contents of RAM[A])
        .instruction(instruction),  // Instruction for execution
        .reset(reset),              // Signals whether to re-start the current
                                    // program (rstn==0) or continue executing
                                    // the current program (rstn==1).
        .outM(outM),                // M value output
        .loadM(loadM),              // Write to M? 
        .addressM(addressM),        // Address in data memory to Read(of M)
        .pc(pc)                     // address of next instruction
    );

    // rom stores hack code
    ROM ROM_0(
        .address(pc),
        .data(instruction)
    );

    // mem gives access to ram and io    
    Memory Memory_0(
        .clk(~CLOCK_50),
        .address(addressM),
        .dataR(inM),
        .dataW(outM),
        .load(loadM & isRAM)
    );

    // Memory-mapped IO in IO page, 1-hot addressing   
    localparam IO_LEDS_bit = 0;  // W ten leds
    localparam IO_SW_bit   = 1;  // R ten switches

    wire isIO  = addressM[13];
    wire isRAM = !isIO;
    
    wire [15:0] IO_rdata = {6'b000000, SW};
    wire [15:0] from_mem_or_io = isRAM ? inM : IO_rdata;

    always@(posedge CLOCK_50)
        if (isIO & addressM[IO_LEDS_bit]) 
            LEDR <= outM;
endmodule
