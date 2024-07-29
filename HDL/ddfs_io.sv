module ddfs_io
   #(parameter PW=30)   // # DDFS bits
   (
    input   clk,
    input   rst,
    // slot interface
    input   cs,
    input   read,
    input   write,
    input   [4:0] addr,
    input   [31:0] write_data,
    output  [31:0] read_data,
    // external signals 
    output  digital_out,
    output  pdm_out,
    output  [15:0] pcm_out
   );

   // declaration
    reg [PW-1:0] pha_reg, fccw_reg, focw_reg;
    wire [PW-1:0] focw, pha;
    reg [15:0] env_reg;
   wire  [15:0] env;
    wire wr_en, wr_fccw, wr_focw, wr_pha, wr_env, wr_ctrl;
   wire [15:0] pcm; 
   
   // instantiate ddfs
   ddfs  ddfs_unit
      (.clk(clk),.rst(rst),.focw(focw),.pha(pha),.env(env),.fccw(fccw_reg), .pcm_out(pcm), .pulse_out(digital_out));
       
   // instantiate 1-bit dac
   DAC #(.W(16)) dac_unit 
      (.*, .pcm_in(pcm));
   assign pcm_out = pcm;
   
   // registers
   always_ff @(posedge clk, posedge rst)
      if (rst) begin
         fccw_reg <= 0;
         focw_reg <= 0;
         pha_reg <= 0;
         env_reg <= 16'h4000;    // 1.00

      end 
      else begin
         if (wr_fccw)
            fccw_reg <= write_data[PW-1:0];
         if (wr_focw)
            focw_reg <= write_data[PW-1:0];
         if (wr_pha)
            pha_reg <= write_data[PW-1:0];
         if (wr_env)
            env_reg <= write_data[15:0];
      end

   assign wr_en = write & cs;
   assign wr_fccw = (addr == 0) & wr_en;
   assign wr_focw = (addr == 1) & wr_en;
   assign wr_pha  = (addr == 2) & wr_en;
   assign wr_env  = (addr == 3) & wr_en;

   assign env  = env_reg;
   assign focw = focw_reg;
   assign pha  = pha_reg;

   assign read_data = addr == 0 ? {2'b00,fccw_reg}:
                      addr == 1 ? {2'b00,focw_reg}:
                      addr == 2 ? {2'b00,pha_reg}:
                      addr == 3 ? {16'b0,env_reg}:
                      addr == 4 ? {16'h0000, pcm}:32'b0 ;
                      
endmodule     


