// Name: Danish Mehmood
// Roll No.: 210297

module inst_fetch_new_tb();

    reg clk, reset, write_enable, mode;
    reg [4:0] address_a, address_b;
    reg [31:0] data_in;
    wire [31:0] data_out;
    
    instruction_fetch inst_fetch(clk, reset, write_enable, address_a, data_in, address_b, mode, data_out);

    initial begin
        clk = 0;
        reset = 1;
        write_enable = 0;
        address_a = 0;
        address_b = 0;
        data_in = 0;
        mode = 0;
        #10 reset = 0;
    end
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
        $monitor("Time=%0t: data_out=%h", $time, data_out);
        
        // Load some instructions into the memory
        // Assuming instructions start at address 0x1000
        // Instruction 1: Add R1, R2, R3
        // Encoding: 0x01432820
        #20 write_enable = 1;
        address_a = 0x1000;
        data_in = 32'h01432820;
        mode = 1'b0; // interpret mode
        #20 write_enable = 0;
        
        // Instruction 2: Sub R4, R5, R6
        // Encoding: 0x018d6022
        #20 write_enable = 1;
        address_a = 0x1004;
        data_in = 32'h018d6022;
        mode = 1'b0; // interpret mode
        #20 write_enable = 0;
        
        // Instruction 3: Jump to address 0x1010 (label "loop")
        // Encoding: 0x0800000d
        #20 write_enable = 1;
        address_a = 0x1008;
        data_in = 32'h0800000d;
        mode = 1'b0; // interpret mode
        #20 write_enable = 0;
        
        // Instruction 4: Addi R1, R1, #1
        // Encoding: 0x20100001
        #20 write_enable = 1;
        address_a = 0x1010;
        data_in = 32'h20100001;
        mode = 1'b0; // interpret mode
        #20 write_enable = 0;
        
        // Instruction 5: Bne R1, R2, loop
        // Encoding: 0x1462fffb
        #20 write_enable = 1;
        address_a = 0x1014;
        data_in = 32'h1462fffb;
        mode = 1'b0; // interpret mode
        #20 write_enable = 0;
        
        // Test the instruction fetch loop
        // The loop should execute 5 times
        // Check that the instructions in IR4 are correct
        #200 $finish;
    end
    
endmodule
