// Name: Danish Mehmood
// Roll No.: 210297

`timescale 1ns/1ps

module top_tb();
    reg clk;
    wire [31:0] pc_in, pc_out;

    wire [ 5:0] im_ctr;
    wire [ 5:0] im_funcode;
    wire [31:0] im_instruction;

    wire [31:0] r_wbdata,  // dm_out
    r_read1, r_read2;

    wire c_RegDst, c_Jump, c_Branch, c_Bne, c_MemRead, c_MemtoReg, c_MemWrite, c_ALUSrc, c_RegWrite;
    wire [1:0] c_ALUOp;

    wire [3:0] c_ALUcontrol;

    wire c_zero;
    wire [31:0] alu_result;

    // Instantiate the top module
    top u_top (
        .clk(clk)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test case procedure
    initial begin
        // Test case initialization
        clk = 0;
        #100 $finish;
    end
endmodule
