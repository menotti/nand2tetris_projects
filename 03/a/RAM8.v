module RAM8(
    input [15:0] in,
    input [2:0] address, 
    input load,
    input clk,
    output reg [15:0] out);

    reg [15:0] memory [7:0];  // 8 registradores, cada um com 16 bits de largura

    always @(negedge clk) begin
        out = memory[address];
    end

    always @(posedge clk) begin
        if (load) begin
            memory[address] <= in;
        end
    end

endmodule
