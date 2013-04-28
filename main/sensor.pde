
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
<<<<<<< HEAD
      status.frontLeftDist = ( -493.24*x*x + 160.96*x + 0.0749 );  // dist = -493.24(1/V)^2 + 160.94(1/V) + 0.0749
      break;
    //Front Right
    case 2:
      status.frontRightDist = ( -1142.4*x*x + 310.3*x - 1.0298 );  // dist = -1142.4(1/V)^2 + 310.3(1/V) - 1.0298
=======
      if(v>10)
        status.frontLeftDist = ( -714.98*x*x + 216.11*x + 0.7782 );  // dist = -714.98(1/v)^2 + 216.11(1/v) - 0.7782
      else
        status.frontLeftDist = 20;
      break;
    //Front Right
    case 2:
      if(v>10)
        status.frontRightDist = ( -998.25*x*x + 270.64*x - 1.1891 );  // dist = -998.25x2 + 270.64x - 1.1891
      else
        status.frontRightDist = 20;
>>>>>>> sensor
      break;
    //Side Left
    case 3:
      if(v>10)
        status.sideLeftDist = ( -414.6*x*x + 143*x - 0.9423 );  // dist = -414.6(1/V)^2 + 143(1/V) - 0.9423
      else
        status.sideLeftDist = 20;
      break;
    //Side Right
    case 4:
      if(v>10)
        status.sideRightDist = ( 773.41*x*x + 96.525*x - 0.6535 );  // dist = 773.41(1/V)^2 + 96.525(1/V) - 0.6535
      else
        status.sideRightDist = 20;
      break;
    //Diagonal Left
    case 5:

      if(v>10)
        status.diagonalLeftDist = ( -189.78*x*x + 156.48*x - 0.1224 );  // dist = -189.78(1/v)^2 + 156.48(1/v) + 0.1224
      else
        status.diagonalLeftDist = 20;
      break;
    //Diagonal Left
    case 6:
      if(v>10)
        status.diagonalRightDist = ( 173.96*x*x + 156.82*x + 0.0099 );  // dist = 173.96(1/v)^2 + 156.82(1/v) - 0.0099
      else
        status.diagonalRightDist = 20;

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



