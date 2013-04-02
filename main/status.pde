
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
  SerialUSB.print(diagonalLeftVolt, diagonalLeftVolt); SerialUSB.print("\t");  SerialUSB.println(diagonalLeftDist, diagonalLeftDist);
  SerialUSB.print(sideLeftVolt, sideLeftVolt); SerialUSB.print("\t"); SerialUSB.println(sideLeftDist, sideLeftDist);
  SerialUSB.print(frontVolt, frontVolt); SerialUSB.print("\t"); SerialUSB.println(frontDist, frontDist);
  SerialUSB.print(sideRightVolt, sideRightVolt); SerialUSB.print("\t"); SerialUSB.println(sideRightDist, sideRightDist);
  SerialUSB.print(diagonalRightVolt, diagonalRightVolt); SerialUSB.print("\t"); SerialUSB.println(diagonalRightDist, diagonalRightDist);
  SerialUSB.println();
  SerialUSB.println("============= Datas =============");
  SerialUSB.print("Orientation: "); SerialUSB.println(orientation, orientation);
  SerialUSB.print("Deviation: "); SerialUSB.println(deviation, deviation);
  SerialUSB.println();
}
