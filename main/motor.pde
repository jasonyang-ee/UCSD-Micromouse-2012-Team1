
#include "motor.h"

/*=======================================================  PID  =======================================================*/
void Motor::PID()
{
  /*------------------------------------------  stop PID  ------------------------------------------*/
  if(status.modeDrive == modeStop)  { motorLeft(0);  motorRight(0); }
  
  /*------------------------------------------  straight PID  ------------------------------------------*/
  else if(status.modeDrive == modeStraight)
  {
    if(status.distFrontLeft > 13)
    {
      if(status.scenarioStraight == followRight)
      {
        int correction = round(1000*status.errorDiagonal + ((status.errorDiagonalLast)/(.001)*5));
        motor.motorRight(speedMap - correction);
        motor.motorLeft(speedMap + correction);
      }
    }
    else
      motor.stop();
  }

  /*------------------------------------------  rotate PID  ------------------------------------------*/
  else if(status.modeDrive == modeRotate)
  {
    //code
  }

  /*------------------------------------------  turn PID  ------------------------------------------*/
  else if(status.modeDrive == modeTurn)
  {
    //code
  }
}

/*=======================================================  stop  =======================================================*/
void Motor::stop()
{
  status.modeDrive = modeStop;                    //set mode
  motorLeft(0);  motorRight(0);                   //set motor=0
  if(status.modeDrive != modeStop) decelerate();  //start decelerate
  motorLeft(0);  motorRight(0);                   //set motor=0
}

void Motor::decelerate()
{
  status.modeDrive = modeBreaking;
  motorLeft(-status.speedLeft);        //set oppsite speed
  motorRight(-status.speedRight);      //set oppsite speed
  int duration = (abs(status.speedLeft)+abs(status.speedRight))/30;   //set duration for breaking
  for(time=0; time<duration;) continue;                               //decelerate for duration (ms)
}

/*=======================================================  go  =======================================================*/
void Motor::goStraight(int speed)
{
  status.modeDrive = modeStraight;              //set mode
  motorRight(speed);  motorLeft(speed);         //set speed
}

//Moves forward one cell
void Motor::goStraightOne (int speed)
{
  status.modeDrive = modeStraight;
  status.countRight = 0;
  status.countLeft = 0;
  goStraight(speed);
  if( (status.countLeft)/2 > cellLength )   //stop after one cell
    stop();
}

/*=======================================================  rotate  =======================================================*/
void Motor::rotateLeft(int speed)
{
  status.modeDrive = modeRotate;                //set mode
  status.compass = (status.compass+3)%4;        //set compass
  motorLeft(-speed);  motorRight(speed);        //set speed
}

void Motor::rotateRight(int speed)
{
  status.modeDrive = modeRotate;                //set mode
  status.compass = (status.compass+1)%4;        //set compass
  motorLeft(speed);  motorRight(-speed);        //set speed
}
void Motor::rotateBack(int speed)
{
  status.modeDrive = modeRotate;                //set mode
  status.compass = (status.compass+2)%4;        //set compass
  motorLeft(-speed);  motorRight(speed);        //set speed
}

/*=======================================================  turn  =======================================================*/
void Motor::turnLeft(int speed)
{
  status.modeDrive = modeTurn;                  //set mode
  status.compass = (status.compass+3)%4;        //set compass
}

void Motor::turnRight(int speed)
{
  status.modeDrive = modeTurn;                  //set mode
  status.compass = (status.compass+1)%4;        //set compass 
}

/*=======================================================  motor  =======================================================*/
void Motor::motorLeft(int speed)
{
  status.speedLeft = speed;         //save current speed
  if(speed == 0)                    //stop
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, 0);           //set speed
  }
  else if(speed > 0)                //forward
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, speed);
  }
  else                              //backward
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    pwmWrite(PWMLeft, abs(speed));  //set speed
  }
}

void Motor::motorRight(int speed)
{
  status.speedRight = speed;        //save current speed
  if(speed == 0)                    //stop
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, 0);          //set speed
  }
  else if(speed > 0)                //forward
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, speed);      //set speed
  }
  else                              //backward
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, HIGH);
    pwmWrite(PWMRight, abs(speed)); //set speed
  }
}



