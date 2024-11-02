module And(
  input in, sel,
  output a, b);
  assign {a, b} = sel ? {1'b0, in} : {in, 1'b0};
endmodule