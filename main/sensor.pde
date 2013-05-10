
#include "sensor.h"

void Sensor::runAllSensor()
{ 
  //read sensor
  status.voltFrontLeft = (runSensor(sensorFrontLeft));
  status.voltFrontRight = (runSensor(sensorFrontRight));
  status.voltSideLeft = (runSensor(sensorSideLeft));
  status.voltSideRight = (runSensor(sensorSideRight));
  status.voltDiagonalLeft = (runSensor(sensorDiagonalLeft));
  status.voltDiagonalRight = (runSensor(sensorDiagonalRight));
 
  //converte voltage to distance
  status.distFrontLeft = convertDistance(status.voltFrontLeft, 1);
  status.distFrontRight = convertDistance(status.voltFrontRight, 2);
  status.distSideLeft = convertDistance(status.voltSideLeft, 3);
  status.distSideRight = convertDistance(status.voltSideRight, 4);
  status.distDiagonalLeft = convertDistance(status.voltDiagonalLeft, 5);
  status.distDiagonalRight = convertDistance(status.voltDiagonalRight, 6);
  status.distFront = (status.distFrontLeft + status.distFrontRight)/2;
  
  angularVelocity();
//  setScenario();
  errorRight();
  errorLeft();
  errorDiagonal();
  errorFront();
  errorSide();
}


/*=======================================================  individual sensor  =======================================================*/
int Sensor::runSensor(int sensorRef)
{
  //turn on IR
  digitalWrite(ledOne, HIGH);
  digitalWrite(ledTwo, HIGH);
  digitalWrite(ledThree, HIGH);
  
  voltage = 0;
  for(int i=0; i<sampleNum; i++)
    voltage += analogRead(sensorRef);
  voltage /= sampleNum;
  
  //turn off IR
  digitalWrite(ledOne, LOW);
  digitalWrite(ledTwo, LOW);
  digitalWrite(ledThree, LOW);
  return voltage;
}

/*=======================================================  conversion  =======================================================*/
double Sensor::convertDistance(int volt, int c)
{
  double x = 1.0/volt;
  //Front Left
  if(c==1)
  {
    // dist = -714.98(1/v)^2 + 216.11(1/v) - 0.7782
    if(volt>9)  return ((-714.98*x*x + 216.11*x + 0.7782)); //- status.distFrontLeft) < 2 ? -714.98*x*x + 216.11*x + 0.7782 : status.distFrontLeft  );  
    else  return 20;
  }
  
  //Front Right
  if(c==2)
  {
    // dist = -998.25*(1/v)^2 + 270.64*(1/v) -1.1891
    if(volt>9)  return (( -998.25*x*x + 270.64*x - 1.1891));// - status.distFrontRight) < 2 ?  -998.25*x*x + 270.64*x - 1.1891: status.distFrontRight );
    else  return 20;
  }
  
  //Side Left
  if(c==3)
  {
    // dist = -414.6(1/V)^2 + 143(1/V) - 0.9423
    if(volt>9)  return ( (-414.6*x*x + 143*x - 0.9423));// - status.distSideLeft) < 2 ? -414.6*x*x + 143*x - 0.9423 : status.distSideLeft );
    else return 20;
  }
  
  //Side Right
  if(c==4)
  {
    // dist = 773.41(1/V)^2 + 96.525(1/V) - 0.6535
    if(volt>9)  return ( 773.41*x*x + 96.525*x - 0.6535);// - status.distSideRight) < 2 ? 773.41*x*x + 96.525*x - 0.6535: status.distSideRight );
    else  return 20;
  }
  
  //Diagonal Left
  if(c==5)
  {
    // dist = -189.78(1/v)^2 + 156.48(1/v) + 0.1224
    if(volt>9)  return ( -189.78*x*x + 156.48*x - 0.1224);
    else  return 20;
  }
  
  //Diagonal Left
  if(c==6)
  {
    // dist = 173.96(1/v)^2 + 156.82(1/v) - 0.0099
    if(volt>9)  return  (173.96*x*x + 156.82*x + 0.0099);
    else  return 20;
  }
}

/*=======================================================  scenario  =======================================================*/
void Sensor::setScenario()
{
  /*------------------------------------------  straight scenario  ------------------------------------------*/
  if(status.distSideLeft > distWallExist && status.distSideRight > distWallExist)
    status.scenarioStraight = fishBone;
  if(status.scenarioStraight == fishBone)  //if fish bone then determine when does it end instead of a post
    if(status.countLeft - status.countStampLeft > 40 || status.countRight - status.countStampRight > 40)
    {
      if(status.distSideLeft > distWallExist && status.distSideRight < distWallExist)
        status.scenarioStraight = followRight;
      if(status.distSideLeft < distWallExist && status.distSideRight > distWallExist)
        status.scenarioStraight = followLeft;
      if(status.distSideLeft < distWallExist && status.distSideRight < distWallExist)
        status.scenarioStraight = followBoth;
      status.countStampLeft = 0; status.countStampRight = 0;
    }
  if(status.scenarioStraight != fishBone)
  {
    if(status.distSideLeft > distWallExist && status.distSideRight < distWallExist)
      status.scenarioStraight = followRight;
    if(status.distSideLeft < distWallExist && status.distSideRight > distWallExist)
      status.scenarioStraight = followLeft;
    if(status.distSideLeft < distWallExist && status.distSideRight < distWallExist)
      status.scenarioStraight = followBoth;
  }
}

/*=======================================================  error  =======================================================*/
void Sensor::errorRight()
{
  //uses diagonal sensor to figure out orientation, horizontal sensor
  //as error measurement
  status.errorRightLast = status.errorRight; // should be errorRight
  int setpoint1 = 9.84;
  int setpoint2 = 2.52;

  //i dont remember what i was doing here, this might be completely wrong lol
  status.errorRight = (status.distDiagonalRight - setpoint1);
  status.errorRight +=( status.errorRight < 0 ? (setpoint2 - status.distSideRight):(status.distSideRight - setpoint2) );
  status.errorRightDiff = status.errorRight - status.errorRightLast;
  status.errorRightTotal +=status.errorRight;
}

void Sensor::errorLeft()
{
  //uses diagonal sensor to figure out orientation, horizontal sensor
  //as error measurement
  status.errorLeftLast = status.errorLeft; // should be errorRight
  int setpoint1 = 9.47;
  int setpoint2 = 3.12;

  //omg what am i doing
  status.errorLeft = (status.distDiagonalLeft - setpoint1);
  status.errorLeft +=( status.errorLeft < 0 ? (setpoint2 - status.distSideLeft):(status.distSideLeft - setpoint2) );
  status.errorLeftDiff = status.errorLeft - status.errorLeftLast;
  status.errorLeftTotal +=status.errorLeft;
}

void Sensor::errorDiagonal()
{
  status.errorDiagonalLast = status.errorDiagonal;
  status.errorDiagonal = (status.distDiagonalLeft - status.distDiagonalRight) * 0.707;
  status.errorDiagonalDiff = status.errorDiagonal - status.errorDiagonalLast;
  status.errorDiagonalTotal += status.errorDiagonal;
}

void Sensor::errorSide()
{
  status.errorSideLast = status.errorSide;
  status.errorSide = status.distSideLeft - status.distSideRight;
  status.errorSideTotal += status.errorSide;
  status.errorSideDiff = status.errorSide - status.errorSideLast;
}

void Sensor::errorFront()
{
  status.errorFrontLast = status.errorFront;
  status.errorFront = status.distFrontLeft - status.distFrontRight;
  status.errorFrontTotal += status.errorFront;
  status.errorFrontDiff = status.errorFront - status.errorFrontLast;
}

/*=======================================================  PID  =======================================================*/
void Sensor::angularVelocity()
{
  //only calculates angular velocity every 10 counts so we get more than an error of 0 or 1
  //control loop is kinda faster than encoder interrupts
  status.angSpeedCounter = (++status.angSpeedCounter)%100;
  if( status.angSpeedCounter == 0)
  { 
    status.angularVelocityLeft = status.countLeft - status.countLeftLast;
    status.angularVelocityRight = status.countRight - status.countRightLast;
    
    status.errorCountLeftTotal = status.errorCountLeftDiff;
    status.errorCountRightTotal = status.errorCountRightDiff;
    
    status.countLeftLast = status.countLeft;
    status.countRightLast = status.countRight;
  }
}
