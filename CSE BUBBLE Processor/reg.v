// Name: Danish Mehmood
// Roll No.: 210297

module reg (
  input clk, reset, write_enable,
  input [31:0] data_in,
  input [4:0] address_reg,
  input mode,
  output reg [31:0] data_out,
  output reg [31:0] ir4,
  output reg [31:0] ir3
);

  parameter scribble = 1'b0, interpret = 1'b1;

  reg [31:0] memory [0:31];
  reg [31:0] intermediate_data;
  reg [31:0] intermediate_reg;

  always @ (posedge clk) begin
    if (reset) begin
      ir3 <= 32'd0;
      ir4 <= 32'd0;
      for (i = 0; i < 32; i = i + 1) begin
        memory[i] <= 32'b0;
      end
    end
    else begin
      ir4 <= data_out;
      if (write_enable && mode == scribble) begin
        memory[address_a] <= data_in;
      end
      else if (write_enable) begin
        memory[address_b] <= data_in;
      end
      else if (mode == interpret) begin
        data_out <= memory[address_b];
      end
      ir3 <= ir3 + 32'd4;
      address_b <= ir3;
      mode <= interpret;
    end
  end

endmodule

//veda code
module veda (clk, reset, write_enable, address_a, data_in,
address_b, mode, data_out);
parameter scribble = 1'b0, interpret = 1'b1;
input clk, reset, write_enable, mode;
input [4:0] address_a, address_b;
input [31:0] data_in;
output [31:0] data_out;
always @ (posedge clk or posedge reset) begin
if (reset) begin
for (i = 0; i < 32; i = i + 1) begin
memory[i] <= 32'b0;
end
end
else begin
if (write_enable && mode == scribble) begin
memory[address_a] <= data_in;
intermediate_reg <= data_in;
end
else if (write_enable) begin
memory[address] <= data_in;
intermediate_data <= memory[address_b];
end
else if (mode == scribble) begin
intermediate_reg <= data_in;
end
else if (mode == interpret) begin
intermediate_reg <= memory[address_b];
end
end
end
always @ (posedge clk) begin
data_out <= intermediate_reg;
end
endmodule
