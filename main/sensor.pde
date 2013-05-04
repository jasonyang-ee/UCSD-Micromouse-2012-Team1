
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
  
  //set errors
  angularVelocity();
//  setScenario();
  errorDiagonal();
  errorSide();
  errorFront();
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
    if(volt>10)  return ( -714.98*x*x + 216.11*x + 0.7782 );  
    else  return 20;
  }
  
  //Front Right
  if(c==2)
  {
    // dist = -998.25*(1/v)^2 + 270.64*(1/v) -1.1891
    if(volt>10)  return ( -998.25*x*x + 270.64*x - 1.1891 );
    else  return 20;
  }
  
  //Side Left
  if(c==3)
  {
    // dist = -414.6(1/V)^2 + 143(1/V) - 0.9423
    if(volt>10)  return ( -414.6*x*x + 143*x - 0.9423 );
    else return 20;
  }
  
  //Side Right
  if(c==4)
  {
    // dist = 773.41(1/V)^2 + 96.525(1/V) - 0.6535
    if(volt>10)  return ( 773.41*x*x + 96.525*x - 0.6535 );
    else  return 20;
  }
  
  //Diagonal Left
  if(c==5)
  {
    // dist = -189.78(1/v)^2 + 156.48(1/v) + 0.1224
    if(volt>10)  return ( -189.78*x*x + 156.48*x - 0.1224 );
    else  return 20;
  }
  
  //Diagonal Left
  if(c==6)
  {
    // dist = 173.96(1/v)^2 + 156.82(1/v) - 0.0099
    if(volt>10)  return ( 173.96*x*x + 156.82*x + 0.0099 );
    else  return 20;
  }
}

/*=======================================================  scenario  =======================================================*/
void Sensor::setScenario()
{
  if(status.mode)
  {
    /*------------------------------------------  straight scenario  ------------------------------------------*/
    if(status.distSideLeft > distWallExist && status.distFront > distWallExist)
      status.scenarioStraight = followRight;
    else if(status.distSideRight > distWallExist)
      status.scenarioStraight = followLeft;
    else if(status.distSideLeft > distWallExist && status.distSideRight > distWallExist)
      status.scenarioStraight = fishBone;
  }

}

/*=======================================================  error  =======================================================*/
void Sensor::errorRight()
{
  //uses diagonal sensor to figure out orientation, horizontal sensor
  //as error measurement
  status.errorDiagonalLast = status.errorDiagonal;
  int setpoint1 = 11;
  int setpoint2 = 3.59;
  status.errorDiagonal = (status.distDiagonalRight - setpoint1);
  status.errorDiagonal +=( status.errorDiagonal < 0 ? (setpoint2 - status.distSideRight):(status.distSideRight - setpoint2) );
}

void Sensor::errorDiagonal()
{
  status.errorDiagonalLast = status.errorDiagonal;
  status.errorDiagonal = (status.distDiagonalLeft - status.distDiagonalRight) * 0.703;
}

void Sensor::errorSide()
{
  status.errorSideLast = status.errorSide;
  status.errorSide = status.distSideLeft - status.distSideRight;
}

void Sensor::errorFront()
{
  status.errorFrontLast = status.errorFront;
  status.errorFront = status.distFrontLeft - status.distFrontRight;
}

/*=======================================================  PID  =======================================================*/
void Sensor::angularVelocity()
{
  status.angularVelocity = status.countLeft - status.countLeftLast;
  status.countLeftLast = status.countLeft;
}

void Sensor::errorDiagonalTotal()  { status.errorDiagonalTotal += status.errorDiagonal; }

void Sensor::errorSideTotal()  { status.errorSideTotal += status.errorSide; }

void Sensor::errorFrontTotal()  { status.errorFrontTotal += status.errorFront; }

void Sensor::errorCountLeftTotal()  { status.errorCountLeftTotal += status.errorCountLeft; }

void Sensor::errorDiagonalDiff()  { status.errorDiagonalDiff = status.errorDiagonal - status.errorDiagonalLast; }

void Sensor::errorSideDiff()  { status.errorSideDiff = status.errorSide - status.errorSideLast; }

void Sensor::errorFrontDiff()  { status.errorFrontDiff = status.errorFront - status.errorFrontLast; }
