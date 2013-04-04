#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //sensor status
  volatile int leftFrontDist;
  volatile int rightFrontDist;
  volatile int sideLeftDist;
  volatile int sideRightDist;
  volatile int diagonalLeftDist;
  volatile int diagonalRightDist;
  
  //raw sensor status
  volatile int leftFrontVolt;
  volatile int rightFrontVolt;
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
