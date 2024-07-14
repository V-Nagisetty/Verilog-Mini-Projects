module clkdivider(
                  reset                   ,//input
                  clk                     ,//input
                  out_clk                  //output
                  )                       ;
//port declaration
input             reset, clk              ;//input declaration 
output reg        out_clk                 ;//output declaration
reg         [1:0] clk_count               ;//register for count

/*The clock count increments on each positive edge of the input clock, and the output clock is the MSB of the clock count, making its period twice that of the input clock.*/
always @ (posedge clk)
   begin
      if (reset)
         begin
            clk_count <= 0                ;//reset clk count
            out_clk   <= 0                ;//reset output
         end
      else
         begin
            clk_count <= clk_count + 1    ;//clock count is incremented
            out_clk   <= clk_count[1]     ;
         end
   end
endmodule             
