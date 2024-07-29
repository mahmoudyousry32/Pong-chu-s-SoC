module 	GPO(addr,
			read,
			write,
			read_data,
			write_data,
			cs,
			clk,
			rst,
			data_out);
			

input read;
input write;
input cs;
input clk;
input rst;
input [31:0] write_data;
input [4:0] addr;

output [31:0] read_data;
output [3:0] data_out;



wire write_en ;
reg [3:0] GPO_reg;

always@(posedge clk , posedge rst)
if(rst) GPO_reg <= 4'b1111;
else if(write_en) GPO_reg <= write_data[3:0];

assign data_out = GPO_reg;
assign write_en = cs & write ; 

endmodule
