module chu_timer(addr,
				  read,
				  write,
				  read_data,
				  write_data,
				  cs,
				  clk,
				  rst);
				  
				  
				  
input read;
input write;
input cs;
input clk;
input rst;
input [31:0] write_data;
input [4:0] addr;


output [31:0] read_data;



reg [31:0] count_l;    //addr 0 
reg [31:0] ctrl;       // addr 1      ctrl[0]---start         ctrl[1]---clear     

wire write_en;



always@(posedge clk , posedge rst)
if(rst)
			  ctrl <= 0;
			  
else begin
			if(write_en && addr == 1)
			ctrl[1:0] <= write_data[1:0] ;
			end
			
always@(posedge clk,posedge rst)
if(rst) begin
		 count_l <= 0;
		 end
else begin
		if(ctrl[0]) count_l <= count_l + 1;
 		else if (ctrl[1]) count_l <= 0;
		else if (write_en && addr == 0) count_l <= write_data;
	end



assign read_data = addr == 0 ? count_l :
				   addr == 1 ? ctrl 	:
				   0;
assign write_en = cs & write;


endmodule