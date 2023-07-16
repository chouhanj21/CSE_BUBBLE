// Name: Danish Mehmood
// Roll No.: 210297

module instruction_decode_tb;

  // Inputs
  reg [31:0] instruction;

  // Outputs
  wire [3:0] data_path_element;

  // Instantiate the unit under test (UUT)
  instruction_decode uut (
    .instruction(instruction),
    .data_path_element(data_path_element)
  );

  initial begin
    // Initialize inputs
    instruction = 32'h001000; // addi

    // Wait for 10ns to allow for output to stabilize
    #10;

    // Check output
    if (data_path_element !== 4'b0001) begin
      $display("ERROR: addi instruction did not produce expected data path element");
    end else begin
      $display("addi instruction produced expected data path element");
    end

    // Repeat for additional instructions
    instruction = 32'h100011; // lw
    #10;
    if (data_path_element !== 4'b0011) begin
      $display("ERROR: lw instruction did not produce expected data path element");
    end else begin
      $display("lw instruction produced expected data path element");
    end

    // Add more test cases for other instructions

    // Finish simulation
    $finish;
  end

endmodule
