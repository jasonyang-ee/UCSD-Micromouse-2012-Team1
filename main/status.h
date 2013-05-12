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
  volatile Cell *cellCurrent;    //cell pointer
  int compass;
  
  //error
  volatile double errorRight;
  volatile double errorLeft;
  volatile double errorDiagonal;  //error for PID
  volatile double errorSide;
  volatile double errorFront;
  volatile double errorCountLeft;
  volatile double errorCountRight;
  
  //preveous error
  double errorDiagonalLast;
  double errorSideLast;
  double errorFrontLast;
  double errorRightLast;
  double errorLeftLast;
  
  //PID error
  double errorDiagonalTotal;
  double errorSideTotal;
  double errorFrontTotal;
  
  double errorDiagonalDiff;
  double errorDiagonalDiffLast;
  double errorSideDiff;
  double errorFrontDiff;
  double errorRightDiff;
  double errorLeftDiff;
  
  //encoder status
  volatile int countLeft;  //wheel encoder count
  volatile int countRight;
  volatile int countLeftLast;  //wheel encoder count last one
  volatile int countRightLast;
  volatile int errorCountLeftLast;
  volatile int errorCountRightLast;
  int errorCountLeftTotal;
  int errorCountRightTotal;
  int errorCountLeftDiff;
  int errorCountRightDiff;
  
  int errorCount;
  int errorCountLast;
  int errorCountDiff;
  int errorCountTotal;
  
  int countStampLeft;
  int countStampRight;

  int countLeftTemp;
  int countRightTemp;

  //motor status
  int speedLeft;
  int speedRight;
  int speedBase;
  
  //angular velocity
  int angularVelocityRight;
  int angularVelocityLeft;
  int angSpeedCounter;
  
  //control PID drive type
  int mode;
  
  //control drive detail
  int scenarioStraight;
  int scenarioRotate;
  int scenarioPath;
  int scenarioFlag;
  int tick;
  
/*--- last 24 hr code  ---*/
//explained in status.pde
  int offset;
  int offsetLeft;
  int offsetRight;
  int offsetLast;
  int offsetDiff;
  int offsetTotal;
  
  int timeBetweenStop;
/*--- last 24 hr code  ---*/

  int offsetFishBone;
  int offsetFishBoneLast;
  int offsetFishBoneDiff;

  bool edgeLeft;
  bool edgeRight;

  double errorRightTotal;
  double errorLeftTotal;

public:
  void initialize();
  void printAll();
  void printSensor();
};


#endif
