#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //sensor status
  volatile int frontDist;
  volatile int sideLeftDist;
  volatile int sideRightDist;
  volatile int diagonalLeftDist;
  volatile int diagonalRightDist;
  
  //raw sensor status
  volatile int frontVolt;
  volatile int sideLeftVolt;
  volatile int sideRightVolt;
  volatile int diagonalLeftVolt;
  volatile int diagonalRightVolt;
  
  //position status
  volatile int orientation;      //set by sensor class
  volatile int deviation;        //set by sensor class

public:
  void initialize();
  void printAll();
};


#endif
