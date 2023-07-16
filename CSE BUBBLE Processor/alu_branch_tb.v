// Name: Danish Mehmood
// Roll No.: 210297


module alu_tb;

  reg [31:0] rs, rt, imm;
  reg [5:0] funct;
  reg [5:0] op;
  reg branch;
  
  wire [31:0] rd;
  wire zero, carry_out, branch_taken;
  
  alu dut(.rs(rs), .rt(rt), .funct(funct), .imm(imm), .op(op), .branch(branch),
          .rd(rd), .zero(zero), .carry_out(carry_out), .branch_taken(branch_taken));
  
  initial begin
    // R-type instruction test (add)
    rs = 32'h0000000A;
    rt = 32'h00000005;
    funct = 6'b100000;
    op = 6'b000000;
    branch = 0;
    #10;
    if (rd !== 32'h0000000F || zero !== 0 || carry_out !== 0 || branch_taken !== 0) begin
      $display("R-type instruction test (add) failed");
    end else begin
      $display("R-type instruction test (add) passed");
    end
    
    // I-type instruction test (addi)
    rs = 32'h0000000A;
    rt = 32'h00000000;
    imm = 32'h00000005;
    op = 6'b001000;
    branch = 0;
    #10;
    if (rd !== 32'h0000000F || zero !== 0 || carry_out !== 0 || branch_taken !== 0) begin
      $display("I-type instruction test (addi) failed");
    end else begin
      $display("I-type instruction test (addi) passed");
    end
    
    // Branching instruction test (beq)
    rs = 32'h0000000A;
    rt = 32'h0000000A;
    imm = 32'h00000008;
    op = 6'b000100;
    branch = 1;
    #10;
    if (rd !== 32'h0000000C || zero !== 0 || carry_out !== 0 || branch_taken !== 1) begin
      $display("Branching instruction test (beq) failed");
    end else begin
      $display("Branching instruction test (beq) passed");
    end
    
    // Unknown instruction test
    rs = 32'h00000000;
    rt = 32'h00000000;
    imm = 32'h00000000;
    op = 6'b111111;
    branch = 0;
    #10;
    if (rd !== 32'hXXXX || zero !== 0 || carry_out !== 0 || branch_taken !== 0) begin
      $display("Unknown instruction test failed");
    end else begin
      $display("Unknown instruction test passed");
    end
  end
  
endmodule
