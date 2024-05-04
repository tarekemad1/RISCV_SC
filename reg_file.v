module Reg_file (
    input wire clk,
    input wire rst,
    input wire [4:0] Addr1,
    input wire [4:0] Addr2,
    input wire [4:0] Addr3,
    input wire [31:0] wd3,
    input wire we3,
    output reg [31:0] rd1,
    output reg [31:0] rd2
);

reg [31:0] temp [0:31];
integer i;
// Clock edge-triggered read and write operations
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset initialization
        for (i = 0; i < 32; i = i + 1) begin
            temp[i] <= 32'h0;
        end
    end
    else begin
        // Write operation
        if (we3) begin
            temp[Addr3] <= wd3;
        end
    end
end

// Combinational reading
always @* begin
    rd1 = (Addr1 == 5'b0) ? 32'h0 : temp[Addr1];
    rd2 = (Addr2 == 5'b0) ? 32'h0 : temp[Addr2];
end

endmodule
