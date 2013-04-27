
#include "sensor.h"

/*===================  public function  =======================*/
void Sensor::runAllSensor()
{   
  //update raw value to status
  status.frontLeftVolt = (runSensor(sensorFrontLeft));
  status.frontRightVolt = (runSensor(sensorFrontRight));
  status.sideLeftVolt = (runSensor(sensorSideLeft));
  status.sideRightVolt = (runSensor(sensorSideRight));
  status.diagonalLeftVolt = (runSensor(sensorDiagonalLeft));
  status.diagonalRightVolt = (runSensor(sensorDiagonalRight));
 
  //update sensor value to status
  convertDistance(status.frontLeftVolt, 1);
  convertDistance(status.frontRightVolt, 2);
  convertDistance(status.sideLeftVolt, 3);
  convertDistance(status.sideRightVolt, 4);
  convertDistance(status.diagonalLeftVolt, 5);
  convertDistance(status.diagonalRightVolt, 6);
  
  //update position value to status
  setOrientation();
  setDeviation();
}



/*===================  private functions  =======================*/

//controll individual sensor
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


/*===================  conversion functions  =======================*/
void Sensor::convertDistance(int v, int c)
{
  double x = 1.0/v;
  switch(c)
  {
    //Front Left
    case 1:
      status.frontLeftDist = ( -714.98*x*x + 216.11*x + 0.7782 );  // dist = -714.98(1/v)^2 + 216.11(1/v) - 0.7782
      break;
    //Front Right
    case 2:
      status.frontRightDist = ( 0.0001*x*x + 0.0033*x - 0.005 );  // dist = 0.0001(1/v)^2 + 0.0033(1/v) + 0.005
      break;
    //Side Left
    case 3:
      status.sideLeftDist = ( -414.6*x*x + 143*x - 0.9423 );  // dist = -414.6(1/V)^2 + 143(1/V) - 0.9423
      break;
    //Side Right
    case 4:
      status.sideRightDist = ( 773.41*x*x + 96.525*x - 0.6535 );  // dist = 773.41(1/V)^2 + 96.525(1/V) - 0.6535
      break;
    //Diagonal Left
    case 5:
      status.diagonalLeftDist = ( -189.78*x*x + 156.48*x - 0.1224 );  // dist = -189.78(1/v)^2 + 156.48(1/v) + 0.1224
      break;
    //Diagonal Left
    case 6:
      status.diagonalRightDist = ( 173.96*x*x + 156.82*x + 0.0099 );  // dist = 173.96(1/v)^2 + 156.82(1/v) - 0.0099
      break;
  }
}

void Sensor::setOrientation()
{
  status.oldOrientation = status.orientation;
  status.orientation = status.diagonalLeftDist*.707 - status.diagonalRightDist*.707;   // distance measurement*cos45 for distance away from wall
}

void Sensor::setDeviation()
{
  status.oldDeviation = status.deviation;
  status.deviation = status.sideLeftDist - status.sideRightDist;
}

void Sensor::setBalance()
{
  status.oldBalance = status.balance;
  status.balance = status.frontLeftDist - status.frontRightDist;
}

//uses diagonal sensor to figure out orientation, horizontal sensor
//as error measurement
float Sensor::rightError()
{
  int setpoint1 = 11;
  int setpoint2 = 3.59;
  
  float error = (status.diagonalRightDist - setpoint1);
  
  error +=( error < 0 ? (setpoint2 - status.sideRightDist):(status.sideRightDist - setpoint2) );
  
  return error/2;
    
}
