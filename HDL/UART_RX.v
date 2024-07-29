module 	UART_RX(clk,
				rst,
				rx,
				rx_done,
				dout,
				s_tick);
				
input clk;
input rst;
input s_tick;
input rx;


parameter DBITS = 8;
parameter SBITS = 1;

output [DBITS - 1 : 0] dout;
output rx_done;

localparam	IDLE 	= 3'b000;
localparam	START	= 3'b001;
localparam	DATA	= 3'b010;
localparam	STOP	= 3'b011 ;
localparam	DONE	= 3'b100;

reg [3:0] s_tick_count;
reg [2:0] dbits_count;
reg [2:0] state_reg;
reg [DBITS - 1 : 0] rx_reg;
reg done_reg;

always@(posedge clk,posedge rst)
if(rst)begin 
	state_reg <= IDLE ; 
	dbits_count <= 0 ;
	s_tick_count <= 0;
	rx_reg <= 0;
	end
else
	case(state_reg)
	
	IDLE			:			begin
									if(!rx) begin 
										state_reg <= START;
										s_tick_count <= 0;
									end
								end
	
	START			:			begin
									if(s_tick)
										if(s_tick_count == 7)begin
											s_tick_count <= 0;
											state_reg <= DATA;
										end
										else
											s_tick_count <= s_tick_count + 1; 
								end
	
	DATA			:			begin
									if(s_tick)
										if(s_tick_count == 15)begin
											s_tick_count <= 0;
											rx_reg <= {rx,rx_reg[7:1]};
											if(dbits_count == DBITS - 1)begin 
												state_reg <= STOP;
												dbits_count <= 0;
											end
											else
												dbits_count <= dbits_count + 1;
										end
										else
											s_tick_count <= s_tick_count + 1; 										
								end
								
	STOP			:			begin
									if(s_tick)
										if(s_tick_count == 15)begin
											s_tick_count <= 0;
											if(dbits_count == SBITS - 1)begin 
												state_reg <= DONE;
												dbits_count <= 0 ;
												done_reg <= 1;
											end
											else 
												dbits_count <= dbits_count + 1; 
										end
										else
											s_tick_count <= s_tick_count + 1; 
								end
								
	DONE			:			begin
								state_reg <= IDLE;
								done_reg <= 0;
								end
	endcase


assign rx_done = done_reg;
assign dout    = rx_reg;

endmodule