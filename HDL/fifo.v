module 	fifo(clk,
			 rst,
			 rd,
			 wr_data,
			 rd_data,
			 wr,
			 full,
			 empty);

parameter FIFO_DEPTH = 32 ; 
parameter FIFO_WIDTH = 8 ;
localparam ADDR_W 	= $clog2(FIFO_DEPTH);



input clk;
input rst;
input rd;
input wr;
input [FIFO_WIDTH - 1 :0] wr_data;

output empty;
output full;
output [FIFO_WIDTH - 1 :0] rd_data;


 
reg [FIFO_WIDTH - 1:0] REG_FILE [FIFO_DEPTH -1 :0] ;
integer i;
wire wr_en;
wire [ADDR_W - 1:0] wr_addr;
wire [ADDR_W - 1:0] rd_addr;
reg full_reg,empty_reg;
reg [ADDR_W - 1 : 0] wr_pointer,rd_pointer;
wire[ADDR_W - 1 : 0] wr_pointer_next , rd_ponter_next;





always@(posedge clk ,posedge rst) begin
if(rst)
	for(i = 0 ; i <= FIFO_DEPTH ; i = i + 1) 
		REG_FILE[i] <= 0;
else if(wr_en)
	REG_FILE[wr_addr] <= wr_data;
end
/*
*
*
*
*
*
*/
//REGISTER FILE CONTROLLER



always@(posedge clk,posedge rst) begin
if(rst) begin
	full_reg <= 0;
	empty_reg <= 1;
	wr_pointer <= 0;
	rd_pointer <= 0;
	end
else
	case({wr,rd})
	2'b01			:		begin 
								if(!empty_reg) begin
									rd_pointer <= rd_pointer + 1 ;
									full_reg <= 0 ;
								end
								if(rd_ponter_next == wr_pointer) empty_reg <= 1;
							end
	
	2'b10			:		begin
								if(!full_reg) begin
									wr_pointer <= wr_pointer + 1;
									empty_reg <= 0;
									end
								if(wr_pointer_next == rd_pointer) full_reg <= 1;
							end
	
	2'b11			:		begin	
								rd_pointer <= rd_pointer + 1 ;
								wr_pointer <= wr_pointer + 1 ;
							end
	endcase
end

//COMP LOGIC 
assign rd_ponter_next = rd_pointer + 1 ;
assign wr_pointer_next = wr_pointer + 1;
assign full = full_reg;
assign empty = empty_reg;
assign wr_en = !full & wr;
assign wr_addr = wr_pointer ;
assign rd_addr = rd_pointer;
assign rd_data = REG_FILE[rd_addr];

endmodule


	