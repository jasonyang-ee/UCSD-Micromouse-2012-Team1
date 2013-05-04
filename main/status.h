#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //sensor status
  volatile double distFront;
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
  
  //position
  Cell *currentCell;    //cell pointer
  int compass;
  int x; //Current X position of Mouse
  int y; //Current Y position of Mouse
  
  int speedBase;
  
  //error
  volatile double errorRight;
  volatile double errorDiagonal;  //error for PID
  volatile double errorSide;
  volatile double errorFront;
  volatile double errorCountLeft;
  
  //preveous error
  double errorDiagonalLast;
  double errorSideLast;
  double errorFrontLast;
  double errorCountLeftLast;
  
  //PID error
  double errorDiagonalTotal;
  double errorSideTotal;
  double errorFrontTotal;
  double errorCountLeftTotal;
  
  double errorDiagonalDiff;
  double errorSideDiff;
  double errorFrontDiff;
  double errorCountLeftDiff;
  
  //encoder status
  volatile int countLeft;  //wheel encoder count
  volatile int countRight;
  volatile int countLeftLast;  //wheel encoder count last one
  volatile int countRightLast;

  //motor status
  int speedLeft;
  int speedRight;
  int angularVelocity;
  
  //control PID drive type
  int mode;
  
  //control drive detail
  int scenarioStraight;
  int scenarioRotate;
  
public:
  void initialize();
  void printAll();
  void printSensor();
};


#endif
