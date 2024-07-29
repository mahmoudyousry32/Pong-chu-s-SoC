

module chu_mcs_bridge	(io_addr_strobe,
					io_addr,
					//io_byte_enable,
					io_read_data,
					io_read_strobe,
					io_ready,
					io_write_data,
					io_write_strobe,
					fp_addr,
					fp_read_data,
					fp_write_data,
					fp_write,
					fp_read,
					fp_mmio_cs,
					fp_video_cs);
					
parameter BRIDGE_BASE = 32'hc000_0000;

input io_addr_strobe;
input io_read_strobe;
input io_write_strobe;
input [31 : 0] io_addr;
input [31 : 0] io_write_data;
input [31 : 0] fp_read_data;

output io_ready ;
output [20 : 0] fp_addr;
output [31 : 0] io_read_data;
output [31 : 0] fp_write_data;
output fp_write;
output fp_read;
output fp_video_cs;
output fp_mmio_cs;



wire bridge_en;
wire [29 : 0] word_addr;

assign bridge_en = ( io_addr[31:24] == BRIDGE_BASE[31:24] ) ;
assign word_addr = io_addr[31:2];
assign fp_addr = word_addr[20:0];
assign fp_mmio_cs = (bridge_en & ~word_addr[21]);
assign fp_video_cs = (bridge_en & word_addr[21]);
assign fp_read = io_read_strobe;
assign fp_write = io_write_strobe;
assign fp_write_data = io_write_data;
assign io_read_data = fp_read_data;
assign io_ready = 1;

endmodule