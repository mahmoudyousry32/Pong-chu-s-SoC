module UART_IO(clk,
			   rst,
			   addr,
			   read,
			   write,
			   read_data,
			   write_data,
			   cs,
			   tx,
			   rx);
			   

input clk;
input rst;
input [4:0] addr;
input read;
input write;
input [31:0] write_data;
input cs;
input rx;



output [31:0] read_data;
output tx;

reg [1:0] BAUD_reg;
wire rd_uart_en;
wire wr_uart_en ;
wire wr_BAUD_en;
wire tx_full;
wire rx_empty;
wire [7:0] rd_data;
wire tx_idle;
wire rx_full;

assign wr_BAUD_en = (write & cs & (addr == 1));
assign wr_uart_en = (write & cs & (addr == 2));
assign rd_uart_en = (read & cs & (addr == 3));
assign read_data = {20'h0 ,tx_full,tx_idle,rx_full,rx_empty,rd_data};

UART	  U1(.clk(clk),
			 .rst(rst),
			 .tx(tx),
			 .rx(rx),
			 .rd_uart(rd_uart_en),
			 .wr_uart(wr_uart_en),
			 .rx_empty(rx_empty),
			 .rd_data(rd_data),
			 .wr_data(write_data[7:0]),
			 .tx_full(tx_full),
			 .B_rate(BAUD_reg),
			 .tx_idle(tx_idle),
			 .rx_full(rx_full));
			 




always@(posedge clk,posedge rst) begin
if(rst) BAUD_reg <= 0 ;
else if(wr_BAUD_en) BAUD_reg <= write_data[1:0];
end




endmodule
