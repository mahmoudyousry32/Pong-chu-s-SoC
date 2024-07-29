

#ifndef _GPIO_H_INCLUDED
#define _GPIO_H_INCLUDED

#include "chu_init.h"


 
class GpiCore {
public:
   
   
   enum {
      DATA_REG = 0 /**< input data register */
   };
  
   GpiCore(uint32_t core_base_addr);
   ~GpiCore();                  // not used

   
   uint32_t read();

   


private:
   uint32_t base_addr;
};


class GpoCore {
public:
   
   enum {
      DATA_REG = 0 /**< output data register */
   };
   
   GpoCore(uint32_t core_base_addr);
   ~GpoCore();                  // not used

  
   void write(uint32_t data);


private:
   uint32_t base_addr;
   uint32_t wr_data;      // same as GPO core data reg
};



#endif  // _GPIO_H_INCLUDED
