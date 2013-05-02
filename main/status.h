#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //sensor status
  volatile double distFrontLeft;
  volatile double distFrontRight;
  volatile double distSideLeft;
  volatile double distSideRight;
  volatile double distDiagonalLeft;
  volatile double distDiagonalRight;
  
  //raw sensor status
  volatile int voltFrontLeft;
  volatile int voltFrontRight;
  volatile int voltSideLeft;
  volatile int voltSideRight;
  volatile int voltDiagonalLeft;
  volatile int voltDiagonalRight;
  
  //position status
  Cell *currentCell;    //cell pointer
  volatile double errorDiagonal;  //error for PID
  volatile double errorSide;
  volatile double errorFront;
  int compass;
  int x; //Current X position of Mouse
  int y; //Current Y position of Mouse
  
  //old position
  double errorDiagonalLast;
  double errorSideLast;
  double errorFrontLast;
  
  //encoder status
  volatile int countLeft;  //wheel encoder count
  volatile int countRight;
  volatile int countLeftLast;  //wheel encoder count last one
  volatile int countRightLast;

  //motor status
  int speedLeft;
  int speedRight;
  
  //control PID drive type
  int modeDrive;
  
  //control drive detail
  int scenarioStraight;
  
public:
  void initialize();
  void printAll();
  void printSensor();
};


#endif
