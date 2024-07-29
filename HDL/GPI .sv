module	GPI(addr,
			read,
			write,
			read_data,
			write_data,
			cs,
			clk,
			rst,
			data_in);
			

input read;
input write;
input cs;
input clk;
input rst;
input [31:0] write_data;
input [4:0] addr;
input [3:0] data_in;

output [31:0] read_data;

reg [3:0] GPI_reg;

always@(posedge clk , posedge rst)
if(rst) GPI_reg <= 0;
else GPI_reg <= data_in;

assign read_data[3:0] = GPI_reg;
assign read_data[31:4] = 0;


endmodule