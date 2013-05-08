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
  volatile double distSideLeftLast;
  volatile double distSideRightLast;
  
  //raw sensor status
  volatile int voltFrontLeft;
  volatile int voltFrontRight;
  volatile int voltSideLeft;
  volatile int voltSideRight;
  volatile int voltDiagonalLeft;
  volatile int voltDiagonalRight;
  
  //position
  Cell *cellCurrent;    //cell pointer
  Cell *currentCell;    //cell pointer
  int compass;
  int x; //Current X position of Mouse
  int y; //Current Y position of Mouse
  
  //error
  volatile double errorRight;
  volatile double errorDiagonal;  //error for PID
  volatile double errorSide;
  volatile double errorFront;
  volatile double errorCountLeft;
  volatile double errorCountRight;
  
  //preveous error
  double errorDiagonalLast;
  double errorSideLast;
  double errorFrontLast;
  
  //PID error
  double errorDiagonalTotal;
  double errorSideTotal;
  double errorFrontTotal;
  
  double errorDiagonalDiff;
  double errorDiagonalDiffLast;
  double errorSideDiff;
  double errorFrontDiff;
  double errorCountDiff;
  
  //encoder status
  volatile int countLeft;  //wheel encoder count
  volatile int countRight;
  volatile int countLeftLast;  //wheel encoder count last one
  volatile int countRightLast;
  
  int countStampLeft;
  int countStampRight;

  //motor status
  int speedLeft;
  int speedRight;
  int speedBase;
  
  //angular velocity
  int angularSpeed;
  int angSpeedCounter;
  
  //control PID drive type
  int mode;
  
  //control drive detail
  int scenarioStraight;
  int scenarioRotate;
  int scenarioPath;
  int scenarioFlag;
  bool scenarioBack;
  
public:
  void initialize();
  void printAll();
  void printSensor();
};


#endif
