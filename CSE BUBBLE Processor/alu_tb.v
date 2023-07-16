// Name: Danish Mehmood
// Roll No.: 210297


`timescale 1ns/1ps

module alu_testbench();

  // Inputs
  reg [31:0] rs;
  reg [31:0] rt;
  reg [31:0] imm;
  reg [5:0] funct;
  reg [5:0] alu_op;
  reg [25:0] target;
  reg clk;

  // Outputs
  wire [31:0] rd;
  wire zero;
  wire carry_out;
  wire [31:0] new_pc;

  // Instantiate the ALU modules
  alu_r dut_r(.rs(rs), .rt(rt), .funct(funct), .rd(rd), .zero(zero), .carry_out(carry_out));
  alu_i dut_i(.rs(rs), .imm(imm), .alu_op(alu_op), .rd(rd), .zero(zero), .carry_out(carry_out));
  alu_j dut_j(.pc(rs), .target(target), .new_pc(new_pc), .zero(zero), .carry_out(carry_out));

  // Clock generator
  always #5 clk = ~clk;

  // Test cases
  initial begin
    // Test case 1: Addition (ALU_R)
    rs = 10; rt = 20; funct = 6'b100000;
    #10;
    if (rd !== 30 || zero !== 0 || carry_out !== 0) $error("Test case 1 failed");

    // Test case 2: Subtraction (ALU_R)
    rs = 20; rt = 10; funct = 6'b100010;
    #10;
    if (rd !== 10 || zero !== 0 || carry_out !== 1) $error("Test case 2 failed");

    // Test case 3: Immediate addition (ALU_I)
    rs = 10; imm = 5; alu_op = 6'b001000;
    #10;
    if (rd !== 15 || zero !== 0 || carry_out !== 0) $error("Test case 3 failed");

    // Test case 4: Immediate subtraction (ALU_I)
    rs = 20; imm = 10; alu_op = 6'b011010;
    #10;
    if (rd !== 10 || zero !== 0 || carry_out !== 1) $error("Test case 4 failed");

    // Test case 5: Jump (ALU_J)
    rs = 100; target = 10; 
    #10;
    if (new_pc !== 104 || zero !== 1 || carry_out !== 0) $error("Test case 5 failed");

    // Add more test cases here

    $display("All test cases passed");
  end

endmodule
