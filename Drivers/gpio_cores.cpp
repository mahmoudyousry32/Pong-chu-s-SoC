

#include "gpio_cores.h"

/**********************************************************************
 * GpiCore
 **********************************************************************/
GpiCore::GpiCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
}
GpiCore::~GpiCore() {
}

uint32_t GpiCore::read() {
   return (io_read(base_addr, DATA_REG));
}



/**********************************************************************
 * GpoCore
 **********************************************************************/
GpoCore::GpoCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
   wr_data = 0;
}

GpoCore::~GpoCore() {
}

void GpoCore::write(uint32_t data) {
   wr_data = data;
   io_write(base_addr, DATA_REG, wr_data);
}



