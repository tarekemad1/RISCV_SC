module mux2x1 #(parameter n = 32)(
    input wire sel,
    input wire [n-1:0] in0, in1,
    output reg [n-1:0] out
);

// Use a conditional assignment instead of an always block
always @* begin
    out = (sel) ? in1 : in0;
end

endmodule
