
#include "status.h"


/*===================  initialize functions  =======================*/
void Status::initialize()
{
  currentCell = &cell[0][0];
  sensor.runAllSensor();
  compass = 0;
  countLeft = 0;
  countRight = 0;
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
