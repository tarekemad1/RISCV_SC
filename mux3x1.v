module mux3x1 #(parameter n = 32)(
    input wire [1:0] sel,
    input wire [n-1:0] in0, in1, in2,
    output reg [n-1:0] out
);

// Use a single conditional assignment instead of multiple if-else statements
always @* begin
    case (sel)
        2'b10: out = in2;
        2'b01: out = in1;
        default: out = in0;
    endcase
end

endmodule
