module RAM16K(input clk, load,
	    input [15:0] in,
	    input [13:0] address, 
	    output [15:0] out);

    wire [15:0] r_o [0:3]; 
    wire [3:0] load_signals;

    DMux4Way dmx (.in(load), .sel(address[13:12]), .a(load_signals[0]), .b(load_signals[1]), .c(load_signals[2]), .d(load_signals[3]));

    RAM4K r1 (.clk(clk), .load(load_signals[0]), .in(in), .address(address[11:0]), .out(r_o[0]));
    RAM4K r2 (.clk(clk), .load(load_signals[1]), .in(in), .address(address[11:0]), .out(r_o[1]));
    RAM4K r3 (.clk(clk), .load(load_signals[2]), .in(in), .address(address[11:0]), .out(r_o[2]));
    RAM4K r4 (.clk(clk), .load(load_signals[3]), .in(in), .address(address[11:0]), .out(r_o[3]));

    Mux4Way16 mx (.a(r_o[0]), .b(r_o[1]), .c(r_o[2]), .d(r_o[3]), .sel(address[13:12]), .out(out));


endmodule