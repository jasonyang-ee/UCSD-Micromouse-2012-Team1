
#include "motor.h"

/*=======================================================  PID  =======================================================*/
/* PID has a lot of stuff in it. things to note: both modeStraight, modeRotate, and modeTurn have subscenarios within them
 that must be changed by setting status.scenario(Straight)(Rotate)(Turn). */
void Motor::PID()
{
  switch (status.mode)
  {
    //stops the mouse; if the initial speed going into this function isn't 0, goes into decelerate
  case modeStop: 
    stop(); 
    break;

    //decelerates the mouse; if the initial speed going into this function is 0, goes into stop
  case modeDecelerate:
    decelerate(); 
    break;

    //Drives straight
  case modeStraight:
    {			
      //all the different scenarios for driving straight
      switch(status.scenarioStraight)
      {
        //follows both diagonal sensors
      case followBoth:
        {
          //Gain values for PID
          int Kp = 1500;
          int Kd = 200;
          int Ki = 0;

          /*suitable for 20,000:*/
          int correction = round(Kp * status.errorDiagonal + Kd*(status.errorDiagonalDiff)/.001 + Ki*status.errorDiagonalTotal);

          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motor.motorRight(status.speedBase + correction);
          motor.motorLeft(status.speedBase - correction);            
          //status.errorDiagonalDiffLast = status.errorDiagonalDiff;
          break;
        }  

        //follows right diagonal and side right sensors
      case followRight:
        {
          //Gain values for PID
          int Kp = 1500;
          int Kd = 200;
          int Ki = 0;
          int correction = round(Kp*status.errorRight + Kd*(status.errorRightDiff)/(.001) + Ki*status.errorRightTotal);
          motorRight(status.speedBase - correction);
          motorLeft(status.speedBase + correction); 					
          break;
        }

        //follows left diagonal and side left sensors
      case followLeft: 
        {
          //Gain values for PID
          int Kp = 1500;
          int Kd = 200;
          int Ki = 0;
          //Correction value from PID
          int correction = round(Kp*status.errorLeft + Kd*(status.errorLeftDiff)/(.001) + Ki*status.errorRightTotal);
          motorRight(status.speedBase - correction);
          motorLeft(status.speedBase + correction); 
          break;				
        }

        //uses side sensors to find an encoder offset, then corrects based off that error
      case fishBone: 
        {
          int Kp = 2320;
          int Kd = 900;
          int Ki = 0.002;
        
        //checks if no wall and stamp not initialized, initialize stamp
          if(status.edgeLeft==raising && status.countStampLeft==0)
            status.countStampLeft = status.countLeft;
          if(status.edgeRight==raising  && status.countStampRight==0)
            status.countStampRight = status.countRight;
         //if no post and stamp has value, set offset
         if (status.countStampLeft !=0 && status.countStampRight !=0)
         {
           status.offsetFishBone = status.countStampLeft - status.countStampRight;
           status.countStampLeft = 0;
           status.countStampRight = 0;
         }
          
          status.offsetFishBoneDiff = status.offsetFishBone - status.offsetFishBoneLast;
//          int offset = round( Kpo*status.offsetFishBone + Kdo*status.offsetFishBoneDiff );
          
          status.errorCount = (status.countLeft - status.countRight - status.offsetFishBone * 0.65);
          status.errorCountDiff = status.errorCount - status.errorCountLast;
          status.errorCountTotal += status.errorCount;
          int correction = round( Kp*status.errorCount + Kd*status.errorCountDiff/0.01 + Ki*status.errorCountTotal);
          
          
          motorRight(status.speedBase + correction);
          motorLeft(status.speedBase - correction );
          
          status.offsetFishBoneLast = status.offsetFishBone;
          status.errorCountLast = status.errorCount;
          
          break;
        }
        
/*--- last 24 hr code  ---*/
      case followEncoder:
      {
        // pid of entire offset/error
        int Kpo = 4000;
        int Kdo = 3200;
        int Kio = 0.05;
        // pid of current count error
        int Kpc = 1700;
        int Kdc = 600;
        int Kic = 0.0001;
        
        // entire offset setting is in motor.goStraight()
        
        // current count difference used as error
        status.errorCount = (status.countLeft - status.countRight - status.offset);
        status.errorCountDiff = status.errorCount - status.errorCountLast;
        status.errorCountTotal += status.errorCount;
        
        //two correction with different pid value
        //timeBetweenStop ++ in globalInterrupts, and reset before goStraight
        int correctionOffset = round( Kpo*status.offset + Kdo*status.offsetDiff/status.timeBetweenStop + Kio*status.offsetTotal);
        int correctionCurrent = round( Kpc*status.errorCount + Kdc*status.errorCountDiff/0.01 + Kic*status.errorCountTotal);
        
        //apply both correction to base speed
        motorRight(status.speedBase + correctionOffset + correctionCurrent);
        motorLeft(status.speedBase - correctionOffset - correctionCurrent);
        
        //update last offset for Kd computation
        status.offsetLast = status.offset;
        status.errorCountLast = status.errorCount;
        
        break;
      }
/*--- last 24 hr code  ---*/


      default: 
        motor.stop(); 
        break;
      }

      if(status.distFront < 9)
        motor.stop();
    }
    break;

    //all the in place turn functions
  case modeRotate:
    {
      //Initialization of PID values
      int Kp = 300;
      int Kd = 30;
      int Ki = 180;

      switch (status.scenarioRotate)
      {
        //left rotate
      case left: 
        {
           //initialization of errors for side turns
          if (status.angSpeedCounter == 0)
          {
            status.errorCountLeftLast = status.errorCountLeft;
            status.errorCountRightLast = status.errorCountRight;
          }
          status.errorCountLeft = countRotateSide  - abs(status.countLeft);
          status.errorCountRight = countRotateSide - abs(status.countRight);

          if (status.tick < 200) //&& status.errorCountRight != 0)
          {
            //only uses the integration value while within 10% of the setpoint value to avoid integral windup
            if (abs(status.errorCountLeft) < countRotateSide/10)
            {
              status.errorCountLeftTotal += status.errorCountLeft;
              status.errorCountRightTotal+= status.errorCountRight;
            }
            else
            {
              status.errorCountLeftTotal = 0;
              status.errorCountRightTotal = 0;
            }
            /*else
              status.errorCountLeftTotal = 0;
            */

            //status.tick = correction;status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;

            status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
            status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
            int correctionLeft = round(Kp*status.errorCountLeft + Kd*status.errorCountLeftDiff/.01 +  Ki*status.errorCountLeftTotal);
            int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff/.01 + Ki*status.errorCountRightTotal);
/*
            if (correctionLeft > 0)
              correctionLeft = ((correctionLeft < 2000 && correctionLeft > 0) ? 2000 : correctionLeft);
            else
              correctionLeft = ((correctionLeft > -2000 && correctionLeft < 0) ? -2000 : correctionLeft);

            if (correctionRight > 0)
              correctionRight = ((correctionRight < 2000 && correctionRight > 0) ? 2000 : correctionRight);
            else
              correctionRight = ((correctionRight > -2000 && correctionRight < 0) ? -2000 : correctionRight);
  */          
            //apply PID control over both motors to ensure rotation about center axis
            motor.motorRight(correctionRight);
            motor.motorLeft(-correctionLeft);
            
            //if motor is.. stalling or something, and within 10 counts of setpoint
            if (status.errorCountLeft < 20)//status.errorCountLeft == status.errorCountLeftLast && status.errorCountLeft < 10)
              status.tick++;
            else
              status.tick = 0;
          }
          else
          {
            // togglePin(33);
            motor.motorRight(0);
            motor.motorLeft(0);
            status.mode=modeStop;
          }
          break;
        }

        //right rotate
      case right:
        {
          //initialization of errors for side turns
          if (status.angSpeedCounter == 0)
          {
            status.errorCountLeftLast = status.errorCountLeft;
            status.errorCountRightLast = status.errorCountRight;
          }
          status.errorCountLeft = countRotateSide  - abs(status.countLeft);
          status.errorCountRight = countRotateSide - abs(status.countRight);

          if (status.tick < 200) //&& status.errorCountRight != 0)
          {
            //only builds the integration term if the error is within 10% of the setpoint
            if (abs(status.errorCountLeft) < countRotateSide/10)
            {            
              status.errorCountRightTotal += status.errorCountRight;
              status.errorCountLeftTotal += status.errorCountLeft;
            }
            else
            {
              status.errorCountRightTotal = 0;
              status.errorCountLeftTotal = 0;
            }

            status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
            status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
            int correctionLeft = round(Kp * status.errorCountLeft + Kd * status.errorCountLeftDiff/.01 + Ki*status.errorCountRightTotal);
            int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff/.01 + Ki*status.errorCountLeftTotal);
            motor.motorRight(-correctionRight);
            motor.motorLeft(correctionLeft);

            //if motor stalls 200 times in a row kinda close to setpoint, give up
            if (status.errorCountRight < 20)//status.errorCountRight == status.errorCountRightLast && status.errorCountRight < 10 )
              status.tick++;
            else
              status.tick = 0;
          }
          else
          {
            // togglePin(33);
            motor.motorRight(0);
            motor.motorLeft(0);
            status.mode=modeStop;
          }				
          break;
        }

        //180 degree rotate
      case back: 
        {
          if (status.angSpeedCounter == 0)
          {
            status.errorCountLeftLast = status.errorCountLeft;
            status.errorCountRightLast = status.errorCountRight;
          }

          status.errorCountLeft = countRotateBack - abs(status.countLeft);
          status.errorCountRight = countRotateBack - abs(status.countRight);
          if (status.tick < 200)
          {
            if (abs(status.errorCountLeft) < countRotateBack/10)
            {
              status.errorCountLeftTotal += status.errorCountLeft;
              status.errorCountRightTotal += status.errorCountRight;
            }
            else
            {
              status.errorCountLeftTotal = 0;
              status.errorCountRightTotal = 0;
            }

            status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
            status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
            int correctionLeft = round(Kp * status.errorCountLeft + Kd * status.errorCountLeftDiff/.01 + Ki*status.errorCountLeftTotal);
            int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff/.01 + Ki*status.errorCountRightTotal);
            motor.motorRight(correctionRight);
            motor.motorLeft(- correctionLeft);

            //as long as 

            if (status.errorCountLeft == status.errorCountLeftLast && status.errorCountLeft < 10)
              status.tick++;
            else
              status.tick = 0;
          }
          else
          {
            //        togglePin(33);
            motor.motorRight(0);
            motor.motorLeft(0);
            status.mode=modeStop;
          }					
          break;
        }
      default: 
        motor.stop();
        break;
      }
      break;
    }    
    case modeTurn:
    {
      status.tick++;
      switch(status.scenarioRotate)
      {
        case left:
        { 
          //decrease inner speed, increase outer speed
          if (status.tick < 127)
          {
            motorLeft( 5200);
            motorRight(14800) ;
          }
          else if (status.tick < 1000)
          {
            motorRight(status.speedBase);
            motorLeft(status.speedBase);
          }
          else
            motor.stop();

          break;
        }
        case right:
        {
          break;
        } 

      }
      break;
    }
  }

}

/*=======================================================  stop  =======================================================*/
void Motor::stop()
{ 

  //if( status.angularVelocityRight == 0 && status.angularVelocityLeft == 0) //might need to change this later
  if(status.angularVelocityLeft < 1 && status.angularVelocityLeft < 1)
  {
    status.mode = modeStop; //set modd
    motorLeft(0);  
    motorRight(0);          //set motor=0								              
    status.speedBase = 0;
    status.countLeftTemp=0;
    status.countRightTemp=0;
  }
  if(status.scenarioStraight == followLeft)
    if(status.distDiagonalRight < 15)
      decelerate();
  
  if(status.scenarioStraight == followRight)
    if(status.distDiagonalLeft < 15)
      decelerate();
      
  if(status.angularVelocityLeft >= 1 && status.angularVelocityLeft >= 1)
    decelerate();
}

void Motor::decelerate()
{
  if(status.angularVelocityLeft >= 1 && status.angularVelocityRight >= 1)
  {
    status.mode = modeDecelerate;
    if(status.countLeftTemp!=0 && status.countRightTemp!=0)
    {
      status.countLeftTemp=status.countLeft;
      status.countRightTemp=status.countRight;
    }
    int error = (status.countLeft - status.countLeftTemp) - (status.countRight - status.countRightTemp);
    int correction = 25*error;
   
    int rateDecelerate = ((abs(status.speedLeft)+abs(status.speedRight))/2>10000)? -0.995 : -0.997;  //set different rate

    int tempL = status.speedLeft * rateDecelerate - correction - status.speedBase/10;
    int tempR = status.speedRight * rateDecelerate + correction - status.speedBase/10;
    motorLeft(tempL);                     //set opposite speed
    motorRight(tempR);                    //set opposite speed
    status.speedLeft *= -1;
    status.speedRight *= -1;
  }
  if(status.angularVelocityLeft < 1 && status.angularVelocityRight < 1) //might need to change this too
    status.mode = modeStop;
}

/* The following functions set the mode and scenario for PID control */
/*=======================================================  go  =======================================================*/
void Motor::goStraight(int speed)
{
  //Error Initializations
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;

/*--- last 24 hr code  ---*/
//store entire offset before reset encoder
  status.timeBetweenStop = 0;
  status.offsetLast = status.offset;
  status.offsetLeft = (status.offsetLeft + status.countLeft) % 10000;
  status.offsetRight = (status.offsetRight + status.countRight) % 10000;
  status.offset = status.offsetLeft - status.offsetRight;
  status.offsetTotal += status.offset;
/*--- last 24 hr code  ---*/

  //Encoder initialization
  status.countRight = 0;
  status.countLeft = 0;

  //mode set
  status.mode = modeStraight;          

  //speed set
  motorRight(speed);  
  motorLeft(speed);
  status.speedBase = speed;
}

//Moves forward one cell
void Motor::goStraightOne (int speed)
{
  //Error Initializations
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;

  //mode set
  status.mode = modeStraight;

  //Encoder Initialization
  status.countRight = 0;
  status.countLeft = 0;

  goStraight(speed);

  //how does this even work?
  if((status.countLeft)/2 > countCell)   //stop after one cell
      stop();
}

/*=======================================================  rotate  =======================================================*/
void Motor::rotateLeft()
{
  //mode set
  status.mode = modeRotate;                				
  //scenario set
  status.scenarioRotate = left;

  //Encoder Initialization
  status.countLeft = 0;
  status.countRight = 0;	

  //Encoder Error Initialization
  status.errorCountLeft = 0;
  status.errorCountRight = 0;

  //tick initialization, used to ensure system is within error margin
  status.tick = 0;
  status.compass = (status.compass+west) % 4;   		//set compass
}

void Motor::rotateRight()
{
  status.mode = modeRotate;                				//set mode
  status.scenarioRotate = right;
  status.countLeft = 0;
  status.countRight = 0;
  status.errorCountLeft = 0;
  status.errorCountRight = 0;
  status.tick = 0;
  status.compass = (status.compass+east) % 4;        	//set compass
}
void Motor::rotateBack()
{
  status.mode = modeRotate;                				//set mode
  status.scenarioRotate = back;
  status.countLeft = 0;
  status.countRight = 0;
  status.errorCountLeft = 0;
  status.errorCountRight = 0;
  status.tick = 0;
  status.compass = (status.compass+south) % 4;        	//set compass
}

/*=======================================================  turn  =======================================================*/
void Motor::turnLeft(int speed)
{
  status.speedBase = speed;
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.scenarioRotate = left;
  status.tick = 0;
  status.mode = modeTurn;                  		//set mode
  status.compass = (status.compass+3)%4;        //set compass
}

void Motor::turnRight(int speed)
{
  status.scenarioRotate = right;
  status.speedBase = speed;
  status.errorDiagonalTotal=0;
  status.errorSideTotal=0;
  status.errorFrontTotal=0;
  status.tick = 0;
  status.mode = modeTurn;                  		//set mode
  status.compass = (status.compass+1)%4;        //set compass 
}

/*
	The following functions provide raw motor control; positive values set the motors forward, while negative values set the motors backward 
 */
/*=======================================================  motor  =======================================================*/
void Motor::motorLeft(int speed)
{
  status.speedLeft = speed;
  if(speed == 0)                    //stop
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, LOW);
    //pwmWrite(PWMLeft, 0);           //set speed
  }
  else if(speed > 0)                //forward
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
    //pwmWrite(PWMLeft, status.speedLeft);		
    //pwmWrite(PWMLeft, speed);
  }
  else                              //backward
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    //pwmWrite(PWMLeft, -speed);		
    //pwmWrite(PWMLeft, -status.speedLeft);  //set speed	
  }

  int absspeed = abs(speed);
  if (absspeed < speedFull)
    pwmWrite(PWMLeft, absspeed);
  else
    pwmWrite(PWMLeft, speedFull); // preserves sign

}

void Motor::motorRight(int speed)
{
  status.speedRight = speed;

  if(speed == 0)                    //stop
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, LOW);
    //pwmWrite(PWMRight, 0);          //set speed
  }
  else if(speed > 0)                //forward
  {
    digitalWrite(motorRight1, HIGH);
    digitalWrite(motorRight2, LOW);
    //pwmWrite(PWMRight, speed);	
    //pwmWrite(PWMRight, status.speedRight);      //set speed		
  }
  else                              //backward
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, HIGH);
    //pwmWrite(PWMRight, -speed);		
    //pwmWrite(PWMRight, -(status.speedRight)); //set speed
  }

  int absspeed = abs(speed);
  if (absspeed < speedFull)
    pwmWrite(PWMRight, absspeed);         //save current speed
  else
    pwmWrite(PWMRight, speedFull);
}



