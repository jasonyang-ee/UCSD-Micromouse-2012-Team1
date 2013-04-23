
#include "motor.h"

/*===================  Mapping scenario handling  =======================*/
void Motor::applyMotorMapping(int scenario)
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


/*===================  Go straight adjustment  =======================*/
void Motor::goStraightPID(int speed)
{
  int correction;
  
/*----------  mapping mode correction  ----------*/
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
  
/*-------------  racing mode correction  ----------*/
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
  int count = status.wheelCountLeft;
  while( abs(abs(status.wheelCountLeft)-abs(count)) > 10 )
  {
    motorLeft(-status.speedLeft);
    motorRight(-status.speedRight);
  }
  motorLeft(0);
  motorRight(0);
}

//stop and turn left
void Motor::turnLeft(int speed)
{
  status.wheelCountLeft = 0;
  int error;
  while(error > 15)
  {
    error = turnCount + status.wheelCountLeft;
    motorLeft(-speed);
    motorRight(speed);
  }
  
/*  
  int error, sumError=0;
  int prevCount = status.wheelCountLeft;
  int turnKP = speed/500;
  int turnKI = 0.0001;
  int turnKD = 10;
  int state = 1, count = 0;
  int PID;
  stop();
  status.wheelCountLeft = 0;
  while(count<3)
  {
    error = turnCount + status.wheelCountLeft;
    sumError += error;
    PID = turnKP*error - turnKI*(sumError) + turnKD*(status.wheelCountLeft - prevCount);
    motorLeft(PID*state*-1);
    motorRight(PID*state);
    prevCount = status.wheelCountLeft;
    if(error*state<0) 
    {
      state*=-1;
      count++;
    }
  }
*/  
  
  stop();                                                  //stop after turn
  status.compass = (status.compass+3)%4;
}

//stop and turn right
void Motor::turnRight(int speed)
{
  int encoderTemp = status.wheelCountLeft;
  stop();                                                 //stop before turn
  motorLeft(turnSpeed); 
  motorRight(-turnSpeed);                                 //speed for left and right
  while( abs(status.wheelCountLeft - encoderTemp) < turnCount)    
    continue;                                             //turnning
  stop();                                                 //stop after turn
  status.compass = (status.compass+1)%4;
}

//turn 180 degree
void Motor::turnBack()
{
  int encoderTemp = status.wheelCountLeft;
  stop();                                                 //stop before turn
  motorLeft(-turnSpeed);
  motorRight(turnSpeed);                                  //speed for left and right
  while( abs(status.wheelCountLeft - encoderTemp) < UturnCount)    
    continue;                                             //turnning
  motor.stop();                                                 //stop after turn
  status.compass = (status.compass+2)%4;
}


/*===============  action with changing position  ===================*/
void Motor::goStraight(int speed)
{
  int error, sumError=0;
  int prevOrientation = status.orientation;
  int turnKP, turnKI, turnKD;
  turnKP = 10000/speed;
  turnKI = 0.001;
  turnKD = speed*0.5;
    error = status.orientation;
    sumError += error;
    motorLeft(speed + turnKP*error + turnKI*(sumError) + turnKD*(status.orientation - prevOrientation));
    motorRight(speed + turnKP*error + turnKI*(sumError) + turnKD*(status.orientation - prevOrientation));
    prevOrientation = status.orientation;
}

void Motor::goBack(int speed)
{
  goStraightPID(-speed);
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
  status.compass = (status.compass+3)%4;                   //update compass
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
  if(speed > fullSpeed) speed = fullSpeed;
  if(speed < -fullSpeed) speed = -fullSpeed;
  
  status.speedLeft = speed;    //update current motor speed
  if(speed == 0)
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, 0);
  }
  else if(speed > 0)
  {
    digitalWrite(motorLeft1, HIGH);
    digitalWrite(motorLeft2, LOW);
    pwmWrite(PWMLeft, speed);
  }
  else
  {
    digitalWrite(motorLeft1, LOW);
    digitalWrite(motorLeft2, HIGH);
    pwmWrite(PWMLeft, abs(speed));
  }
  
}

void Motor::motorRight(int speed)
{
  if(speed > fullSpeed) speed = fullSpeed;
  if(speed < -fullSpeed) speed = -fullSpeed;
  
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

