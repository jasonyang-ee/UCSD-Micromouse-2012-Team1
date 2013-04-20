
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
  SerialUSB.print("Left wheel count: ");
  SerialUSB.print(wheelCountLeft, wheelCountLeft);
  SerialUSB.print("Right wheel count: ");
  SerialUSB.print(wheelCountRight, wheelCountRight);
  SerialUSB.println();
}
