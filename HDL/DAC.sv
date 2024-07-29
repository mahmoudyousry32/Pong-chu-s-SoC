module DAC 
   #(parameter W=16)       
   (
    input  logic clk, rst,
    input  logic [W-1:0] pcm_in, 
    output logic pdm_out
   );
   

   localparam BIAS = 2**(W-1);  
   logic [W:0] pcm_biased;
   logic [W:0] acc_next;
   logic [W:0] acc_reg;
   
  
   assign pcm_biased = {pcm_in[W - 1], pcm_in} + BIAS;

   assign acc_next = {1'b0, acc_reg[W-1:0]} + pcm_biased;
   always_ff @(posedge clk, posedge rst)
   if (rst)
      acc_reg <= 0;
   else
      acc_reg <= acc_next;
   // output
   assign pdm_out = acc_reg[W];
endmodule   

