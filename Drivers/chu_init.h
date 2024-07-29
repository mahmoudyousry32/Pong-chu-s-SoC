//some bit manipulation stuff
#include "../Drivers/chu_io_map.h"
#include "../Drivers/chu_io_rw.h"
#include "timer_core.h"
#include "uart_core.h"

#define bit_set(data,n) (data |= (1UL << n))
#define bit_clear(data,n) (data &= (1UL << n)) 
#define bit_toggle(data,n) (data ^= (1UL << n))
#define bit_read(data,n) ((data >> n) & 0x01)
#define bit_write(data,n,bitvalue) (bitvalue ? bit_set(data,n) : bit_clear(data,n))
