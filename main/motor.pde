
#include "motor.h"

/*=======================================================  PID  =======================================================*/
void Motor::PID()
{
  /*------------------------------------------  stop PID  ------------------------------------------*/
  if(status.mode == modeStop)  { stop(); }
  
  else if(status.mode == modeDecelerate)  { decelerate(); }
  
  /*------------------------------------------  straight PID  ------------------------------------------*/
  else if(status.mode == modeStraight)
  {
    if(status.distFront > distWallExist)
    {
      if(status.scenarioStraight == followBoth)
      {
            int correction = round(800 * status.errorDiagonal + 130*(status.errorDiagonalDiff)/.001 + 20*status.errorDiagonalTotal);
          /*suitable for 20,000: int correction = round(1500 * status.errorDiagonal + 200*(status.errorDiagonalDiff)/.001 + 35*status.errorDiagonalTotal);*/
            motor.motorRight(status.speedBase + correction);
            motor.motorLeft(status.speedBase - correction);            
            status.errorDiagonalDiffLast = status.errorDiagonalDiff;

      }
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
<<<<<<< HEAD
        status.errorCountDiff = status.errorCountLeft - status.errorCountRight;
=======
>>>>>>> rotate
        
        if(status.distSideLeft > distWallExist || status.distSideRight > distWallExist)
        {
          int correction = round(400*(status.errorCountDiff)/.001);
          motorRight(status.speedBase + correction);
          motorLeft(status.speedBase - correction);
        }
        else
        {
          if(status.distSideLeft - status.distSideLeftLast > 4)  status.countStampLeft = status.countLeft;
          if(status.distSideRight - status.distSideRightLast > 4)  status.countStampRight = status.countRight;
          if(status.countStampLeft!=0 && status.countStampRight!=0)
          {
            int correction = round(400*abs(status.countStampLeft-status.countStampRight)/.001);
            motorRight(status.speedBase + correction);
            motorLeft(status.speedBase - correction);
          }
        }
        status.countLeftLast = status.countLeft;
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
    status.errorCountLeft = rotateCount - abs(status.countLeft);
    status.errorCountRight = rotateCount - abs(status.countRight);
    int Kp = 2000;
    int Kd = 900;
    int Ki = 5;
    
    if(status.scenarioRotate == left)
    {
      if (status.errorCountLeft != 0||status.tick < 5) //&& status.errorCountRight != 0)
      {
        status.errorCountLeftTotal += status.errorCountLeft;
        //status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
        status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
        int correction = round(Kp * status.errorCountLeft + Kd * status.errorCountLeftDiff);// + Ki*status.errorCountLeftTotal);
        //int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);
        motor.motorRight(correction);
        motor.motorLeft(- correction);
        
        //as long as 
        if (status.errorCountLeft == status.errorCountLeftLast )
          status.tick++;
        else
          status.tick = 0;
      }
      else
      {
//        togglePin(33);
        motor.motorRight(0);
        motor.motorLeft(0);
      }
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
  if( status.angularVelocityRight == 0 && status.angularVelocityLeft == 0) //might need to change this later
  {
    motorLeft(0);  motorRight(0);          //set motor=0
    status.mode = modeStop;                //set modd
    status.speedBase = 0;
  }
  else
    decelerate();                        //start decelerate
}

void Motor::decelerate()
{
  if( abs(status.speedLeft) > 1 && abs(status.speedRight) > 1)
  { 
	status.mode = modeDecelerate;
    int tempL = status.speedLeft * -0.995;
    int tempR = status.speedRight * -0.995;
    motorLeft(tempL);                     //set opposite speed
    motorRight(tempR);                    //set opposite speed
    status.speedLeft *= -1;
    status.speedRight *= -1;
  

  }
    if(status.angularVelocityLeft == 0 && status.angularVelocityRight == 0) //might need to change this too
		status.mode = modeStop;
}

/* The following functions set the mode and scenario for PID control
	

*/
/*=======================================================  go  =======================================================*/
void Motor::goStraight(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.countRight = 0;
  status.countLeft = 0;
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
  if((status.countLeft)/2 > countCell)   //stop after one cell
    stop();
}

/*=======================================================  rotate  =======================================================*/
void Motor::rotateLeft()
{
  status.mode = modeRotate;                				//set mode
  status.compass = (status.compass+west) % 4;   		//set compass
  status.speedBase = speed;
}

void Motor::rotateRight()
{
  status.mode = modeRotate;                				//set mode
  status.compass = (status.compass+east) % 4;        	//set compass
  status.speedBase = speed;
}
void Motor::rotateBack()
{
  status.mode = modeRotate;                				//set mode
  status.compass = (status.compass+south) % 4;        	//set compass
  status.speedBase = speed;
}

/*=======================================================  turn  =======================================================*/
void Motor::turnLeft(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeTurn;                  		//set mode
  status.compass = (status.compass+3)%4;        //set compass
}

void Motor::turnRight(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeTurn;                  		//set mode
  status.compass = (status.compass+1)%4;        //set compass 
}

/*
The following functions provide raw motor control; positive values set the motors forward, while negative values set the motors backward 
*/
/*=======================================================  motor  =======================================================*/
void Motor::motorLeft(int speed)
{
  status.speedLeft = speed;         //save current speed
  if(speed == 0)                    //stop
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, LOW);
  }
  else if(speed > 0)                //forward
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
  }
  else                              //backward
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
  }
  
  //check to make sure value isn't greater than max speed available
  if (abs(speed) < speedFull)
	pwmWrite(PWMLeft, abs(speed));  //set speed
  else
	pwmWrite(PWMLeft, speedFull);
}

void Motor::motorRight(int speed)
{
  status.speedRight = speed;        //save current speed
  if(speed == 0)                    //stop
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
  }
  else if(speed > 0)                //forward
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
  }
  else                              //backward
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, HIGH);
  }
  
  //check to make sure value isn't greater than max speed available
  if (abs(speed) < speedFull)
	pwmWrite(PWMRight, abs(speed));  //set speed
  else
	pwmWrite(PWMRight, speedFull);
}


