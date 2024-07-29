
#include "pwm_core.h"


PwmCore::PwmCore(uint32_t core_base_addr) {
	base_addr = core_base_addr;
	set_pwm_frequency(200);
	set_duty_cycle(0.1,0);
	set_duty_cycle(0.3,1);
	set_duty_cycle(0.5,2);
	set_duty_cycle(0.7,3);
	write_ctrl_reg(0x0000001f);
}
PwmCore::~PwmCore(){
}

void PwmCore::set_pwm_frequency(uint32_t frequency){
	dvsr_reg = SYS_CLK_FREQ * (1000000) / (frequency*256);
	io_write(base_addr,PWM_DVSR_REG,dvsr_reg);
}

void PwmCore::set_duty_cycle(double duty_cycle,uint32_t ch_num){
	uint32_t temp = uint32_t(duty_cycle*256);
		temp = temp << (ch_num*8);
	switch(ch_num){
	case 0:
		duty_reg = duty_reg & ~DUTY_CH0_FIELD;
		break;
	case 1:
		duty_reg = duty_reg & ~DUTY_CH1_FIELD;
		break;
	case 2:
		duty_reg = duty_reg & ~DUTY_CH2_FIELD;
		break;
	case 3:
		duty_reg = duty_reg & ~DUTY_CH3_FIELD;
		break;
	default: duty_reg = duty_reg;

	}
	duty_reg = duty_reg | temp  ;
	io_write(base_addr,PWM_DUTY_REG,duty_reg);
}



void PwmCore::write_ctrl_reg(uint32_t command) {
	pwm_ctrl_reg = command;
	io_write(base_addr,PWM_CTRL_REG,pwm_ctrl_reg);
}

void PwmCore::start_channel(uint8_t channel_number){
	uint32_t channel_bit_position = channel_number + 1;
	bit_set(pwm_ctrl_reg,channel_bit_position);
	io_write(base_addr,PWM_CTRL_REG,pwm_ctrl_reg);
	}

void PwmCore::start_pwm(){
	pwm_ctrl_reg |= DVSR_EN_FIELD;
	io_write(base_addr,0,pwm_ctrl_reg);
}

void PwmCore::stop_pwm(){
	pwm_ctrl_reg &= ~DVSR_EN_FIELD;
	io_write(base_addr,0,pwm_ctrl_reg);
}
