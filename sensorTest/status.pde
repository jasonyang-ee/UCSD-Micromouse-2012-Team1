
#include "status.h"


/*===================  initialize functions  =======================*/
void Status::initialize()
{
  sensor.runAllSensor();
}

/*===================  debug functions  =======================*/

void Status::printAll()
{
  SerialUSB.println("============= Sensor Values =============");
  SerialUSB.println("ID\tVolt:\tDistance:");
  SerialUSB.print("SL"); SerialUSB.print("\t"); SerialUSB.print(status.sideLeftVolt); SerialUSB.print("\t"); SerialUSB.println(status.sideLeftDist);
  SerialUSB.print("DL"); SerialUSB.print("\t"); SerialUSB.print(status.diagonalLeftVolt); SerialUSB.print("\t");  SerialUSB.println(status.diagonalLeftDist);
  SerialUSB.print("FL"); SerialUSB.print("\t"); SerialUSB.print(status.leftFrontVolt); SerialUSB.print("\t"); SerialUSB.println(status.leftFrontDist);
  SerialUSB.print("FR"); SerialUSB.print("\t"); SerialUSB.print(status.rightFrontVolt); SerialUSB.print("\t"); SerialUSB.println(status.rightFrontDist);
  SerialUSB.print("DR"); SerialUSB.print("\t"); SerialUSB.print(status.diagonalRightVolt); SerialUSB.print("\t"); SerialUSB.println(status.diagonalRightDist);
  SerialUSB.print("SR"); SerialUSB.print("\t"); SerialUSB.print(status.sideRightVolt); SerialUSB.print("\t"); SerialUSB.println(status.sideRightDist);
  SerialUSB.println();
  SerialUSB.println("============= Datas =============");
  SerialUSB.print("Orientation: "); SerialUSB.println(status.orientation);
  SerialUSB.print("Deviation: "); SerialUSB.println(status.deviation);
  SerialUSB.println();
}
