#include "Ddfscore.h"


DdfsCore::DdfsCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
   init();
}
;
DdfsCore::~DdfsCore() {
}


void DdfsCore::init() {



   set_carrier_freq(262);
   set_offset_freq(0);
   set_phase(0);
   set_env(1.0);
}

void DdfsCore::set_carrier_freq(uint32_t freq) {
   uint32_t fcw, p2n;
   float tmp;

   p2n = 1 << PHA_WIDTH;
   tmp = ((float) p2n) / float(SYS_CLK_FREQ * 1000000);
   fcw = uint32_t(freq * tmp);
   io_write(base_addr, FCCW_REG, fcw);
}

void DdfsCore::set_offset_freq(uint32_t freq) {
   uint32_t fow, p2n;
   float tmp;

   p2n = 1 << PHA_WIDTH;  //2^PHA_WIDTH
   tmp = ((float) p2n) / float(SYS_CLK_FREQ * 1000000);
   fow = uint32_t(freq * tmp);
   io_write(base_addr, FOCW_REG, fow);
}

void DdfsCore::set_phase(uint32_t phase) {
   uint32_t pha;

   pha = (SYS_CLK_FREQ * 1000000) * phase / 360;
   io_write(base_addr, PHA_REG, pha);
}

void DdfsCore::set_env(float env) {
   // convert floating point to fixed-point Q2.14 format
   int32_t q214;
   float max_amp;

   max_amp = (float) (0x4000);   // 2^15
   q214 = (int32_t) (env * max_amp);
   io_write(base_addr, ENV_REG, q214 & 0x0000ffff);
}
