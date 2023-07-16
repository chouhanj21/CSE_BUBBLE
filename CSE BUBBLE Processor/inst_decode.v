// Name: Danish Mehmood
// Roll No.: 210297

module instruction_decode(
  input [31:0] instruction,
  output [3:0] data_path_element
);

  // extract opcode from instruction
  wire [5:0] opcode = instruction[31:26];

  // extract function code from R-type instructions
  wire [5:0] funct = instruction[5:0];

  // determine data path element based on opcode and funct
  always @(*) begin
    case (opcode)
      // I-type instructions
      6'b001000: data_path_element = 4'b0001; // addi
      6'b001001: data_path_element = 4'b0001; // addiu
      6'b001100: data_path_element = 4'b0010; // andi
      6'b001101: data_path_element = 4'b0010; // ori
      6'b100011: data_path_element = 4'b0011; // lw
      6'b101011: data_path_element = 4'b0100; // sw
      6'b000100: data_path_element = 4'b0101; // beq
      6'b000101: data_path_element = 4'b0110; // bne
      6'b000111: data_path_element = 4'b0111; // bgt
      6'b000001: data_path_element = 4'b1000; // bgte/ble
      6'b000110: data_path_element = 4'b1000; // bleq
      6'b001010: data_path_element = 4'b1001; // slti
      // R-type instructions
      6'b000000: case (funct)
                  6'b100000: data_path_element = 4'b0001; // add
                  6'b100010: data_path_element = 4'b0001; // sub
                  6'b100001: data_path_element = 4'b0001; // addu
                  6'b100011: data_path_element = 4'b0001; // subu
                  6'b100100: data_path_element = 4'b0010; // and
                  6'b100101: data_path_element = 4'b0010; // or
                  6'b000000: data_path_element = 4'b0011; // sll
                  6'b000010: data_path_element = 4'b0011; // srl
                  6'b101010: data_path_element = 4'b1001; // slt
                endcase
      // J-type instructions (not included in the case statement because they have a unique format)
      6'b000010, 6'b001000, 6'b000011: data_path_element = 4'b1010; // j, jr, jal
      default: data_path_element = 4'b1111; // unknown opcode
    endcase
  end

endmodule