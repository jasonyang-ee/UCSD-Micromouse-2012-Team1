
#include "status.h"


/*===================  initialize functions  =======================*/
void Status::initialize()
{
  currentCell = cell[0][0];
  sensor.runAllSensor();
  compass = 0;
  leftWheelCount = 0;
  rightWheelCount = 0; 
}

/*===================  debug functions  =======================*/

void Status::printAll()
{
//print all status variable for debug 
}
