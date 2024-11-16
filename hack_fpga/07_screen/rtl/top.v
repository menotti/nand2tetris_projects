module top #(parameter VGA_BITS = 8) (
  input CLOCK_50, // 50MHz
  input [3:0] SW,
  output [VGA_BITS-1:0] VGA_R, VGA_G, VGA_B,
  output VGA_HS, VGA_VS,
  output reg VGA_CLK, 
  output VGA_BLANK_N, VGA_SYNC_N);
  
  always@(posedge CLOCK_50)
    VGA_CLK = ~VGA_CLK; // 25MHz
	
  wire [ 9:0] CounterX, CounterY;
  wire [15:0] vaddr;
  wire [23:0] vdata, background, video;
  assign background = 24'hF5F5DC; // Beige
  
  wire vga_DA; 	 
  vga #(VGA_BITS) vs(VGA_CLK, VGA_HS, VGA_VS, vga_DA, CounterX, CounterY);
  assign vaddr = (CounterX-112) + (CounterY-316) * 415;
  Nand2Tetris n2t(VGA_CLK, vaddr, vdata);

  assign video = CounterX <     112 ? background : 
                 CounterX > 415+112 ? background : 
                 CounterY < 256+ 60 ? background :
                 CounterY > 256+204 ? background : 
                 vdata;
    
  assign VGA_R = vga_DA ? video[23:23-VGA_BITS+1] : {VGA_BITS{1'b0}};
  assign VGA_G = vga_DA ? video[15:15-VGA_BITS+1] : {VGA_BITS{1'b0}};
  assign VGA_B = vga_DA ? video[07:07-VGA_BITS+1] : {VGA_BITS{1'b0}};
  
  assign VGA_BLANK_N = 1'b1;
  assign VGA_SYNC_N  = 1'b0;
endmodule