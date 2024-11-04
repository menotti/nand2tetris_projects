module RAM8(
    input [15:0] in,
    input [2:0] address, 
    input load,
    input clk,
    output reg [15:0] out);

    reg [15:0] memory [7:0];  // 8 registradores, cada um com 16 bits de largura

    initial out = 16'h0000;

    always @(posedge clk) begin
        out = memory[address];
    end

    always @(negedge clk) begin
        if (load) begin
            memory[address] <= in;
        end
    end

endmodule
