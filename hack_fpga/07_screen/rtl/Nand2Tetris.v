module Nand2Tetris(
  input clock,
  input [15:0] addr,
  output reg [23:0] data);
  reg [23:0] rom [0:59759];
  initial
    $readmemh("Nand2Tetris.hex", rom);
  always @(posedge clock)
    data <= rom[addr];
endmodule