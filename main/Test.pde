#include "global.h"
#include "cell.h"
#include "maze.h"
#include "motor.h"
#include "sensor.h"
#include "status.h"
/*
void test()
{
  float error = rightError();
  int correction = round(orientationConstant * error);
  int speed = 5000;
 // motor.motorRight(speed + correction);
  //motor.motorLeft(speed - correction);
}*/

float rightError()
{/*
  int setpoint1 = 11;
  int setpoint2 = 3.59;
  
  float error = (status.diagonalRightDist - setpoint1);
  
  return (error +=( error < 0 ? (setpoint2 - status.sideRightDist):(status.sideRightDist - setpoint2) ));
   */ 
}
