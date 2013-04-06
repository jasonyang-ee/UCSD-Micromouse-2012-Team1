
#include "sensor.h"

/*===================  public function  =======================*/
void Sensor::runAllSensor()
{   
  //update raw value to status
  status.leftFrontVolt = (runSensor(sensorFrontLeft));
  status.rightFrontVolt = (runSensor(sensorFrontRight));
  status.sideLeftVolt = (runSensor(sensorSideLeft));
  status.sideRightVolt = (runSensor(sensorSideRight));
  status.diagonalLeftVolt = (runSensor(sensorDiagonalLeft));
  status.diagonalRightVolt = (runSensor(sensorDiagonalRight));
 
  //update sensor value to status
  status.leftFrontDist = convertDistance(status.leftFrontVolt, 1);
  status.rightFrontDist = convertDistance(status.rightFrontVolt, 2);
  status.sideLeftDist = convertDistance(status.sideLeftVolt, 3);
  status.sideRightDist = convertDistance(status.sideRightVolt, 4);
  status.diagonalLeftDist = convertDistance(status.diagonalLeftVolt, 5);
  status.diagonalRightDist = convertDistance(status.diagonalRightVolt, 6);
  
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
int Sensor::convertDistance(int voltage, int cases)
{
  switch(cases)
  {
    case 1:
      return (1 / pow(voltage, 2) * 66.4 - 4.28);  // X = 1/V^2 ; Dist = 66.4X - 4.28
    case 2:
      return (1 / pow(voltage, 2) * 66.4 - 4.28);  // X = 1/V^2 ; Dist = 66.4X - 4.28
    case 3:
      return (1 / pow(voltage, 2) * 66.4 - 4.28);  // X = 1/V^2 ; Dist = 66.4X - 4.28
    case 4:
      return (1 / pow(voltage, 2) * 66.4 - 4.28);  // X = 1/V^2 ; Dist = 66.4X - 4.28
    case 5:
      return (1 / pow(voltage, 2) * 66.4 - 4.28);  // X = 1/V^2 ; Dist = 66.4X - 4.28
    case 6:
      return (1 / pow(voltage, 2) * 66.4 - 4.28);  // X = 1/V^2 ; Dist = 66.4X - 4.28
  }
}

void Sensor::setOrientation()
{ status.orientation = status.diagonalLeftDist - status.diagonalRightDist; }

void Sensor::setDeviation()
{ status.deviation = status.sideLeftDist - status.sideRightDist; }



