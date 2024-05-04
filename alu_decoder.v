module Alu_decoder (
    input wire [1:0] ALUop,
    input wire [2:0] funct3,
    input wire        funct7_5,
    input wire        op_5,
    output reg [1:0] ALUctrl
);

always @(*)
begin
    case(ALUop)
        2'b00: // Adding for lw, sw, jalr
            ALUctrl = 2'b00;
        2'b01: // Subtracting for beq, bne
            ALUctrl = 2'b01;
        2'b10: // R, I-type instructions
            case(funct3)
                3'b000: 
                    if ({op_5, funct7_5} == 3'b11)
                        ALUctrl = 2'b01; // Subtraction for sub
                    else
                        ALUctrl = 2'b00; // Adding for add, addi
                3'b111: 
                    ALUctrl = 2'b10; // Anding for and, andi
                3'b110: 
                    ALUctrl = 2'b11; // Oring for or, ori 
                default: 
                    ALUctrl = 2'bxx;
            endcase
        default: 
            ALUctrl = 2'bxx; 
    endcase
end

endmodule
