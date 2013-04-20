#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //encoder status
  volatile int wheelCountLeft;      //set by timmer2 ch1
  volatile int wheelCountRight;     //set by timmer2 ch1
  
public:
  void initialize();
  void printAll();
};


#endif
