
#include "sensor.h"

//called in main
void Sensor::runAllSensor()
{ 
  //obtain better reading for front sensors.
  int frontReading[3];
  frontReading[1] = runSensor(sensorFrontLeft);
  frontReading[2] = runSensor(sensorFrontRight);
  frontReading[0] = frontReading[1]<frontReading[2] ? frontReading[1] : frontReading[2];
  
  //update the current distance to each wall
  status.frontDist = convertDistance(frontReading[0]);
  status.sideLeftDist = convertDistance(runSensor(sensorSideLeft));
  status.sideRightDist = convertDistance(runSensor(sensorSideRight));
  status.diagonalLeftDist = convertDistance(runSensor(sensorDiagonalLeft));
  status.diagonalRightDist = convertDistance(runSensor(sensorDiagonalRight));
  
  setOrientation();
  setDeviation();
}



/*===================  private functions  =======================*/

//controll individual sensor
int Sensor::runSensor(int sensorRef)
{
  //obtain dark voltage with IR turned off
  digitalWrite(ledOne, LOW);
  digitalWrite(ledTwo, LOW);
  digitalWrite(ledThree, LOW);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);   //read voltage
    idleVoltage += voltageTemp;            //sum all the voltage reading
    delay(sampleRate);
  }
  idleVoltage /= sampleNum;                //get average reading
  
  //obtain active voltage with IR turned on
  togglePin(ledOne);
  togglePin(ledTwo);
  togglePin(ledThree);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);    //read voltage
    activeVoltage += voltageTemp;           //sum all the voltage reading
    delay(sampleRate);
  }
  activeVoltage /= sampleNum;               //get average reading
  resultVoltage = activeVoltage - idleVoltage;    //get result of difference between dark and active voltage
  return convertDistance(activeVoltage);
}

//converte voltage signal to distance value in mm (not very accurate)
int Sensor::convertDistance(int activeVoltage)
{ return (1 / pow(activeVoltage, 2) * 66.4 - 4.28); }  // X = 1/V^2 ; Dist = 66.4X - 4.28

void Sensor::setOrientation()
{
  //obtain the distance reading
  status.orientation = (status.diagonalLeftDist - status.diagonalRightDist) / 1.414;  //value*sin(45) = vale/sqrt(2)
}

void Sensor::setDeviation()
{
  status.deviation = status.sideLeftDist - status.sideRightDist;
}


/*===================  debug functions  =======================*/

void Sensor::printAll()
{
//print all status variable for debug 
}

