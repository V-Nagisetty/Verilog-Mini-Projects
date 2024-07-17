module bit4counter(
                   reset    ,
                   enable   ,
                   clk      ,
                   count_out,
                   count
                   );

input reset,enable, clk  ;
output reg [3:0]count_out;
output reg [3:0]count    ;
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            count <= 4'b0000  ;  // Reset the counter to 0
        else if (enable)
            count <= count + 1; // Increment the count on each clock edge when enabled
    end

    assign count_out = count;

endmodule
