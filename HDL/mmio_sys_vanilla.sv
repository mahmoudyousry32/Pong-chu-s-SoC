`include "chu_io_map.svh"

module mmio_sys_vanilla (clk,
						 rst,
						 //FPRO BUS SIDE
					     mmio_addr,
						 mmio_cs,
						 mmio_wr,
						 mmio_rd,
						 mmio_wr_data,
						 mmio_rd_data,
						 //IO MODULES
						 //GPI
						 sw,
						 //GPO
						 led,
						 //UART
						 tx,
						 rx,
						 //PWM
						 pwm_ch0,
						 pwm_ch1,
						 pwm_ch2,
						 pwm_ch3,
				        digital_out,
                        pdm_out,
                        pcm_out
						 );


input clk;
input rst;

//FPRO BUS SIDE
input [20:0] mmio_addr;
input mmio_cs;
input mmio_wr;
input mmio_rd;
input [31:0] mmio_wr_data;
output [31:0] mmio_rd_data;
//IO SIDES
input [3:0] sw;
input rx;
output [3:0] led;
output tx;
output pwm_ch0;
output pwm_ch1;
output pwm_ch2;
output pwm_ch3;
output  digital_out;
output  pdm_out;
output  [15:0] pcm_out;


//CS for each slot
wire [63:0] io_cs;

wire io_rd;
wire io_wr;
wire [31:0] io_wr_data;
wire [4:0] io_reg_addr;

// READ DATA ARRAY 32-bit outputs from each slot
wire [31:0] io_rd_data [63:0];




mmio_controller		ctrl_unit	(.clk(clk),
								.rst(rst),
								.mmio_addr(mmio_addr),
								.mmio_cs(mmio_cs),
								.mmio_wr(mmio_wr),
								.mmio_rd(mmio_rd),
								.mmio_rd_data(mmio_rd_data),
								.mmio_wr_data(mmio_wr_data),
								.io_cs(io_cs),
								.io_rd(io_rd),
								.io_wr(io_wr),
								.io_rd_data(io_rd_data),
								.io_wr_data(io_wr_data),
								.io_reg_addr(io_reg_addr));
								
								
								
GPI			gpi_slot3(.addr(io_reg_addr),
					.read(io_rd),
					.write(io_wr),
					.read_data(io_rd_data[`S3_SW]),
					.write_data(io_wr_data),
					.cs(io_cs[`S3_SW]),
					.clk(clk),
					.rst(rst),
					.data_in(sw));
					
GPO		gpo_slot2(.addr(io_reg_addr),
				.read(io_rd),
				.write(io_wr),
				.read_data(io_rd_data[`S2_LED]),
				.write_data(io_wr_data),
				.cs(io_cs[`S2_LED]),
				.clk(clk),
				.rst(rst),
				.data_out(led));
				
chu_timer   timer_slot0(.addr(io_reg_addr),
				        .read(io_rd),
				        .write(io_wr),
				        .read_data(io_rd_data[`S0_SYS_TIMER]),
				        .write_data(io_wr_data),
				        .cs(io_cs[`S0_SYS_TIMER]),
				        .clk(clk),
				        .rst(rst));


UART_IO       uart_slot1(.clk(clk),
			   .rst(rst),
			   .addr(io_reg_addr),
			   .read(io_rd),
			   .write(io_wr),
			   .read_data(io_rd_data[`S1_UART]),
			   .write_data(io_wr_data),
			   .cs(io_cs[`S1_UART]),
			   .tx(tx),
			   .rx(rx));
						
PWM_IO		pwm_slot6(.clk(clk),
					  .rst(rst),
			   	  	  .addr(io_reg_addr),
			   	  	  .read(io_rd),
			   	  	  .write(io_wr),
			   	  	  .read_data(io_rd_data[`S6_PWM]),
			   	  	  .write_data(io_wr_data),
			   	  	  .cs(io_cs[`S6_PWM]),
			   	  	  .pwm_ch0(pwm_ch0),
					  .pwm_ch1(pwm_ch1),
				      .pwm_ch2(pwm_ch2),
					  .pwm_ch3(pwm_ch3)
			   	  	  );
ddfs_io ddfs_slot12
       (.clk(clk),
       .rst(rst),
    // slot interface
       .cs(io_cs[`S12_DDFS]),
       .read(io_rd),
       .write(io_wr),
       .addr(io_reg_addr),
      .write_data(io_wr_data),
       .read_data(io_rd_data[`S12_DDFS]),
    // external signals 
      .digital_out(digital_out),
      .pdm_out(pdm_out),
      .pcm_out(pcm_out)
   );
						
generate
      genvar i;
      for (i=13; i<64; i=i+1) begin:  unused_slot_gen
         assign io_rd_data[i] = 32'hffffffff;
      end
   endgenerate

 assign io_rd_data[5] = 32'hffffffff;
 assign io_rd_data[7] = 32'hffffffff;
 assign io_rd_data[8] = 32'hffffffff;						
 assign io_rd_data[9] = 32'hffffffff;
  assign io_rd_data[10] = 32'hffffffff;
 assign io_rd_data[11] = 32'hffffffff;		
endmodule