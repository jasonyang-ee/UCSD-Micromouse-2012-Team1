
#include "status.h"


/*===================  initialize functions  =======================*/
void Status::initialize()
{
  distFront = 0;
  distFrontLeft = 0;
  distFrontRight = 0;
  distSideLeft = 0;
  distSideRight = 0;
  distDiagonalLeft = 0;
  distDiagonalRight = 0;
  distSideLeftLast = 0;
  distSideRightLast = 0;
  
  voltFrontLeft = 0;
  voltFrontRight = 0;
  voltSideLeft = 0;
  voltSideRight = 0;
  voltDiagonalLeft = 0;
  voltDiagonalRight = 0;
  errorDiagonalDiffLast = 0;
  
  cellCurrent = &cell[0][0];
  compass = 0;
  x = 0;  y = 0;
  
  speedBase = 0;
  
  errorRight = 0;
  errorLeft = 0;
  
  errorDiagonal = 0;
  errorSide = 0;
  errorFront = 0;
  
  errorDiagonalLast = 0;
  errorSideLast = 0;
  errorFrontLast = 0;
  
  errorRightLast = 0;
  errorLeftLast = 0;
  
  errorRightTotal = 0;
  errorLeftTotal = 0;
  
  errorDiagonalTotal = 0;
  errorSideTotal = 0;
  errorFrontTotal = 0;
  
  errorRightDiff = 0;
  errorLeftDiff = 0;

  errorDiagonalDiff = 0;
  errorDiagonalDiffLast = 0;
  errorSideDiff = 0;
  errorFrontDiff = 0;
  
  countLeft = 0;
  countRight = 0;
  countLeftLast = 0;
  countRightLast = 0;
  
  errorCountLeft = 0;
  errorCountRight = 0;
  errorCountLeftLast = 0;
  errorCountRightLast = 0;
  
  errorCountLeftTotal = 0;
  errorCountRightTotal = 0;
  errorCountLeftDiff = 0;
  errorCountRightDiff = 0;
  
  errorCountTotal = 0;
  errorCountDiff = 0;
  
  countStampLeft;
  countStampRight;

  speedLeft = 0;
  speedRight = 0;
  speedBase = 0;
  
  angularVelocityRight = 0;
  angularVelocityLeft = 0;
  angSpeedCounter = 0;
  
  mode = modeStop;
  
  scenarioStraight = followBoth;
  scenarioRotate = 0;
  scenarioPath = 0;
  scenarioFlag = 0;
  tick = 0;
}

/*===================  prfunctions  =======================*/
void Status::printAll()
{
  SerialUSB.println("============= Sensor Values =============");
  SerialUSB.print("SL"); SerialUSB.print("\t"); SerialUSB.print(status.voltFrontLeft); SerialUSB.print("\t"); SerialUSB.println(status.distFrontLeft);
  SerialUSB.print("DL"); SerialUSB.print("\t"); SerialUSB.print(status.voltFrontRight); SerialUSB.print("\t");  SerialUSB.println(status.distFrontRight);
  SerialUSB.print("FL"); SerialUSB.print("\t"); SerialUSB.print(status.voltSideLeft); SerialUSB.print("\t"); SerialUSB.println(status.distSideLeft);
  SerialUSB.print("FR"); SerialUSB.print("\t"); SerialUSB.print(status.voltSideRight); SerialUSB.print("\t"); SerialUSB.println(status.distSideRight);
  SerialUSB.print("DR"); SerialUSB.print("\t"); SerialUSB.print(status.voltDiagonalLeft); SerialUSB.print("\t"); SerialUSB.println(status.distDiagonalLeft);
  SerialUSB.print("SR"); SerialUSB.print("\t"); SerialUSB.print(status.voltDiagonalRight); SerialUSB.print("\t"); SerialUSB.println(status.distDiagonalRight);
  SerialUSB.println();
  SerialUSB.println("================ Datas ================");
  SerialUSB.print("Orientation: "); SerialUSB.println(status.errorDiagonal);
  SerialUSB.print("Deviation: "); SerialUSB.println(status.errorSide);
  SerialUSB.print("Balance: "); SerialUSB.println(status.errorFront);
  SerialUSB.println();
  SerialUSB.println("=============== Encoder ===============");
  SerialUSB.print("Encoder Left: "); SerialUSB.println(status.countLeft);
  SerialUSB.print("Encoder Right: "); SerialUSB.println(status.countRight);
  SerialUSB.println();
}

void Status::printSensor()
{
  SerialUSB.println("============= Sensor Values =============");
  SerialUSB.print("SL"); SerialUSB.print("\t"); SerialUSB.print(status.distFrontLeft); SerialUSB.print("\t");
  SerialUSB.print("DL"); SerialUSB.print("\t"); SerialUSB.print(status.distFrontRight); SerialUSB.print("\t");
  SerialUSB.print("FL"); SerialUSB.print("\t"); SerialUSB.print(status.distSideLeft); SerialUSB.print("\t");
  SerialUSB.print("FR"); SerialUSB.print("\t"); SerialUSB.print(status.distSideRight); SerialUSB.print("\t");
  SerialUSB.print("DR"); SerialUSB.print("\t"); SerialUSB.print(status.distDiagonalLeft); SerialUSB.print("\t");
  SerialUSB.print("SR"); SerialUSB.print("\t"); SerialUSB.println(status.distDiagonalRight); 
}

