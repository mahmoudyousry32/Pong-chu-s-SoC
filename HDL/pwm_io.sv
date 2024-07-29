`define CTRL_REG {start_ch3,start_ch2,start_ch1,start_ch0,start_dvsr}
`define DUTY_REG {duty_reg_ch3,duty_reg_ch2,duty_reg_ch1,duty_reg_ch0}

module PWM_IO(clk,
			   rst,
			   addr,
			   read,
			   write,
			   read_data,
			   write_data,
			   cs,
			   pwm_ch0,
			   pwm_ch1,
			   pwm_ch2,
			   pwm_ch3
			   );
			   
parameter R = 8;
parameter W = 32;

input clk;
input rst;
input [4:0] addr;
input read;
input write;
input [31:0] write_data;
input cs;



output pwm_ch0;
output pwm_ch1;
output pwm_ch2;
output pwm_ch3;
output [31:0] read_data;



reg en_tick;

reg [W-1 :0] dvsr_counter;
reg [W-1 :0] dvsr_reg;
reg start_dvsr;

reg [R-1 : 0] duty_reg_ch0;
reg start_ch0;

reg [R-1 : 0] duty_reg_ch1;
reg start_ch1;

reg [R-1 : 0] duty_reg_ch2;
reg start_ch2;

reg [R-1 : 0] duty_reg_ch3;
reg start_ch3;

wire wr_ctrl_en;
wire wr_dvsr_en;
wire wr_duty_en;
wire pwm_ch0;
wire pwm_ch1;
wire pwm_ch2;
wire pwm_ch3;

assign wr_ctrl_en = (cs & write & (addr == 0)) ;
assign wr_dvsr_en = (cs & write & (addr == 1));
assign wr_duty_en = (cs & write & (addr == 2));


pwm	   ch0(.clk(clk),
		   .rst(rst),
		   .en_tick(en_tick),
		   .duty(duty_reg_ch0),
		   .pwm_out(pwm_ch0),
		   .en(start_ch0));
		   
pwm	   ch1(.clk(clk),
		   .rst(rst),
		   .en_tick(en_tick),
		   .duty(duty_reg_ch1),
		   .pwm_out(pwm_ch1),
		   .en(start_ch1));

pwm	   ch2(.clk(clk),
		   .rst(rst),
		   .en_tick(en_tick),
		   .duty(duty_reg_ch2),
		   .pwm_out(pwm_ch2),
		   .en(start_ch2));

pwm	   ch3(.clk(clk),
		   .rst(rst),
		   .en_tick(en_tick),
		   .duty(duty_reg_ch3),
		   .pwm_out(pwm_ch3),
		   .en(start_ch3));
		   
		   
		   

//*************************************************************************
//					divisor register write
//*************************************************************************

always@(posedge clk ,posedge rst) begin
	if(rst) begin
	dvsr_reg <= 0;
	end
	else
		if(wr_dvsr_en) dvsr_reg <= write_data ;
		
end

//*************************************************************************
//						Duty register write
//*************************************************************************
always@(posedge clk , posedge rst) begin
if(rst) `DUTY_REG <= 0;
else 
	if(wr_duty_en) `DUTY_REG <= write_data;
end
//*************************************************************************
//						control register write
//*************************************************************************
always@(posedge clk ,posedge rst) begin
if(rst) `CTRL_REG <= 0;
else
	if(wr_ctrl_en) `CTRL_REG <= write_data[4:0];
end

//*************************************************************************
//						Frequency divider
//*************************************************************************

always@(posedge clk ,posedge rst) begin
if(rst) dvsr_counter <= 0;
else begin
	if(start_dvsr) begin

		if (dvsr_counter == dvsr_reg )begin
			dvsr_counter <= 0;
			en_tick <= 1;
			end
		else begin
			en_tick <= 0;
			dvsr_counter <= dvsr_counter + 1 ;
			end
	end
end
end

assign read_data = addr == 0 ? {27'h0 ,start_ch3,start_ch2,start_ch1,start_ch0,start_dvsr} :
				   addr == 1 ? dvsr_reg : 
				   addr == 2 ? `DUTY_REG : 0;

endmodule