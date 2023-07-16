// Name: Danish Mehmood
// Roll No.: 210297

module alu(
  input [31:0] rs, // register source
  input [31:0] rt, // register target
  input [5:0] funct, // function code
  input [31:0] imm, // immediate
  input [5:0] op, // operation code
  input branch, // branch flag
  output reg [31:0] rd, // register destination
  output reg zero, // zero flag
  output reg carry_out, // carry out flag
  output reg branch_taken // branch taken flag
);

  // ALU operation based on function code or operation code
  always @(*) begin
    case (op)
      6'b000000: // R-type instructions
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
      3'b001: // I-type instructions
        case (op[1:0])
          6'b001000: rd = rs + imm;   // addi
          6'b001100: rd = rs & imm;   // andi
          6'b001101: rd = rs | imm;   // ori
          default: rd = 32'hXXXX; // unknown operation code
        endcase
      3'b100: // branching instructions
        case (op[5:0])
          6'b000100: begin                // beq
            if (rs == rt) begin
              branch_taken = 1;
              rd = imm;
            end else begin
              branch_taken = 0;
              rd = rs;
            end
          end
          6'b000101: begin                // bne
            if (rs != rt) begin
              branch_taken = 1;
              rd = imm;
            end else begin
              branch_taken = 0;
              rd = rs;
            end
          end
          6'b000010: begin                // j
            branch_taken = 1;
            rd = pc + 4;
          end
          default: rd = 32'hXXXX;     // unknown operation code
        endcase
      default: rd = 32'hXXXX;         // unknown operation code
    endcase
  end

  // zero flag
  assign zero = (rd == 0);

  // carry out flag for subtractions
  assign carry_out = (rt[0] & ~rs[0] & rd[0]) | (~rt[0] & rs[0] & rd[0]);

endmodule
