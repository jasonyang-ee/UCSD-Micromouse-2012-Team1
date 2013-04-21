
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
      status.frontLeftDist = ( -493.24*x*x + 160.96*x + 0.0749 );  // dist = -493.24(1/V)^2 + 160.94(1/V) + 0.0749
      break;
    //Front Right
    case 2:
      status.frontRightDist = ( -1142.4*x*x + 310.3*x - 1.0298 );  // dist = -1142.4(1/V)^2 + 310.3(1/V) - 1.0298
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
      status.diagonalLeftDist = ( -284.62*x*x + 157.72*x - 0.21 );  // dist = -284.62(1/V)^2 + 157.72(1/V) - 0.21
      break;
    //Diagonal Left
    case 6:
      status.diagonalRightDist = ( 172.43*x*x + 151.56*x + 0.1636 );  // dist = 172.43(1/V)^2 + 151.56(1/V) + 0.1636
      break;
  }
}

void Sensor::setOrientation()
{
  status.orientation = status.diagonalLeftDist*.707 - status.diagonalRightDist*.707;   // distance measurement*cos45 for distance away from wall
}

void Sensor::setDeviation()
{
  status.deviation = status.sideLeftDist - status.sideRightDist;
}

void Sensor::setBalance()
{
  status.balance = status.frontLeftDist - status.frontRightDist;
}



