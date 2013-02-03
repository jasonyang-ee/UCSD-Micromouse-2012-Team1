

#include "sensor.h"

//called in main
void Sensor::runAllSensor()
{ 
  //obtain reading for front left right sensors.
  int frontReading[3], leftReading, rightReading;
  while(1)
  {
    frontReading[1] = runSensor(sensorFrontLeft);
    frontReading[2] = runSensor(sensorFrontRight);
    if(abs(frontReading[1]-frontReading[2]) > 10)
    {
      frontReading[0] = (frontReading[1]+frontReading[2])/2;
      break;
    }
  }
  
  //update the current distance to each wall
  status.frontWallDist = convertDistance(frontReading[0]);
  status.leftWallDist = convertDistance(runSensor(sensorSideLeft));
  status.rightWallDist = convertDistance(runSensor(sensorSideRight));
  status.diagonalLeftDist = convertDistance(runSensor(sensorDiagonalLeft));
  status.diagonalRightDist = convertDistance(runSensor(sensorDiagonalRight));
  
  setOrientation(status);
  setDeviation(status);
  setWall(status.currentCell, status);
}

void Sensor::setWall()
{
  //if current distance with wall < the calibrated distance, then wall exist
  if(status.frontWallDist < wallExistDist)
    currentCell.wall[(status.direction+0)%4] = true;
  if(status.leftWallDist < wallExistDist)
    currentCell.wall[(status.direction+3)%4] = true;
  if(status.rightWallDist < wallExistDist)
    currentCell.wall[(status.direction+1)%4] = true;
}









/*===============  private functions  =======================*/

//controll individual sensor
int Sensor::runSensor(int sensorRef)
{
  //obtain dark voltage with IR turned off
  digitalWrite(sensorFrontLeft, LOW);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);
    idleVoltage += voltageTemp;
    delay(sampleRate);
  }
  idleVoltage /= sampleNum;
  
  //obtain active voltage with IR turned on
  togglePin(sensorFrontLeft);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);
    activeVoltage += voltageTemp;
    delay(sampleRate);
  }
  activeVoltage /= sampleNum;
  //taking the voltage difference between dark and active mode of the receiver
  activeVoltage -= idleVoltage;
  return convertDistance(activeVoltage);
}

//converte voltage signal to distance value in mm (not very accurate)
int Sensor::convertDistance(int activeVoltage)
{ return ((1 / pow(activeVoltage, 2) + 4.28) / 66.4); }

void Sensor::setOrientation(Status status)
{
  //obtain the distance reading
  status.orientation = status.diagonalLeftDist - status.diagonalRightDist;
}

void setDeviation(status)
{
  status.
}


