module ddfs(clk,
			rst,
			fccw,
			focw,
			pha,
			env,
			pcm_out,
			pulse_out);

parameter phase_reg_W = 30;

input clk;
input rst;
input [phase_reg_W-1:0] fccw;
input [phase_reg_W-1:0] focw;
input [phase_reg_W-1:0] pha;
input signed [15:0] env;

output [15:0] pcm_out;
output pulse_out ;

wire [phase_reg_W-1:0] fcw;
wire [phase_reg_W-1:0] pcw;
wire [7:0] addr_r;
wire signed [15:0] dout;
wire signed [31:0] multi;
assign fcw = fccw + focw;




reg [phase_reg_W-1 : 0 ]  phase_reg;


 
always@(posedge clk ,posedge rst)
if(rst) phase_reg <= 0;
else phase_reg <= phase_reg + fcw;

assign pcw = phase_reg + pha;
assign addr_r = pcw[phase_reg_W-1 : phase_reg_W-8];


sin_rom	   ROM(.clk(clk),
			   .addr_r(addr_r),
			   .dout(dout));


assign multi = env * dout ;
assign pcm_out = multi[29:14];
assign pulse_out = phase_reg[phase_reg_W-1];
endmodule
