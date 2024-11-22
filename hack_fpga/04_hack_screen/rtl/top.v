`default_nettype none
module top #(parameter VGA_BITS = 8) (
    input CLOCK_50, // 50MHz
    input [3:0] SW,
    output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
    output VGA_HS, VGA_VS,
    output reg VGA_CLK, 
    output VGA_BLANK_N, VGA_SYNC_N,
    output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
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

    // Video generation
    always@(posedge CLOCK_50)
        VGA_CLK = ~VGA_CLK; // 25MHz

    wire [ 9:0] CounterX, CounterY;
    wire [15:0] logo_addr, hack_pos, hack_vaddr, hack_data;
    wire [23:0] logo_data, background, video, hackscreen, overlay;
    wire vga_DA, hack_pixel, VGA_HSi, VGA_VSi; 	 
    vga #(VGA_BITS) vs(VGA_CLK, VGA_HS, VGA_VS, vga_DA, CounterX, CounterY);

    assign background = 24'hF5F5DC; // Beige
    assign logo_addr = (CounterX-112) + (CounterY-316) * 415 + 1;
    Nand2Tetris n2t(VGA_CLK, logo_addr, logo_data);
    assign overlay =    CounterX <     112   ? background : 
                        CounterX > 415+112   ? background : 
                        CounterY < 256+ 60   ? background :
                        CounterY > 256+204-1 ? background : 
                        logo_data;

    assign hack_pos = (CounterX-64) + (CounterY-40) * 512;
    assign hack_vaddr =   16384 + hack_pos>>4;
    assign hack_pixel = hack_data[hack_pos[3:0]];
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

    // Memory-mapped IO in IO page, 1-hot addressing   
    localparam IO_KBD_bit   = 0;  // R keyboard status
    localparam IO_SW_bit    = 1;  // R ten switches
    localparam IO_LEDS_bit  = 2;  // RW ten leds
    localparam IO_HEX30_bit = 3;  // RW four (3-0) seven-segment display
    localparam IO_HEX54_bit = 4;  // RW two (5-4) seven-segment display

    wire isIO  = addressM[13];
    wire isRAM = !isIO;
    
    wire [15:0] IO_rdata =  addressM[IO_KBD_bit]   ? 16'b0 :
                            addressM[IO_SW_bit]    ? {6'b000000, SW} :
                            addressM[IO_LEDS_bit]  ? LEDR :
                            addressM[IO_HEX30_bit] ? hex_digits[15:0] : 
                            addressM[IO_HEX54_bit] ? {8'b0000000, hex_digits[23:16]} : 
                                                     16'bz;
    wire [15:0] from_mem_or_io = isRAM ? inM : IO_rdata;

    always@(posedge CLOCK_50)
        if (loadM && isIO) begin
            if (addressM[IO_LEDS_bit]) 
                LEDR <= outM;
            if (addressM[IO_HEX30_bit]) 
                hex_digits[15:0] <= outM;
            if (addressM[IO_HEX54_bit])
                hex_digits[23:16] <= outM[7:0];
        end

    reg [23:0] hex_digits; 
    dec7seg0 dec7seg0_0(hex_digits[ 3: 0], HEX0);
    dec7seg0 dec7seg0_1(hex_digits[ 7: 4], HEX1);
    dec7seg0 dec7seg0_2(hex_digits[11: 8], HEX2);
    dec7seg0 dec7seg0_3(hex_digits[15:12], HEX3);
    dec7seg0 dec7seg0_4(hex_digits[19:16], HEX4);
    dec7seg0 dec7seg0_5(hex_digits[23:20], HEX5);
endmodule
