module baud_gen(clk,
				rst,
				B_rate,
				s_tick);

input clk;
input rst;
input [1:0] B_rate;
output s_tick;

				
parameter SYS_CLK = 100000000;

localparam BAUD_4800 = (SYS_CLK)/ (16*4800);  
localparam BAUD_9600 = (SYS_CLK)/ (16*9600);
localparam BAUD_19200 = (SYS_CLK)/ (16*19200);
localparam BAUD_38400 = (SYS_CLK)/ (16*38400);

localparam COUNT1_REG_W = $clog2(BAUD_4800) ;
localparam COUNT2_REG_W = $clog2(BAUD_9600) ;
localparam COUNT3_REG_W = $clog2(BAUD_19200) ;
localparam COUNT4_REG_W = $clog2(BAUD_38400) ;


reg [COUNT1_REG_W : 0 ] counter_1;
reg [COUNT2_REG_W : 0 ] counter_2;
reg [COUNT3_REG_W : 0 ] counter_3;
reg [COUNT4_REG_W : 0 ] counter_4;
reg s_tick_reg;
 
always@(posedge clk , posedge rst) 
if(rst)begin
	counter_1 <= 0 ;
	counter_2 <= 0 ;
	counter_3 <= 0 ;
	counter_4 <= 0 ;
	end
else begin
	counter_1 <= counter_1 + 1;
	counter_2 <= counter_2 + 1;
	counter_3 <= counter_3 + 1;
	counter_4 <= counter_4 + 1;
	if(counter_1 ==  BAUD_4800 - 1) counter_1 <= 0;
	if(counter_2 == BAUD_9600 - 1 ) counter_2 <= 0;
	if(counter_3 == BAUD_19200 - 1) counter_3 <= 0 ;
	if(counter_4 == BAUD_38400 - 1) counter_4 <= 0 ;
end
	



always@* begin
s_tick_reg = 0 ;
case(B_rate) 
2'b00		:		s_tick_reg = (counter_1 ==  BAUD_4800 - 1);
2'b01		:		s_tick_reg = (counter_2 ==  BAUD_9600 - 1);
2'b10		:		s_tick_reg = (counter_3 ==  BAUD_19200 - 1);
2'b11		:		s_tick_reg = (counter_4 ==  BAUD_38400 - 1);
endcase
end


assign s_tick = s_tick_reg;
endmodule
