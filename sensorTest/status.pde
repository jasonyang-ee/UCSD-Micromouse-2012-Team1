
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
  SerialUSB.println("Volt:\tDistance:");
  SerialUSB.print(diagonalLeftVolt); SerialUSB.print("\t");  SerialUSB.println(diagonalLeftDist);
  SerialUSB.print(sideLeftVolt); SerialUSB.print("\t"); SerialUSB.println(sideLeftDist);
  SerialUSB.print(frontVolt); SerialUSB.print("\t"); SerialUSB.println(frontDist);
  SerialUSB.print(sideRightVolt); SerialUSB.print("\t"); SerialUSB.println(sideRightDist);
  SerialUSB.print(diagonalRightVolt); SerialUSB.print("\t"); SerialUSB.println(diagonalRightDist);
  SerialUSB.println();
  SerialUSB.println("============= Datas =============");
  SerialUSB.print("Orientation: "); SerialUSB.println(orientation);
  SerialUSB.print("Deviation: "); SerialUSB.println(deviation);
  SerialUSB.println();
}
