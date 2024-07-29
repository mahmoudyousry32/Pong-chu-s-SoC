#ifndef _CHU_IO_RW_H_INCLUDED
#define _CHU_IO_RW_H_INCLUDED
#include <inttypes.h>

//reading macros and definitions

#define data_reg 0
#define get_slot_addr(mmio_base,slot)	((uint32_t) (mmio_base + slot*32*4))
#define io_read(base_addr,offset)	(*(volatile uint32_t *) (base_addr + 4*offset)) 
#define sw_base	get_slot_addr(BRIDGE_BASE,S3_SW)

//writing macros and definitions
#define io_write(base_addr,offset,data) (*(volatile uint32_t*)(base_addr + 4*offset) = data)
#define led_base get_slot_addr(BRIDGE_BASE,S2_LED)



#endif /* _CHU_IO_RW_H_INCLUDED */
