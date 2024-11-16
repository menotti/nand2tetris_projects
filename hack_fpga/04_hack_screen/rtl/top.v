`default_nettype none
module top #(parameter VGA_BITS = 8) (
    input CLOCK_50, // 50MHz
    input [3:0] SW,
    output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
    output VGA_HS, VGA_VS,
    output reg VGA_CLK, 
    output VGA_BLANK_N, VGA_SYNC_N,
    output reg [9:0] LEDR = 0);

    always@(posedge CLOCK_50)
        VGA_CLK = ~VGA_CLK; // 25MHz

    // reset logic
    wire reset;
    Reset Reset_0(.clk(CLOCK_50),.reset(reset));

    wire [ 9:0] CounterX, CounterY;
    wire [15:0] logo_addr, hack_pos, hack_vaddr, hack_data;
    wire [23:0] logo_data, background, video, hackscreen, overlay;
    wire vga_DA, hack_pixel; 	 
    vga #(VGA_BITS) vs(VGA_CLK, VGA_HS, VGA_VS, vga_DA, CounterX, CounterY);

    assign background = 24'hF5F5DC; // Beige
    assign logo_addr = (CounterX-112) + (CounterY-316) * 415;
    Nand2Tetris n2t(VGA_CLK, logo_addr, logo_data);
    assign overlay =    CounterX <     112 ? background : 
                        CounterX > 415+112 ? background : 
                        CounterY < 256+ 60 ? background :
                        CounterY > 256+204 ? background : 
                        logo_data;

    assign hack_pos = (CounterX-64) + (CounterY-40) * 512;
    assign hack_vaddr = hack_pos>>4;
    assign hack_pixel = hack_pos[3:0];
    assign hackscreen = {24{hack_pixel}};

    assign  video = CounterX <     64 ? overlay :
                    CounterX > 512+64 ? overlay :
                    CounterY <     40 ? overlay :
                    CounterY > 256+40 ? overlay :
                    hackscreen;
        
    assign VGA_R = vga_DA ? video[23:23-VGA_BITS+1] : {VGA_BITS{1'b0}};
    assign VGA_G = vga_DA ? video[15:15-VGA_BITS+1] : {VGA_BITS{1'b0}};
    assign VGA_B = vga_DA ? video[07:07-VGA_BITS+1] : {VGA_BITS{1'b0}};
    
    assign VGA_BLANK_N = 1'b1;
    assign VGA_SYNC_N  = 1'b0;

    // hack cpu (nand2tetris)
    wire [15:0] pc;
    wire [15:0] instruction;
    wire [15:0] addressM;
    wire [15:0] inM;
    wire loadM;
    wire [15:0] outM;
    CPU CPU_0(                        
        .clk(~CLOCK_50),
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
        .clk(CLOCK_50),
        .address(pc),
        .data(instruction)
    );

    // mem gives access to ram and io    
    Memory Memory_0(
        .clk(CLOCK_50),
        .address(addressM),
        .vaddr(hack_vaddr),
        .dataR(inM),
        .dataW(outM),
        .vdata(hack_data),
        .load(loadM && isRAM)
    );

    // Memory-mapped IO in IO page, 1-hot addressing   
    localparam IO_LEDS_bit = 0;  // W ten leds
    localparam IO_SW_bit   = 1;  // R ten switches

    wire isIO  = addressM[13];
    wire isRAM = !isIO;
    
    wire [15:0] IO_rdata = addressM[IO_LEDS_bit] ?            LEDR : 
                           addressM[IO_SW_bit]   ? {6'b000000, SW} :
                                                              16'bz;
    wire [15:0] from_mem_or_io = isRAM ? inM : IO_rdata;

    always@(posedge CLOCK_50)
        if (loadM && isIO && addressM[IO_LEDS_bit]) 
            LEDR <= outM;
endmodule

