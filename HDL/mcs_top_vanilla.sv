module mcs_top_vanilla(clk,
					   reset,
					   sw,
					  // led,
					   tx,
					   rx,
					   pwm_ch0,
					   pwm_ch1,
					   pwm_ch2,
					   pwm_ch3,
					  digital_out,
                      pdm_out
					   );
	


input  clk;
input  reset;
input rx;
// switches and LEDs
input  [3:0] sw;
//output  [3:0] led;
output tx;
output pwm_ch3;
output pwm_ch2;
output pwm_ch1;
output pwm_ch0;
output digital_out;
output pdm_out;
wire [15:0] pcm_out;
wire [3:0] led;
wire reset_p = !reset;
//wire reset_n = !reset;
// MCS IO bus
wire io_addr_strobe;
wire io_read_strobe;
wire io_write_strobe;
wire [3:0] io_byte_enable;
wire [31:0] io_address;
wire [31:0] io_write_data;
wire [31:0] io_read_data;
wire io_ready;
// fpro bus 
wire fp_mmio_cs; 
wire fp_write;      
wire fp_read;  
wire fp_video_cs;
wire [20:0] fp_addr;       
wire [31:0] fp_write_data;    
wire [31:0] fp_read_data;    
wire clk_out;
wire locked;
   
   //instantiate uBlaze MCS
   cpu cpu_unit (
    .Clk(clk_out),                     // input wire Clk
    .Reset(reset_p),                  // input wire Reset
    .IO_addr_strobe(io_addr_strobe),    // output wire IO_addr_strobe
    .IO_address(io_address),            // output wire [31 : 0] IO_address
    .IO_byte_enable(io_byte_enable),    // output wire [3 : 0] IO_byte_enable
    .IO_read_data(io_read_data),        // input wire [31 : 0] IO_read_data
    .IO_read_strobe(io_read_strobe),    // output wire IO_read_strobe
    .IO_ready(io_ready),                // input wire IO_ready
    .IO_write_data(io_write_data),      // output wire [31 : 0] IO_write_data
    .IO_write_strobe(io_write_strobe)   // output wire IO_write_strobe
   );
    
   // instantiate bridge
   chu_mcs_bridge	bridge_unit(.io_addr_strobe(io_addr_strobe),
								.io_addr(io_address),
					            //io_byte_enable,
								.io_read_data(io_read_data),
								.io_read_strobe(io_read_strobe),
								.io_ready(io_ready),
								.io_write_data(io_write_data),
								.io_write_strobe(io_write_strobe),
								.fp_addr(fp_addr),
								.fp_read_data(fp_read_data),
								.fp_write_data(fp_write_data),
								.fp_write(fp_write),
								.fp_read(fp_read),
								.fp_mmio_cs(fp_mmio_cs),
								.fp_video_cs(fp_video_cs));
    
   // instantiated i/o subsystem
 mmio_sys_vanilla  mmio_unit (.clk(clk_out),
						      .rst(reset_p),
						      //FPRO BUS SIDE
						      .mmio_addr(fp_addr),
						       .mmio_cs(fp_mmio_cs),
						       .mmio_wr(fp_write),
						       .mmio_rd(fp_read),
						       .mmio_wr_data(fp_write_data),
						       .mmio_rd_data(fp_read_data),
						       //IO MODULES
						       .sw(sw),
						       .led(led),
						       .tx(tx),
						       .rx(rx),
					           .pwm_ch0(pwm_ch0),
					           .pwm_ch1(pwm_ch1),
					           .pwm_ch2(pwm_ch2),
					           .pwm_ch3(pwm_ch3),
					           .digital_out(digital_out),
                               .pdm_out(pdm_out),
                               .pcm_out(pcm_out));
	
	clk_wiz_0 clk_wiz
   (
    // Clock out ports
    .clk_out1(clk_out),     // output clk_out1
    // Status and control signals
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk));      // input clk_in1
   
endmodule    
