
module pwm(clk,
		   rst,
		   en_tick,
		   duty,
		   pwm_out,
		   en);
		   


parameter PWM_R = 8;


input clk;
input en;
input rst;
input [PWM_R - 1 : 0] duty;
input en_tick;



output pwm_out;



reg [PWM_R - 1 :0] pwm_reg;
reg pwm_out;
wire pwm_comp ;

always@(posedge clk ,posedge rst) begin
if(rst) begin
	pwm_reg <= 0 ;
	pwm_out <= 0;
	end
else begin
	if(en)begin
	if(en_tick) pwm_reg <= pwm_reg + 1 ;
	pwm_out <= pwm_comp;
	end
	else pwm_out <= 0;
	end
end

assign pwm_comp = pwm_reg <= duty ? 1'b1 : 1'b0;
endmodule



