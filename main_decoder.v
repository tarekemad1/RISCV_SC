module main_decoder (
    input wire [6:0] op,
    output reg jump,
    output reg jalr,
    output reg branch,
    output reg [1:0] immsrc,
    output reg ALUsrc,
    output reg [1:0] ALUop,
    output reg [1:0] resultsrc,
    output reg regwr,
    output reg memwr
);



// Determine instruction type
reg [2:0] instr_type;
always @* begin
    instr_type[2] = (op[6] == 1'b1 && op[5:3] == 3'b000) ? 1 : 0; // R-type
    instr_type[1] = (op == 7'b1100011) ? 1 : 0; // Branch
    instr_type[0] = (op == 7'b1101111) ? 1 : 0; // Jump
end

// Decode based on instruction type
always@(*)
begin
  case(op)
    7'b0000011 : //lw instruction
    begin
      regwr     = 1'b1  ;
      immsrc    = 2'b00 ;
      ALUsrc    = 1'b1  ;
      memwr     = 1'b0  ;
      resultsrc = 2'b01 ;
      branch    = 1'b0  ; 
      ALUop     = 2'b00 ;
      jump      = 1'b0  ;
      jalr      = 1'b0  ;
    end
    7'b0100011 : //sw instruction
    begin
      regwr     = 1'b0  ;
      immsrc    = 2'b01 ;
      ALUsrc    = 1'b1  ;
      memwr     = 1'b1  ;
      resultsrc = 2'bxx ;
      branch    = 1'b0  ; 
      ALUop     = 2'b00 ;
      jump      = 1'b0  ;
      jalr      = 1'b0  ;
    end
    7'b0110011 : //R-type instruction
    begin
      regwr     = 1'b1  ;
      immsrc    = 2'bxx ;
      ALUsrc    = 1'b0  ;
      memwr     = 1'b0  ;
      resultsrc = 2'b00 ;
      branch    = 1'b0  ; 
      ALUop     = 2'b10 ;
      jump      = 1'b0  ;
      jalr      = 1'b0  ;
    end
    7'b1100011 : //beq instruction 
    begin
      regwr     = 1'b0  ;
      immsrc    = 2'b10 ;
      ALUsrc    = 1'b0  ;
      memwr     = 1'b0  ;
      resultsrc = 2'bxx ;
      branch    = 1'b1  ; 
      ALUop     = 2'b01 ;
      jump      = 1'b0  ;
      jalr      = 1'b0  ;
    end
    7'b0010011 : //I-type instruction (except jalr)
    begin
      regwr     = 1'b1  ;
      immsrc    = 2'b00 ;
      ALUsrc    = 1'b1  ;
      memwr     = 1'b0  ;
      resultsrc = 2'b00 ;
      branch    = 1'b0  ; 
      ALUop     = 2'b10 ;
      jump      = 1'b0  ;
      jalr      = 1'b0  ;
    end
    7'b1101111 : //jal instruction
    begin
      regwr     = 1'b1  ;
      immsrc    = 2'b11 ;
      ALUsrc    = 1'bx  ;
      memwr     = 1'b0  ;
      resultsrc = 2'b10 ;
      branch    = 1'b0  ; 
      ALUop     = 2'bxx ;
      jump      = 1'b1  ;
      jalr      = 1'b0  ;
    end
    7'b1100111 : //jalr instruction
    begin
      regwr     = 1'b1  ;
      immsrc    = 2'b00 ;
      ALUsrc    = 1'b1  ;
      memwr     = 1'b0  ;
      resultsrc = 2'b10 ;
      branch    = 1'b0  ; 
      ALUop     = 2'b00 ;
      jump      = 1'b0  ;
      jalr      = 1'b1  ;
    end
    default : 
    begin
      regwr     = 1'bx  ;
      immsrc    = 2'bxx ;
      ALUsrc    = 1'bx  ;
      memwr     = 1'bx  ;
      resultsrc = 2'bxx ;
      branch    = 1'bx  ; 
      ALUop     = 2'bxx ;
      jump      = 1'bx  ;
      jalr      = 1'bx  ;
    end
  endcase
end
endmodule
