#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  /*------------------------------------------  distance  ------------------------------------------*/
  //set in runAllSensor()
  volatile double distFront;
  volatile double distFrontLeft;
  volatile double distFrontRight;
  volatile double distSideLeft;
  volatile double distSideRight;
  volatile double distDiagonalLeft;
  volatile double distDiagonalRight;
  volatile double distSideLeftLast;
  volatile double distSideRightLast;
  
  /*------------------------------------------  voltage  ------------------------------------------*/
  //set in runAllSensor()
  volatile int voltFrontLeft;
  volatile int voltFrontRight;
  volatile int voltSideLeft;
  volatile int voltSideRight;
  volatile int voltDiagonalLeft;
  volatile int voltDiagonalRight;
  
  /*------------------------------------------  position  ------------------------------------------*/
  //set in mapping()
  Cell *cellCurrent;    //cell pointer
  int compass;
  int x; //Current X position of Mouse
  int y; //Current Y position of Mouse
  
  /*------------------------------------------  error  ------------------------------------------*/
  //set in runAllSensor()
  volatile double errorRight;
  volatile double errorLeft;
  
  volatile double errorDiagonal;
  volatile double errorSide;
  volatile double errorFront;
  
  /*------------------------------------------  error last  ------------------------------------------*/
  double errorDiagonalLast;
  double errorSideLast;
  double errorFrontLast;
  
  double errorRightLast;
  double errorLeftLast;
  
  /*------------------------------------------  error total  ------------------------------------------*/
  double errorRightTotal;
  double errorLeftTotal;
  
  double errorDiagonalTotal;
  double errorSideTotal;
  double errorFrontTotal;
  
  /*------------------------------------------  error diff  ------------------------------------------*/
  double errorRightDiff;
  double errorLeftDiff;

  double errorDiagonalDiff;
  double errorDiagonalDiffLast;
  double errorSideDiff;
  double errorFrontDiff;
  
  /*------------------------------------------  encoder  ------------------------------------------*/
  //for every PID
  volatile int countLeft;
  volatile int countRight;
  volatile int countLeftLast;
  volatile int countRightLast;
  
  //for rotate
  volatile int errorCountLeft;
  volatile int errorCountRight;
  volatile int errorCountLeftLast;
  volatile int errorCountRightLast;
  
  /*------------------------------------------  encoder total diff  ------------------------------------------*/
  //for rotate
  int errorCountLeftTotal;
  int errorCountRightTotal;
  int errorCountLeftDiff;
  int errorCountRightDiff;
  
  //for fish bone
  int errorCountTotal;
  int errorCountDiff;
  
  //for fish bone
  int countStampLeft;
  int countStampRight;

  /*------------------------------------------  speed  ------------------------------------------*/
  int speedLeft;
  int speedRight;
  int speedBase;    //abs value of speed base
  
  //angular velocity
  int angularVelocityRight;
  int angularVelocityLeft;
  int angSpeedCounter;
  
  /*------------------------------------------  mode  ------------------------------------------*/
  int mode;
  
  //control drive detail
  int scenarioStraight;
  int scenarioRotate;
  int scenarioPath;
  int scenarioFlag;
  int tick;
  
  /*------------------------------------------  function  ------------------------------------------*/
public:
  void initialize();
  void printAll();
  void printSensor();
};


#endif
