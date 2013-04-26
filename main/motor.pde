
#include "motor.h"

/*===================  Mapping scenario handling  =======================*/
void Motor::applyMotorMapping(int scenario)
{
  
  switch (scenario)
  {
    //*-----  straightaway, walls on both left and right side  -----*/
    case 1:
      if (status.frontRightDist > 5 && (status.diagonalRightDist < 5 && status.diagonalLeftDist < 5))
        motor.goStraight (5000);
      else
      {
        //need a function here to cruise into the middle of the cell or soemthing, idk
        //from there, jump to scenario -1
        //scenario = -1;
      }
      break;
      
    /*-----  left turn  -----*/
    case 2:
                //modify turnLeft to keep turning, bring the if statement here;
                //since global interupt runs every millisecond, and turning left takes longer than that
      if (status.wheelCountLeft < turnCount)
        motor.turnLeft (5000); 
      else
      {
        motor.stop();
        scenario = -1;			
      }
      break;
      
    /*-----  right turn  -----*/
    case 3:
            //same as above
      if (status.wheelCountLeft < turnCount)
        motor.turnRight (5000);
      else
      {
        motor.stop();
        scenario = -1;
      }
      break;
    /*-----  180 Degree Turn  -----*/
    case 4:
      if (status.wheelCountLeft < UturnCount)
        motor.turnRight (5000);
      else
      {
        motor.stop();
        scenario = -1;
      }
      break;
    /*-----  case -1  -----*/
    default:
            // checks front to see that there's no wall there, and the left/right diagonals to be sure there are walls there
      if (status.frontRightDist > 5 && (status.diagonalRightDist < 5 && status.diagonalLeftDist < 5))  
        scenario = 1;
            //also need a scenario to like... drive up to the middle of a cell without wobbling.
            //right/left diagonals will flag higher than 5 before the mouse actually gets into the cell
      else
      {
        if (status.sideRightDist > 5)
          scenario = 3;
        else if (status.sideLeftDist > 5)
          scenario = 2;
        else 
          scenario = 4;
      }
  }
  */
}


/*===================  Racing scenario handling  =======================*/
void Motor::applyMotorRacing(int scenario)
{
  switch (scenario)
  {
    /*-----  straightaway, walls on both left and right side  -----*/
    case 1:
      if (status.frontRightDist > 5 && (status.diagonalRightDist < 5 && status.diagonalLeftDist < 5))
        motor.goStraight (5000);
      else
      {
        //need a function here to cruise into the middle of the cell or soemthing, idk
        //from there, jump to scenario -1
        //scenario = -1;
      }
      break;
      
    /*-----  left turn  -----*/
    case 2:
                //modify turnLeft to keep turning, bring the if statement here;
                //since global interupt runs every millisecond, and turning left takes longer than that
      if (status.wheelCountLeft < turnCount)
        motor.turnLeft (5000); 
      else
      {
        motor.stop();
        scenario = -1;			
      }
      break;
      
    /*-----  right turn  -----*/
    case 3:
            //same as above
      if (status.wheelCountLeft < turnCount)
        motor.turnRight (5000);
      else
      {
        motor.stop();
        scenario = -1;
      }
      break;
    /*-----  180 Degree Turn  -----*/
    case 4:
      if (status.wheelCountLeft < UturnCount)
        motor.turnRight (5000);
      else
      {
        motor.stop();
        scenario = -1;
      }
      break;
    /*-----  case -1  -----*/
    default:
            // checks front to see that there's no wall there, and the left/right diagonals to be sure there are walls there
      if (status.frontRightDist > 5 && (status.diagonalRightDist < 5 && status.diagonalLeftDist < 5))  
        scenario = 1;
            //also need a scenario to like... drive up to the middle of a cell without wobbling.
            //right/left diagonals will flag higher than 5 before the mouse actually gets into the cell
      else
      {
        if (status.sideRightDist > 5)
          scenario = 3;
        else if (status.sideLeftDist > 5)
          scenario = 2;
        else 
          scenario = 4;
      }
  }
}


/*===================  PID position adjustment  =======================*/
void Motor::fixOrientation(int speed)
{
  int correction;
  
  //mapping mode correction
  if(status.mode == mapping)
  {
    //when diagonal sensor can still read
    if(status.diagonalLeftDist < wallExistDist && status.diagonalRightDist < wallExistDist)
    {
      correction = round(orientationConstant * status.orientation);
      motorRight(speed + correction);
      motorLeft(speed - correction);
    }
    //when diagonal sensor fail, then switch to side sensor
    else if(status.sideLeftDist < wallExistDist && status.sideRightDist < wallExistDist)
    {
      correction = round(orientationConstant * status.deviation);
      motorRight(speed + correction);
      motorLeft(speed - correction);
    }
    //when both diagonal and side sensor fail, then switch to front sensor
    else if(status.frontLeftDist < wallExistDist && status.frontRightDist < wallExistDist)
    {
      correction = round(orientationConstant * status.balance);
      motorRight(speed + correction);
      motorLeft(speed - correction);
    }
    //else dont correct
  }
  
  //racing mode correction
  else if(status.mode == racing)
  {
    if(status.diagonalLeftDist < wallExistDist && status.diagonalRightDist < wallExistDist)
    {
      correction = round(orientationConstant * status.orientation);
      motorRight(speed + correction);
      motorLeft(speed - correction);
    }
    else if(status.sideLeftDist < wallExistDist && status.sideRightDist < wallExistDist)
    {
      correction = round(orientationConstant * status.deviation);
      motorRight(speed + correction);
      motorLeft(speed - correction);
    }
    else if(status.frontLeftDist < wallExistDist && status.frontRightDist < wallExistDist)
    {
      correction = round(orientationConstant * status.balance);
      motorRight(speed + correction);
      motorLeft(speed - correction);
    }
  }
}


/*==================  action in the same position  =====================*/
void Motor::stop()
{
  motorLeft(0);
  motorRight(0);
}

//stop and turn left
void Motor::turnLeft(int speed)
{
  int encoderTemp1, encoderTemp2;
  stop();                                                  //stop before turn
  encoderTemp1 = status.wheelCountLeft;                    //store counts
  motorLeft(-turnSpeed);
  motorRight(turnSpeed);                                   //speed for left and right
  while(status.wheelCountLeft - encoderTemp1 < turnCount)    
    continue;                                              //turnning
  stop();                                                  //stop after turn
  status.compass = (status.compass-1)%4;
}

//stop and turn right
void Motor::turnRight(int speed)
{
  int encoderTemp1, encoderTemp2;
  stop();                                                 //stop before turn
  encoderTemp1 = status.wheelCountLeft;                   //store counts
  motorLeft(turnSpeed); 
  motorRight(-turnSpeed);                                 //speed for left and right
  while(status.wheelCountLeft - encoderTemp1 < turnCount)    
    continue;                                             //turnning
  stop();                                                 //stop after turn
  status.compass = (status.compass+1)%4;
}

//turn 180 degree
void Motor::turnBack()
{
  int encoderTemp1, encoderTemp2;
  stop();                                                 //stop before turn
  encoderTemp1 = status.wheelCountLeft;                   //store counts
  motorLeft(-turnSpeed);
  motorRight(turnSpeed);                                  //speed for left and right
  while(status.wheelCountLeft - encoderTemp1 < UturnCount)    
    continue;                                             //turnning
  stop();                                                 //stop after turn
  status.compass = (status.compass+2)%4;
}


/*===============  action with changing position  ===================*/
void Motor::goStraight(int speed)
{
  motorRight(speed);
  motorLeft(speed);
  fixOrientation(speed);
}

//Austin's
void Motor::goStraightOne (int speed)              //Moves Forward One Cell
{
  status.wheelCountRight = 0;
  status.wheelCountLeft = 0;
  
  while (((status.wheelCountRight + status.wheelCountLeft)/2) <= cellLength)
  {
    motorRight (speed);
    motorLeft (speed);
    fixOrientation(speed);
  }
  stop();
}

void Motor::goBack(int speed)
{
  fixOrientation(-speed);
}

//turn left while moving forward
void Motor::goLeft(int speed)
{
  int encoderTemp1 = status.wheelCountLeft;
  int speedTempLeft = status.speedLeft;                    //store speed
  int speedTempRight = status.speedRight;
  motorLeft(speed);                                        //set turn speed
  motorRight(speed/driveRatio);
  while(status.wheelCountLeft - encoderTemp1 < driveTurnCount)    
    continue;                                              //turnning
  status.compass = (status.compass-1)%4;                   //update compass
  motorLeft(speedTempLeft);                                //resotre old speed
  motorRight(speedTempRight);
}

//turn right while moving forward
void Motor::goRight(int speed)
{
  int encoderTemp1 = status.wheelCountLeft;
  int speedTempLeft = status.speedLeft;                    //store speed
  int speedTempRight = status.speedRight;
  motorLeft(speed/driveRatio);                             //set turn speed
  motorRight(speed);
  while(status.wheelCountLeft - encoderTemp1 < driveTurnCount)    
    continue;                                              //turnning
  status.compass = (status.compass+1)%4;                   //update compass
  motorLeft(speedTempLeft);                                //resotre old speed
  motorRight(speedTempRight);
}



/*===================  private functions  =======================*/

void Motor::motorLeft(int speed)
{
  //speed *= 1.025;
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
  else
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, abs(speed));
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
  else
  {
    digitalWrite(motorRight1, LOW);
    digitalWrite(motorRight2, HIGH);
    pwmWrite(PWMRight, abs(speed));
  }
  
}

