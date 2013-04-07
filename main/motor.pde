
#include "motor.h"


/*===============  position adjustment  ===================*/
void Motor::fixOrientation()
{
  
  int correction = orientationConstant * status.orientation;
  motorRight(status.speedRight + correction);
  motorLeft(status.speedLeft - correction);
  
}


/*===============  action in the same position  ===================*/
void Motor::stop()
{
  motorLeft(0);
  motorRight(0);
}

//stop and turn left
void Motor::turnLeft(int speed)
{
  int encoderTemp1, encoderTemp2;
  stop();                                         //stop before turn
  encoderTemp1 = status.wheelCountRight;          //store counts
  motorLeft(-turnSpeed); motorRight(turnSpeed);                  //speed for left and right
  while(encoderTemp2 - encoderTemp1 < 56)    
    int encoderTemp2 = status.wheelCountRight;    //turnning
  stop();                                         //stop after turn
}

//stop and turn right
void Motor::turnRight(int speed)
{
  int encoderTemp1, encoderTemp2;
  stop();                                         //stop before turn
  encoderTemp1 = status.wheelCountRight;          //store counts
  motorLeft(turnSpeed); motorRight(-turnSpeed);                 //speed for left and right
  while(encoderTemp2 - encoderTemp1 < 56)    
    int encoderTemp2 = status.wheelCountRight;    //turnning
  stop();                                         //stop after turn
}

//turn 180 degree
void Motor::turnBack()
{
  int encoderTemp1, encoderTemp2;
  stop();                                                   //stop before turn
  encoderTemp1 = status.wheelCountRight;                    //store counts
  motorLeft(-turnSpeed); motorRight(turnSpeed);   //speed for left and right
  while(encoderTemp2 - encoderTemp1 < 109)    
    int encoderTemp2 = status.wheelCountRight;              //turnning
  stop();                                                   //stop after turn
}


/*===============  action with changing position  ===================*/
void Motor::goStraight(int speed)
{
   motorRight(speed);
  motorLeft(speed);
  //fixOrientation();
}

void Motor::goBack(int speed)
{
  motorRight(-speed);
  motorLeft(-speed);
  fixOrientation();
}

//turn left while moving forward
void Motor::goLeft(int speed)
{
  motorLeft(speed);
  motorRight(speed/driveRatio);
}

//turn right while moving forward
void Motor::goRight(int speed)
{
  motorLeft(speed/driveRatio);
  motorRight(speed);
}



/*===================  private functions  =======================*/

void Motor::motorLeft(int speed)
{
  speed *= 1.025;
  status.speedLeft = speed;    //update current motor speed
  if(speed == 0)
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, 0);
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

void Motor::motorRight(int speed)
{
  status.speedRight = speed;    //update current motor speed
  if(speed == 0)
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, 0);
  }
  else if(speed > 0)
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, speed); 
  }
  else if(speed < 0)
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, HIGH);
    pwmWrite(PWMRight, speed);
  }
  
}

