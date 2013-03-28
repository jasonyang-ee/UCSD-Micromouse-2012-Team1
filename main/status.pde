
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
//print all status variable for debug 
}
