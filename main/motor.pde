
#include "motor.h"


//self position adjustment
void Motor::fixOrientation()
{
/*
  int correction = orientationConstant * status.orientation;
  motorRight(status.speedRight + correction);
  motorLeft(status.speedLeft - correction);
*/
}


/*===============  action in the same position   ===================*/
void Motor::stop()
{
  motorLeft(0);
  motorRight(0);
}

//stop and turn left
void Motor::turnLeft(int speed)
{
  motorLeft(speed);
  motorRight(speed*(5/16));    //turnning ratial between left and right
}

//stop and turn right
void Motor::turnRight(int speed)
{
  stop();
  motorLeft(speed*(5/16));     //turnning ratial between left and right
  motorRight(speed);
}

//turn 180 degree
void Motor::turnBack()
{
  int currentLeftCount = status.leftWheelCount;
  int currentRightCount = status.rightWheelCount;
  
  motorLeft(-fullSpeed/5000);
  motorRight(fullSpeed/5000);
}


/*===============  action with changing position   ===================*/
void Motor::goStraight(int speed)
{
  motorRight(speed);
  motorLeft(speed);
}

//turn left while moving forward
void Motor::goLeft(int speed)
{
  motorLeft(speed);
  motorRight(speed/turnRatio);
}

//turn right while moving forward
void Motor::goRight(int speed)
{
  motorLeft(speed/turnRatio);
  motorRight(speed);
}



/*===================  private functions  =======================*/

void Motor::leftMotor(int speed)
{
  status.leftSpeed = speed;    //update current motor speed
  if(speed == 0)
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
  }
  else if(speed > 0)
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    pwmWrite(PWMLeft, speed);
  }
  else if(speed < 0)
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, speed);
  }
  
}

void Motor::rightMotor(int speed)
{
  status.rightSpeed = speed;    //update current motor speed
  if(speed == 0)
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
  }
  else if(speed > 0)
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, speed); 
  }
  else if(speed < 0)
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    pwmWrite(PWMLeft, speed);
  }
  
}

