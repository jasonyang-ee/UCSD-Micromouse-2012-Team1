
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
  distDiagonalLeft = 20;
  distDiagonalRight = 20;
  
  voltFrontLeft = 0;
  voltFrontRight = 0;
  voltSideLeft = 0;
  voltSideRight = 0;
  voltDiagonalLeft = 0;
  voltDiagonalRight = 0;
  errorDiagonalDiffLast = 0;
  
  cellCurrent = &cell[0][0];
  currentCell = &cell[0][0];
  compass = 0;
  x = 0;  y = 0;
  
  speedBase = 0;
  
  errorRight = 0;
  errorDiagonal = 0;
  errorSide = 0;
  errorFront = 0;
  errorCountLeft = 0;
  
  errorDiagonalLast = 0;
  errorSideLast = 0;
  errorFrontLast = 0;
  errorCountLeftLast = 0;
  
  errorDiagonalTotal = 0;
  errorSideTotal = 0;
  errorFrontTotal = 0;
  errorCountLeftTotal = 0;
  
  errorDiagonalDiff = 0;
  errorSideDiff = 0;
  errorFrontDiff = 0;
  errorCountLeftDiff = 0;
  
  countLeft = 0;
  countRight = 0;
  countLeftLast = 0;
  countRightLast = 0;

  speedLeft = 0;  speedRight = 0;
  angularVelocity = 0;
  
  mode = modeStop;
  
  scenarioStraight = followBoth;
  scenarioPath = 0;
  scenarioBack = false;
}

/*===================  print functions  =======================*/
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
}
