#ifndef _TIMER_H_INCLUDED
#define _TIMER_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"
#include "chu_init.h"

class timercore{
public :
	/**
	    * register map
	    *
	    */
	   enum {
	      COUNTER_REG = 0, /**< lower 32 bits of counter */

	      CTRL_REG = 1           /**< control register */
	   };

	   /**
	   * field masks
	   *
	   */
	   enum {
		   START_FIELD = 0x00000001,
		   CLR_FIELD = 0x00000002,

	   };
	   timercore(uint32_t core_base_addr);
	   ~timercore();

	   void start_timer();
	   void clear_timer();
	   void stop_timer();

	   void write_timer_lower(uint32_t data);

	   uint32_t read_timer_lower();
	   uint32_t read_ctrl_reg();

private:
	   uint32_t base_addr;
	   uint32_t ctrl;
};
#endif
