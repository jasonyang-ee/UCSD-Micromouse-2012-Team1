

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
  leftReading = runSensor(sensorSideLeft);
  rightReading = runSensor(sensorSideRight);
  
  //update the current distance to each wall
  frontWallDist = convertDistance(frontReading[0]);
  leftWallDist = convertDistance(leftReading);
  rightWallDist = convertDistance(rightReading);
}

void Sensor::setWall(Cell currentCell)
{
  //if current distance with wall < the calibrated distance, then wall exist
  if(frontWallDist < wallExistDist)
    currentCell.wall[(currentPos+0)%4] = true;
  if(leftWallDist < wallExistDist)
    currentCell.wall[(currentPos+3)%4] = true;
  if(rightWallDist < wallExistDist)
    currentCell.wall[(currentPos+1)%4] = true;
}

void Sensor::getOrientation()
{
  //obtain the distance reading
  diagonalLeftDist = convertDistance(runSensor(sensorDiagonalLeft));
  diagonalRightDist = convertDistance(runSensor(sensorDiagonalRight));
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



