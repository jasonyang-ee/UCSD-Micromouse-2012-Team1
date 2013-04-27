
#include "status.h"


/*===================  initialize functions  =======================*/
void Status::initialize()
{
  currentCell = &cell[0][0];
  sensor.runAllSensor();
  compass = 0;
  wheelCountLeft = 0;
  wheelCountRight = 0;
  mode = mapping;
}

/*===================  debug functions  =======================*/

void Status::printAll()
{
  SerialUSB.println("============= Sensor Values =============");
  SerialUSB.println("ID\tVolt:\tDistance:");
  SerialUSB.print("SL"); SerialUSB.print("\t"); SerialUSB.print(status.sideLeftVolt); SerialUSB.print("\t"); SerialUSB.println(status.sideLeftDist);
  SerialUSB.print("DL"); SerialUSB.print("\t"); SerialUSB.print(status.diagonalLeftVolt); SerialUSB.print("\t");  SerialUSB.println(status.diagonalLeftDist);
  SerialUSB.print("FL"); SerialUSB.print("\t"); SerialUSB.print(status.frontLeftVolt); SerialUSB.print("\t"); SerialUSB.println(status.frontLeftDist);
  SerialUSB.print("FR"); SerialUSB.print("\t"); SerialUSB.print(status.frontRightVolt); SerialUSB.print("\t"); SerialUSB.println(status.frontRightDist);
  SerialUSB.print("DR"); SerialUSB.print("\t"); SerialUSB.print(status.diagonalRightVolt); SerialUSB.print("\t"); SerialUSB.println(status.diagonalRightDist);
  SerialUSB.print("SR"); SerialUSB.print("\t"); SerialUSB.print(status.sideRightVolt); SerialUSB.print("\t"); SerialUSB.println(status.sideRightDist);
  SerialUSB.println();
  SerialUSB.println("================ Datas ================");
  SerialUSB.print("Orientation: "); SerialUSB.println(status.orientation);
  SerialUSB.print("Deviation: "); SerialUSB.println(status.deviation);
  SerialUSB.print("Balance: "); SerialUSB.println(status.balance);
  SerialUSB.println();
  SerialUSB.println("=============== Encoder ===============");
  SerialUSB.print("Encoder Left: "); SerialUSB.println(status.wheelCountLeft);
  SerialUSB.print("Encoder Right: "); SerialUSB.println(status.wheelCountRight);
  SerialUSB.println();
}
