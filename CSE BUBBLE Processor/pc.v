// Name: Danish Mehmood
// Roll No.: 210297

module Program_counter (
    clk,
    PC_next,
    PC_out
);

input clk;
input [31:0] PC_next;
output reg [31:0] PC_out;

initial begin
    PC_out = -4;   // preventing default
end

always @ (posedge clk) begin
    PC_out = PC_next;
end

endmodule