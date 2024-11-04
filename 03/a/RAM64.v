module RAM64(
    input [15:0] in,
    input [5:0] address,
    input load, 
    output [15:0] out);

    reg [15:0] memory [63:0];  // 64 registradores, cada um com 16 bits de largura

    always @(*) begin
        out = memory[address];
    end

    always @(posedge load) begin
        if (load) begin
            memory[address] <= in;
        end
    end

endmodule