`timescale 1ns / 1ps   // Timescale directive for simulation

module bit4counter_tb;

    // Parameters
    parameter CLK_PERIOD = 10;  // Clock period in ns
    
    // Signals
    reg reset, clk, enable;
    wire [3:0] count_out;
    
    // Instantiate the counter module
    counter4bit dut (
        .reset(reset),
        .clk(clk),
        .enable(enable),
        .count_out(count_out)
    );
    
    // Clock generation
    always begin
        #((CLK_PERIOD / 2));  // Half-period delay
        clk <= ~clk;          // Toggle clock
    end
    
    // Initial stimulus
    initial begin
        reset = 1; enable = 0;  // Assert reset and disable counter
        #20 reset = 0;           // De-assert reset
        #10 enable = 1;          // Enable the counter after a delay
        
        // Test case 1: Check initial state after reset
        #100;
        $display("Test case 1: Initial state");
        if (count_out === 4'b0000)
            $display("Initial state passed");
        else
            $display("Initial state failed");
        
        // Test case 2: Check counting behavior
        #100;
        $display("Test case 2: Counting behavior");
        #100 $monitor("Count = %b", count_out);  // Monitor count_out
        
        // Test case 3: Verify wrap-around
        #100;
        $display("Test case 3: Wrap-around behavior");
        enable = 0;  // Disable counter temporarily
        #50 enable = 1;  // Re-enable counter
        #200 $monitor("Count = %b", count_out);  // Monitor count_out
        
        // End simulation
        #100 $finish;
    end

endmodule
