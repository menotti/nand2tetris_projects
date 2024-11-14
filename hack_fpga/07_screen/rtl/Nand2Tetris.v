module rom(
  input [15:0] vaddr,
  output[23:0] vdata);
  
  reg [23:0] ROM [0:59759];
  
  initial
    $readmemh("Nand2Tetris.hex", ROM);

  assign vdata = ROM[vaddr];
endmodule