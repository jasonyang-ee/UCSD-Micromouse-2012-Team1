
#include "status.h"


/*===================  initialize functions  =======================*/
void Status::initialize()
{
  currentCell = &cell[0][0];
  sensor.runAllSensor();
  compass = 0;
  wheelCountLeft = 0;
  wheelCountRight = 0; 
}

/*===================  debug functions  =======================*/

void Status::printAll()
{
  SerialUSB.println("============= Sensor Values =============");
  SerialUSB.println("Volt:\tDistance:");
  SerialUSB.print(status.diagonalLeftVolt); SerialUSB.print("\t");  SerialUSB.println(status.diagonalLeftDist);
  SerialUSB.print(status.sideLeftVolt); SerialUSB.print("\t"); SerialUSB.println(status.sideLeftDist);
  SerialUSB.print(status.leftFrontVolt); SerialUSB.print("\t"); SerialUSB.println(status.leftFrontDist);
  SerialUSB.print(status.rightFrontVolt); SerialUSB.print("\t"); SerialUSB.println(status.rightFrontDist);
  SerialUSB.print(status.sideRightVolt); SerialUSB.print("\t"); SerialUSB.println(status.sideRightDist);
  SerialUSB.print(status.diagonalRightVolt); SerialUSB.print("\t"); SerialUSB.println(status.diagonalRightDist);
  SerialUSB.println();
  SerialUSB.println("============= Datas =============");
  SerialUSB.print("Orientation: "); SerialUSB.println(status.orientation);
  SerialUSB.print("Deviation: "); SerialUSB.println(status.deviation);
  SerialUSB.println();
}
