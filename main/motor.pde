
#include "motor.h"

/*=======================================================  PID  =======================================================*/
void Motor::PID()
{
  switch (status.mode)
  {
  case modeStop: 
    stop(); 
    break;

  case modeDecelerate:
    decelerate(); 
    break;

  case modeStraight:
    {
      switch(status.scenarioStraight)
      {
      case followBoth:
        {
          int correction = round(800 * status.errorDiagonal + 130*(status.errorDiagonalDiff)/.001 + 20*status.errorDiagonalTotal);
          /*suitable for 20,000: int correction = round(1500 * status.errorDiagonal + 200*(status.errorDiagonalDiff)/.001 + 35*status.errorDiagonalTotal);*/
          motor.motorRight(status.speedBase + correction);
          motor.motorLeft(status.speedBase - correction);            
/*?*/          status.errorDiagonalDiffLast = status.errorDiagonalDiff;
          break;
        }  

      case followRight:
        {
          int correction = round(1000*status.errorRight + ((status.errorRightDiff)/(.001)*5));
          motorRight(status.speedBase + correction);
          motorLeft(status.speedBase - correction); 
          break;
        }

      case followLeft: 
        {
          int correction = round(1000*status.errorLeft + ((status.errorLeftDiff)/(.001)*5));
          motorRight(status.speedBase + correction);
          motorLeft(status.speedBase - correction); 
          break;
        }
        break;
        
      case fishBone: 
        {
          if(status.distFront > distWallExist)
          {
            status.errorCountDiff = status.countLeft - status.countRight;
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
          else
            motor.stop();
        }

      default: 
        motor.stop(); 
        break;
      }
      break;
    }


  case modeRotate:
    {
      //initialization of errors
      status.errorCountLeftLast = status.errorCountLeft;
      status.errorCountRightLast = status.errorCountRight;
      status.errorCountLeft = countRotateSide  - abs(status.countLeft);
      status.errorCountRight = countRotateSide - status.countRight;

      //Initialization of PID values
      int Kp = 100;
      int Kd = 50;
      int Ki = 10;

      switch (status.scenarioRotate)
      {
      case left: 
        {

          if (status.errorCountLeft !=0)  //status.tick < 5000) //&& status.errorCountRight != 0)
          {
            if (abs(status.errorCountLeft) < countRotateSide/10)
              status.errorCountLeftTotal += status.errorCountLeft;
            else
              status.errorCountLeftTotal = 0;

            //status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
            status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
            int correction = round(Kp*status.errorCountLeft + Kd*status.errorCountLeftDiff);  // + Ki*status.errorCountLeftTotal);
            //int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);
            motor.motorRight(correction);
            motor.motorLeft(-correction);
            status.tick = correction;
            //as long as 
            /*
            if (status.errorCountLeft == status.errorCountLeftLast )
            status.tick++;
            else
            status.tick = 0;
            */

          }					
          else
          {
            //togglePin(33);
            motor.motorRight(0);
            motor.motorLeft(0);
            //motor.stop();
          }
          break;
        }

      case right:
        {
          if (status.tick < 200) //&& status.errorCountRight != 0)
          {
            if (abs(status.errorCountRight) < countRotateSide/10)
              status.errorCountRightTotal += status.errorCountRight;
            else
              status.errorCountRightTotal = 0;

            //status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
            status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
            int correction = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);  // + Ki*status.errorCountLeftTotal);
            //int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);
            motor.motorRight(-correction);
            motor.motorLeft(correction);

            //as long as 

            if (status.errorCountRight == status.errorCountRightLast )
              status.tick++;
            else
              status.tick = 0;
          }
          else
          {
            //togglePin(33);
            motor.motorRight(0);
            motor.motorLeft(0);
            motor.stop();
          }				
          break;
        }
      case back: 
        {
          status.errorCountLeftLast = status.errorCountLeft;
          status.errorCountLeft = countRotateBack - abs(status.countLeft);
          status.errorCountRight = countRotateBack - abs(status.countRight);
          if (status.tick < 500)
          {
            if (abs(status.errorCountLeft) < 15)
              status.errorCountLeftTotal += status.errorCountLeft;
            else
              status.errorCountLeftTotal = 0;

            //status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
            status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
            int correction = round(Kp * status.errorCountLeft + Kd * status.errorCountLeftDiff);  // + Ki*status.errorCountLeftTotal);
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
            //togglePin(33);
            motor.motorRight(0);
            motor.motorLeft(0);
            motor.stop();
          }					
          break;
        }
        //default: motor.stop();break;
      }
      break;
    }
  }
}

/*=======================================================  stop  =======================================================*/
void Motor::stop()
{ 
  //if( status.angularVelocityRight == 0 && status.angularVelocityLeft == 0) //might need to change this later
  if(status.speedLeft == 0 && status.speedRight == 0)
  {
    motorLeft(0);  
    motorRight(0);  //set motor=0
    status.mode = modeStop;  //set modd
    status.speedBase = 0;
  }
  else
    decelerate();  //start decelerate
}

void Motor::decelerate()
{
  int rateDecelerate;
  rateDecelerate = ((abs(status.speedLeft)+abs(status.speedRight))/2>17000)? 0.996 : 0.993;  //set different rate
  rateDecelerate = ((abs(status.speedLeft)+abs(status.speedRight))/2>14000)? 0.993 : 0.991;
  rateDecelerate = ((abs(status.speedLeft)+abs(status.speedRight))/2>10000)? 0.991 : 0.985;
  rateDecelerate = ((abs(status.speedLeft)+abs(status.speedRight))/2>5000)? 0.985 : 0.98;

  if( abs(status.speedLeft) > 1 && abs(status.speedRight) > 1)
  { 
    status.mode = modeDecelerate;
    int tempL = status.speedLeft * -rateDecelerate;
    int tempR = status.speedRight * -rateDecelerate;  
    motorLeft(tempL);  //set opposite speed
    motorRight(tempR);  //set opposite speed
    status.speedLeft *= -1;
    status.speedRight *= -1;
  }
  if(status.angularVelocityLeft == 0 && status.angularVelocityRight == 0) //might need to change this too
    status.mode = modeStop;
}


/* The following functions set the mode and scenario for PID control*/
/*=======================================================  go  =======================================================*/
void Motor::goStraight(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.countRight = 0;
  status.countLeft = 0;
  status.mode = modeStraight;  //set mode
  motorRight(speed);  
  motorLeft(speed);  //set speed
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
  status.mode = modeRotate;  //set mode
  status.scenarioRotate = left;
  status.countLeft = 0;
  status.countRight = 0;		
  status.errorCountLeft = 0;
  status.errorCountRight = 0;
  status.tick = 0;
  status.compass = (status.compass+west) % 4;  //set compass
}

void Motor::rotateRight()
{
  status.mode = modeRotate;  //set mode
  status.scenarioRotate = right;
  status.countLeft = 0;
  status.countRight = 0;
  status.errorCountLeft = 0;
  status.errorCountRight = 0;
  status.tick = 0;
  status.compass = (status.compass+east) % 4;  //set compass
}
void Motor::rotateBack()
{
  status.mode = modeRotate;  //set mode
  status.scenarioRotate = back;
  status.countLeft = 0;
  status.countRight = 0;
  status.errorCountLeft = 0;
  status.errorCountRight = 0;
  status.tick = 0;
  status.compass = (status.compass+south) % 4;  //set compass
}

/*=======================================================  turn  =======================================================*/
void Motor::turnLeft(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeTurn;  //set mode
  status.compass = (status.compass+3)%4;  //set compass
}

void Motor::turnRight(int speed)
{
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.mode = modeTurn;  //set mode
  status.compass = (status.compass+1)%4;  //set compass 
}


/*The following functions provide raw motor control; positive values set the motors forward, while negative values set the motors backward */
/*=======================================================  motor  =======================================================*/
void Motor::motorLeft(int speed)
{
  int absspeed = abs(speed);
  if (absspeed < speedFull)
    status.speedLeft = speed;  //save current speed
  else
  {
    int sign = absspeed/speed;
    status.speedLeft = sign*speedFull;  //preserves sign
  }

  if(speed == 0)  //stop
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, 0);  //set speed
  }
  else if(speed > 0)  //forward
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, status.speedLeft);
    //pwmWrite(PWMLeft, speed);
  }
  else  //backward
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    //pwmWrite(PWMLeft, -speed);
    pwmWrite(PWMLeft, -status.speedLeft);  //set speed

  }
}

void Motor::motorRight(int speed)
{
  int absspeed = abs(speed);
  if (absspeed < speedFull)
    status.speedRight = speed;  //save current speed
  else
  {
    int sign = absspeed/speed;
    status.speedRight = sign*speedFull;  //preserves sign
  }
  if(speed == 0)  //stop
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
    pwmWrite(PWMRight, 0);  //set speed
  }
  else if(speed > 0)  //forward
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
    //pwmWrite(PWMRight, speed);
    pwmWrite(PWMRight, status.speedRight);  //set speed		

  }
  else  //backward
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, HIGH);
    //pwmWrite(PWMRight, -speed);

    pwmWrite(PWMRight, -(status.speedRight)); //set speed
  }
}



