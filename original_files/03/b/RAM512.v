module RAM512(
    input [15:0] in,
    input [8:0] address,
    input load,clk,
    output [15:0] out);

    wire [7:0] load_signals;
    wire [15:0] ram_out [7:0];

   
    DMux8Way dmux(load, address[8:6], load_signals[0], load_signals[1], load_signals[2], load_signals[3],
                  load_signals[4], load_signals[5], load_signals[6], load_signals[7]);

    RAM64 ram0(.in(in), .address(address[5:0]), .load(load_signals[0]),.clk(clk), .out(ram_out[0]));
    RAM64 ram1(.in(in), .address(address[5:0]), .load(load_signals[1]),.clk(clk), .out(ram_out[1]));
    RAM64 ram2(.in(in), .address(address[5:0]), .load(load_signals[2]),.clk(clk), .out(ram_out[2]));
    RAM64 ram3(.in(in), .address(address[5:0]), .load(load_signals[3]),.clk(clk), .out(ram_out[3]));
    RAM64 ram4(.in(in), .address(address[5:0]), .load(load_signals[4]),.clk(clk), .out(ram_out[4]));
    RAM64 ram5(.in(in), .address(address[5:0]), .load(load_signals[5]),.clk(clk), .out(ram_out[5]));
    RAM64 ram6(.in(in), .address(address[5:0]), .load(load_signals[6]),.clk(clk), .out(ram_out[6]));
    RAM64 ram7(.in(in), .address(address[5:0]), .load(load_signals[7]),.clk(clk), .out(ram_out[7]));

    
    Mux8Way16 mux(ram_out[0], ram_out[1], ram_out[2], ram_out[3], 
                  ram_out[4], ram_out[5], ram_out[6], ram_out[7], address[8:6], out);

endmodule
