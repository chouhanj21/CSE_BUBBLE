// Name: Danish Mehmood
// Roll No.: 210297

module fsm_controller (
    input [31:0] instr,
    input clk,
    output reg [5:0] alu_op,
    output reg [5:0] funct,
    output reg use_alu_r,
    output reg use_alu_i,
    output reg use_alu_j,
    output reg branch,
    output reg jump
);

reg [5:0] opcode;

always @(posedge clk) begin
    opcode = instr[31:26];
    funct = instr[5:0];
    branch <= 0;
    jump <= 0;

    case (opcode)
        6'b000000: begin // R-type instruction
            use_alu_r <= 1;
            use_alu_i <= 0;
            use_alu_j <= 0;
            alu_op <= 6'b000000;
            case (funct)
                6'b100000: alu_op <= 6'b100000; // add
                6'b100010: alu_op <= 6'b100010; // sub
                6'b100100: alu_op <= 6'b100100; // and
                6'b100101: alu_op <= 6'b100101; // or
                6'b101010: alu_op <= 6'b101010; // slt
                default: alu_op <= 6'b000000;
            endcase
        end
        6'b001000: begin // addi
            use_alu_r <= 0;
            use_alu_i <= 1;
            use_alu_j <= 0;
            alu_op <= 6'b001000;
        end
        6'b001100: begin // andi
            use_alu_r <= 0;
            use_alu_i <= 1;
            use_alu_j <= 0;
            alu_op <= 6'b001100;
        end
        6'b001101: begin // ori
            use_alu_r <= 0;
            use_alu_i <= 1;
            use_alu_j <= 0;
            alu_op <= 6'b001101;
        end
        6'b011010: begin // subi
            use_alu_r <= 0;
            use_alu_i <= 1;
            use_alu_j <= 0;
            alu_op <= 6'b011010;
        end
        6'b001010: begin // slti
            use_alu_r <= 0;
            use_alu_i <= 1;
            use_alu_j <= 0;
            alu_op <= 6'b001010;
        end
        6'b000100: begin // beq
            branch <= 1;
            jump <= 0;
            use_alu_r <= 0;
            use_alu_i <= 0;
            use_alu_j <= 0;
            alu_op <= 6'b000100;
        end
        6'b000101: begin // bne
            branch <= 1;
            jump <= 0;
            use_alu_r <= 0;
            use_alu_i <= 0;
            use_alu_j <= 0;
            alu_op <= 6'b000101;
        end
        6'b000010: begin // j
            branch <= 0;
            jump <= 1;
            use_alu_r <= 0;
            use_alu_i <= 0;
            use_alu_j <= 1;
            alu_op <= 6'b000000;
        end
        6'b000011: begin // jal
            branch <= 0;
            jump <= 1;
            use_alu_r <= 0;
            use_alu_i <= 0;
            use_alu_j <= 1;
            alu_op <= 6'b000011;
        end
        default: begin
            use_alu_r <= 0;
            use_alu_i <= 0;
            use_alu_j <= 0;
            alu_op <= 6'b000000;
        end
    endcase
end

endmodule
