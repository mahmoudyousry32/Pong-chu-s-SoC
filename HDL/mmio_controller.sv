module 	mmio_controller(clk,
						rst,
						mmio_addr,
						mmio_cs,
						mmio_wr,
						mmio_rd,
						mmio_rd_data,
						mmio_wr_data,
						io_cs,
						io_rd,
						io_wr,
						io_rd_data,
						io_wr_data,
						io_reg_addr);


input clk;
input rst;
input [20:0] mmio_addr;
input mmio_cs;
input mmio_wr;
input mmio_rd;
input [31:0] io_rd_data [63:0];
input [31:0] mmio_wr_data;

output [63:0] io_cs;
output  io_rd;
output  io_wr;
output [31:0] io_wr_data ;
output [31:0] mmio_rd_data;
output [4:0] io_reg_addr;


reg [63:0] io_cs_reg;
wire [5:0] io_core_addr = mmio_addr[10:5];
//reg [31:0] mmio_rd_data_reg;

//io cores cs from bus to io cores
always@*begin
io_cs_reg = 0; 
if(mmio_cs) 
	io_cs_reg[io_core_addr] = 1'b1;
end

assign io_wr_data = mmio_wr_data;
assign mmio_rd_data = mmio_cs ? io_rd_data[io_core_addr] : 0;
assign io_wr = mmio_wr;
assign io_rd = mmio_rd;
assign io_reg_addr = mmio_addr[4:0];
assign io_cs = io_cs_reg;

endmodule

//reg [31:0] mmio_rd_data_reg;

//io cores cs from bus to io cores
/*
always@* begin
if(mmio_cs)
	for(i = 0 ; i <= 63 ; i = i + 1 )
		if(io_core_addr == i) io_cs_reg[i] = 1;
		else io_cs_reg[i] = 0;
else io_cs_reg = 0;
end
*/
/*read data multiplexer from the io cores to the bus
always@* begin
	for(i = 0 ; i <= 63 ; i = i + 1 )
		if(io_core_addr == i) mmio_rd_data_reg = io_rd_data[i];
		else mmio_rd_data_reg = 0;
end
*/
