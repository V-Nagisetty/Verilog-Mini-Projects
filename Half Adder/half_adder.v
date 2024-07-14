module half_adder(a,b,sum,carry);              

input  a,b;                          
output sum,carry;

assign sum   =  a ^ b ;//xor operation
assign carry =  a & b ;//and operation
  
endmodule 
