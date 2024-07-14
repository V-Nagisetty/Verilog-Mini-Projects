module clkdivider_tb                      ; //testbench module

reg clk, reset                            ; //reg for clk, reset
wire out_clk                              ; //wire for out_clk
reg new_clk                               ; //reg for self-checking output
reg [1:0] clk_count                       ; //reg for count for self-checking

// Instantiation of the design under test (DUT)
clkdivider dut(
    .clk(clk)                             , //input clock
    .reset(reset)                         , //reset 
    .out_clk(out_clk) //output clock
    );

// Initialize signals
initial begin
    new_clk = 1'b0                        ; // Set the self-checking output to 0
    clk_count = 2'b0                      ; // Set clock count to 0
end

// Clock and reset signal generation
initial begin         
    clk = 1'b0                            ; // Initialize clock to 0             
    #1 reset = 1'b1                       ; // Initialize reset to 1
    stimulus                              ; // Call the stimulus task 
    #200 $finish                          ; // Stop execution after 200 time units
end

// Stimulus task to generate clock and reset signals
task stimulus;
    repeat(30) begin
        #3 clk = ~clk                     ; // Toggle the clock every 3 time units
        #10 reset = 1'b0                  ; // Set the reset bit to 0 after 10 time units
        verify(clk); // Call the verify task
    end
endtask

// Verify task to check the output
task verify;
    input clk                             ; // Declaring input for check
    parameter count = 4                   ; // Declaring count
    begin
        if (clk_count == count - 1) begin
            new_clk <= ~new_clk           ; // At count 3 new_clk is inverted
            clk_count <= 2'b0             ; // Reset clock count to 0
        end else begin
            new_clk <= new_clk            ; // Otherwise, it is kept the same
            clk_count <= clk_count + 1    ; // Increment the count by 1
        end

        if (new_clk == out_clk)
            $display("reset=%b clk=%b clk_out=%b new_clk=%b: Testcase Pass", reset, clk, out_clk, new_clk); // Display Pass Testcase
        else
            $display("reset=%b clk=%b clk_out=%b new_clk=%b: Testcase Fail", reset, clk, out_clk, new_clk); // Display Fail Testcase
    end
endtask

endmodule
