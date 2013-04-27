#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //sensor status
  volatile double frontLeftDist;
  volatile double frontRightDist;
  volatile double sideLeftDist;
  volatile double sideRightDist;
  volatile double diagonalLeftDist;
  volatile double diagonalRightDist;
  
  //raw sensor status
  volatile int frontLeftVolt;
  volatile int frontRightVolt;
  volatile int sideLeftVolt;
  volatile int sideRightVolt;
  volatile int diagonalLeftVolt;
  volatile int diagonalRightVolt;
  
  //running mode
  int mode;
  
  //position status
  Cell *currentCell;
  volatile double orientation;      //set by sensor class
  volatile double deviation;        //set by sensor class
  volatile double balance;
  int compass;
  
  //old position
  double oldOrientation;
  double oldDeviation;
  double oldBalance;
  
  //encoder status
  volatile int wheelCountLeft ;      //set by timmer2 ch1
  volatile int wheelCountRight;     //set by timmer2 ch1
  
  //motor status
  int speedLeft;
  int speedRight;
  
public:
  void initialize();
  void printAll();
};


#endif
