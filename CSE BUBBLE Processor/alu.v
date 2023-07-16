// Name: Danish Mehmood
// Roll No.: 210297

module alu_r(
  input [31:0] rs, // register source
  input [31:0] rt, // register target
  input [5:0] funct, // function code
  output reg [31:0] rd, // register destination
  output reg zero, // zero flag
  output reg carry_out // carry out flag
);

  //ALU operation based on function code
  always @(*) begin
    case (funct)
      6'b100000: rd = rs + rt;          // add
      6'b100010: rd = rs - rt;          // sub
      6'b100001: rd = rs + rt;          // addu
      6'b100011: rd = rs - rt;          // subu
      6'b100100: rd = rs & rt;          // and
      6'b100101: rd = rs | rt;          // or
      6'b000000: rd = rs << rt;         // sll
      6'b000010: rd = rs >> rt;         // srl
      6'b101010: rd = (rs < rt) ? 1:0;  // slt
      default: rd = 32'hXXXX;           // unknown function code
    endcase
  end

  // zero flag
  assign zero = (rd == 0);

  // carry out flag for subtractions
  assign carry_out = (rt[0] & ~rs[0] & rd[0]) | (~rt[0] & rs[0] & rd[0]);

endmodule
module alu_i(
  input [31:0] rs, // register source
  input [31:0] imm, // immediate
  input [5:0] alu_op, // ALU operation
  output reg [31:0] rd, // register destination
  output reg zero, // zero flag
  output reg carry_out // carry out flag
);

  // ALU operation based on ALU control signals
  always @(*) begin
    case (alu_op)
      6'b001000: rd = rs + imm;   // addi
      6'b001100: rd = rs & imm;   // andi
      6'b001101: rd = rs | imm;   // ori
      6'b011010: rd = rs - imm;   // subi
      6'b001010: rd = (rs < imm) ? 1:0;   // slti
      default: rd = 32'hXXXX;  // unknown ALU operation
    endcase
  end

  // zero flag
  assign zero = (rd == 0);

  // carry out flag for subtractions
  assign carry_out = (imm[0] & ~rs[0] & rd[0]) | (~imm[0] & rs[0] & rd[0]);

endmodule
module alu_j(
  input [31:0] pc, // program counter
  input [25:0] target, // jump target
  output reg [31:0] new_pc, // new program counter
  output reg zero, // zero flag
  output reg carry_out // carry out flag
);

  // new PC value for jump instructions
  always @(*) begin
    new_pc = {pc[31:28], target, 2'b00};
  end

  // zero flag
  assign zero = 1;

  // carry out flag
  assign carry_out = 0;

endmodule
