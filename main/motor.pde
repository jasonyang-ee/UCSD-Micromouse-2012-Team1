
#include "motor.h"

/*=======================================================  PID  =======================================================*/
void Motor::PID()
{
  /*------------------------------------------  stop PID  ------------------------------------------*/
  if(status.mode == modeStop)  { motorLeft(0);  motorRight(0); }
  
  else if(status.mode == modeDecelerate)  { motor.decelerate(); }
  
  /*------------------------------------------  straight PID  ------------------------------------------*/
  else if(status.mode == modeStraight)
  {
    if(status.distFrontLeft > distWallExist)
    {
      if(status.scenarioStraight == followRight)
      {
        int correction = round(1000*status.errorDiagonal + ((status.errorDiagonalDiff)/(.001)*5));
        motorRight(status.speedBase + correction);
        motorLeft(status.speedBase - correction);
      }
      if(status.scenarioStraight == followLeft)
      {
        
      }
      if(status.scenarioStraight == fishBone)
      {
        
      }
    }
    else
      motor.stop();
  }

  /*------------------------------------------  rotate PID  ------------------------------------------*/
  else if(status.mode == modeRotate)
  {
    //computing encoder error
    status.errorCountLeftLast = status.errorCountLeft;
    status.errorCountLeft = turnCount - abs(status.countLeft);
    int Kp = 2000;
    int Kd = 100;
    
    if(status.scenarioRotate == left)
    {
      if (status.errorCountLeft > 0)
      {
        status.errorCountLeftDiff = abs(status.errorCountLeft - status.errorCountLeftLast);
        int correction = round(Kp * status.errorCountLeft + Kd * status.errorCountLeftDiff);
        motor.motorRight(status.speedBase + correction);
        motor.motorLeft(status.speedBase - correction);
      }
      else
        motor.stop();
    }
  }

  /*------------------------------------------  turn PID  ------------------------------------------*/
  else if(status.mode == modeTurn)
  {
    //code
  }
}

/*=======================================================  stop  =======================================================*/
void Motor::stop()
{
  if(status.angularVelocity > 20)
  {
    status.mode = modeDecelerate;
    decelerate();                        //start decelerate
  }
  motorLeft(0);  motorRight(0);          //set motor=0
  status.mode = modeStop;                //set modd
  status.speedBase = 0;
}

void Motor::decelerate()
{
  status.speedLeft * 0.95;
  status.speedRight * 0.95;
  motorLeft(-status.speedLeft);        //set oppsite speed
  motorRight(-status.speedRight);      //set oppsite speed
  if(status.angularVelocity < 10)
    status.mode = modeStop;
}

/*=======================================================  go  =======================================================*/
void Motor::goStraight(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeStraight;              //set mode
  motorRight(speed);  motorLeft(speed);    //set speed
  status.speedBase = speed;
}

//Moves forward one cell
void Motor::goStraightOne (int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeStraight;
  status.countRight = 0;
  status.countLeft = 0;
  goStraight(speed);
  if( (status.countLeft)/2 > cellLength )   //stop after one cell
    stop();
}

/*=======================================================  rotate  =======================================================*/
void Motor::rotateLeft(int speed)
{
  status.mode = modeRotate;                //set mode
  status.compass = (status.compass+3)%4;        //set compass
  motorLeft(-speed);  motorRight(speed);        //set speed
  status.speedBase = speed;
}

void Motor::rotateRight(int speed)
{
  status.mode = modeRotate;                //set mode
  status.compass = (status.compass+1)%4;        //set compass
  motorLeft(speed);  motorRight(-speed);        //set speed
  status.speedBase = speed;
}
void Motor::rotateBack(int speed)
{
  status.mode = modeRotate;                //set mode
  status.compass = (status.compass+2)%4;        //set compass
  motorLeft(-speed);  motorRight(speed);        //set speed
  status.speedBase = speed;
}

/*=======================================================  turn  =======================================================*/
void Motor::turnLeft(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeTurn;                  //set mode
  status.compass = (status.compass+3)%4;        //set compass
}

void Motor::turnRight(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeTurn;                  //set mode
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



