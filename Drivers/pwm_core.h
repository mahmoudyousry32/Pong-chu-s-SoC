
#ifndef _PWM_CORE_H_INCLUDED
#define _PWM_CORE_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"
#include "chu_init.h"

class PwmCore {

public:

	  enum {
		  PWM_CTRL_REG = 0,
	      PWM_DVSR_REG = 1,
	      PWM_DUTY_REG = 2

	   };


	    enum {
	      DUTY_CH0_FIELD = 0x000000ff,
		  DUTY_CH1_FIELD = 0x0000ff00,
		  DUTY_CH2_FIELD = 0x00ff0000,
		  DUTY_CH3_FIELD = 0xff000000,
		  DVSR_EN_FIELD= 0x00000001,
		  CH0_EN_FIELD= 0x00000002,
		  CH1_EN_FIELD= 0x00000004,
		  CH2_EN_FIELD= 0x00000008,
		  CH3_EN_FIELD= 0x00000010
	   };

   PwmCore(uint32_t core_base_addr);
   ~PwmCore();

   void set_pwm_frequency(uint32_t frequency);
   void set_duty_cycle(double duty_cycle,uint32_t ch_num);
   void write_ctrl_reg(uint32_t command);
   void start_channel(uint8_t channel_number);
   void start_pwm();
   void stop_pwm();


private:
   uint32_t base_addr;
  uint32_t dvsr_reg;
  uint32_t duty_reg;
  uint32_t pwm_ctrl_reg;
};

#endif
