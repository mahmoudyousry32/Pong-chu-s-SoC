#ifndef _DDFS_CORE_H_INCLUDED
#define _DDFS_CORE_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"  // to use SYS_CLK_FREQ

class DdfsCore {

	enum {
		FCCW_REG = 0,
		FOCW_REG = 1,
		PHA_REG  = 2,
		ENV_REG  = 3

	};

	enum {
		FCW_FIELD 	= 0x3fffffff,
		PHA_FIELD	= 0x3fffffff,
		ENV_FIELD   = 0x0000ffff
	};

	enum {PHA_WIDTH = 30};

public :
 DdfsCore(uint32_t base_addr);
~DdfsCore();

	void set_carrier_freq(uint32_t freq);
	void set_offset_freq (uint32_t freq);
	void set_phase(uint32_t phase);
	void set_env(float env);
	void init();

private :
	uint32_t base_addr;

};

#endif
