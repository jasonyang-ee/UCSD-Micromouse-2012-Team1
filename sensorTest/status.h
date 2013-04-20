#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //sensor status
  volatile double leftFrontDist;
  volatile double rightFrontDist;
  volatile double sideLeftDist;
  volatile double sideRightDist;
  volatile double diagonalLeftDist;
  volatile double diagonalRightDist;
  
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
