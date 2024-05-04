module Sign_ext (
    input wire [31:7] in,
    input wire [1:0] opcode,
    output reg [31:0] out
);

// Efficiently assign output based on opcode using concatenation
always @* begin
    case(opcode)
        2'b00: out = {{20{in[31]}}, in[31:20]}; // I-type instruction
        2'b01: out = {{20{in[31]}}, in[31:25], in[11:7]}; // S-type instruction
        2'b10: out = {{20{in[31]}}, in[7], in[31:25], in[11:8], 1'b0}; // B-type instruction
        2'b11: out = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0}; // J-type instruction
        default: out = 32'hxxxxxxxx; // Default value
    endcase
end

endmodule
