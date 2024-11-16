module RAM4K(input clk, load,
	    input [15:0] in,
	    input [11:0] address, 
	    output [15:0] out);
    
    wire [15:0] r_o [0:7]; 
    wire [7:0] load_signals;

    DMux8Way dmx (load, address[11:9], load_signals[0], load_signals[1], load_signals[2], load_signals[3], load_signals[4], load_signals[5], load_signals[6], load_signals[7]);

    RAM512 r1 (.clk(clk), .load(load_signals[0]), .in(in), .address(address[8:0]), .out(r_o[0]));
    RAM512 r2 (.clk(clk), .load(load_signals[1]), .in(in), .address(address[8:0]), .out(r_o[1]));
    RAM512 r3 (.clk(clk), .load(load_signals[2]), .in(in), .address(address[8:0]), .out(r_o[2]));
    RAM512 r4 (.clk(clk), .load(load_signals[3]), .in(in), .address(address[8:0]), .out(r_o[3]));
    RAM512 r5 (.clk(clk), .load(load_signals[4]), .in(in), .address(address[8:0]), .out(r_o[4]));
    RAM512 r6 (.clk(clk), .load(load_signals[5]), .in(in), .address(address[8:0]), .out(r_o[5]));
    RAM512 r7 (.clk(clk), .load(load_signals[6]), .in(in), .address(address[8:0]), .out(r_o[6]));
    RAM512 r8 (.clk(clk), .load(load_signals[7]), .in(in), .address(address[8:0]), .out(r_o[7]));

    Mux8Way16 mx (r_o[0], r_o[1], r_o[2], r_o[3], r_o[4], r_o[5], r_o[6], r_o[7], address[11:9], out);

endmodule
