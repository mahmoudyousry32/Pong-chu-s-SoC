/*****************************************************************//**
 * @file main_vanilla_test.cpp
 *
 * @brief Basic test of 4 basic i/o cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

//#define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include <inttypes.h>
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "pwm_core.h"
#include "DdfsCore.h"

// instantiate switch, led

int main() {

	GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
	GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
	timercore t1(get_slot_addr(BRIDGE_BASE,S0_SYS_TIMER));
	UartCore U1(get_slot_addr(BRIDGE_BASE,S1_UART1));
	PwmCore P1(get_slot_addr(BRIDGE_BASE,S6_PWM));
	DdfsCore D1(get_slot_addr(BRIDGE_BASE,S12_DDFS));
	//P1.set_pwm_frequency(10);

	uint32_t data = 0;
	uint32_t address = get_slot_addr(BRIDGE_BASE,S6_PWM);
	double duty = 0;
	//io_write(address,1,(uint32_t)1000000);
	//io_write(address,2,0x7f7f7f7f);
	//io_write(address,0,0x0000001f);

	data = io_read(address,1);
	data = io_read(address,2);
	data = io_read(address,0);

    U1.set_baud_rate(9600);
    for(uint32_t i = 0 ; i <= 32 ; i++){
    	U1.disp("Test \r\n");
    }

while(1){
	if(duty >= 253.44) duty = 0 ;
	for(int i = 0 ; i <= 65104 ; i++){

	}
			duty = duty + 0.00390625 ;
			P1.set_duty_cycle(duty,0);
			P1.set_duty_cycle(duty,1);
			P1.set_duty_cycle(duty,2);
			P1.set_duty_cycle(duty,3);


 //main
}
}
