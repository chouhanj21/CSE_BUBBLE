// Name: Danish Mehmood
// Roll No.: 210297

`timescale 1ns / 1ps

module fsm_controller_tb();

reg [31:0] instr;
reg clk;
wire [5:0] alu_op;
wire [5:0] funct;
wire use_alu_r;
wire use_alu_i;
wire use_alu_j;
wire branch;
wire jump;

// Instantiate the fsm_controller module
fsm_controller uut (
    .instr(instr),
    .clk(clk),
    .alu_op(alu_op),
    .funct(funct),
    .use_alu_r(use_alu_r),
    .use_alu_i(use_alu_i),
    .use_alu_j(use_alu_j),
    .branch(branch),
    .jump(jump)
);

// Clock generation
always begin
    #5 clk = ~clk;
end

// Stimuli generation and checking
initial begin
    clk = 0;

    // R-type instruction: add
    instr = 32'b000000_00001_00010_00010_00000_100000; // add $2, $1, $2
    #10;
    if (alu_op == 6'b100000 && funct == 6'b100000 && use_alu_r == 1)
        $display("R-type instruction (add) test passed");
    else
        $display("R-type instruction (add) test failed");

    // I-type instruction: addi
    instr = 32'b001000_00010_00010_0000_0000_0001; // addi $2, $2, 1
    #10;
    if (alu_op == 6'b001000 && use_alu_i == 1)
        $display("I-type instruction (addi) test passed");
    else
        $display("I-type instruction (addi) test failed");

    // I-type instruction: bne
    instr = 32'b000101_00010_00001_0000_0000_0001; // bne $2, $1, 1
    #10;
    if (alu_op == 6'b000101 && branch == 1)
        $display("I-type instruction (bne) test passed");
    else
        $display("I-type instruction (bne) test failed");

    // J-type instruction: j
    instr = 32'b000010_0000_0100_0000_0000_0000_0000; // j 0x400
    #10;
    if (alu_op == 6'b000000 && use_alu_j == 1 && jump == 1)
        $display("J-type instruction (j) test passed");
    else
        $display("J-type instruction (j) test failed");

    $finish;
end

endmodule
