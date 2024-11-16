/**
 * The module rom provides access to the instruction memory
 * of hack. The instruction memory is read only (ROM) and
 * preloaded with 4Kx16bit of Hackcode.
 * 
 * The signal data (16bit) provides the instruction at memory address
 * data = ROM[address]
 */

module ROM(
    input  wire clk,
    input  wire [15:0] address,
    output reg  [15:0] data        
);

    initial 
        $readmemb("blinky.hack", regROM);
    
    reg [15:0] regROM [0:1023];

    always @(posedge clk)
        data <= regROM[address];
endmodule
