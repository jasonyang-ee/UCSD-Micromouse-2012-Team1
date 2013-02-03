
#include "motor.h"

int Motor::fixOrientation()
{
  return 0;    //return ?
}

void Motor::stop()
{
  motorLeft(0);
  motorRight(0);
}

//for passing the first mouse test assignment
void Motor::driveStright()
{
  //if(front wall==0)
}

void Motor::turnLeft()
{
}

void Motor::turnRight()
{
}

//if deadend then go turn back
void Motor::turnBack()
{
}

void Motor::driveLeftTurn()
{
}

void Motor::driveRightTurn()
{
}



/*===================  private functions  =======================*/

void Motor::motorLeft(int speed)
{
  if(speed>=0)
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, speed);
  }
  else
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    pwmWrite(PWMLeft, speed);
  } 
}

void Motor::motorRight(int speed)
{
  if(speed>=0)
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, speed);
  }
  else
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, HIGH);
    pwmWrite(PWMRight, speed);
  } 
}

