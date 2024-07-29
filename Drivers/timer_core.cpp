
#include "timer_core.h"


timercore::timercore(uint32_t core_base_addr) {
	base_addr = core_base_addr;
	ctrl = 0;
	io_write(base_addr,CTRL_REG,ctrl);
}
timercore::~timercore(){
}

void timercore::start_timer(){
	ctrl = ctrl | START_FIELD;
	io_write(base_addr,CTRL_REG,ctrl);
}

void timercore::clear_timer(){
	ctrl = ctrl | CLR_FIELD;
	io_write(base_addr,CTRL_REG,ctrl);
	ctrl = ctrl & ~CLR_FIELD;
	io_write(base_addr,CTRL_REG,ctrl);
}

void timercore::stop_timer(){
	ctrl = ctrl & (~START_FIELD);
	io_write(base_addr,CTRL_REG,ctrl);
}



void timercore::write_timer_lower(uint32_t data){
	io_write(base_addr,COUNTER_REG,data);

}





uint32_t timercore::read_timer_lower(){
	return io_read(base_addr,COUNTER_REG);
}

uint32_t timercore::read_ctrl_reg(){
	return io_read(base_addr,CTRL_REG);
}
