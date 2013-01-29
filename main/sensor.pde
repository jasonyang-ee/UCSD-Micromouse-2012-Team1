/* refference of variable name  
#define sensorFrontLeft 1
#define sensorFrontRight 2
#define sensorDiagonalLeft 3
#define sensorDiagonalRight 4
#define sensorSideLeft 5
#define sensorSideRight 6
*/

//Constructor
void SENSOR::SENSOR() {voltageTemp = 0; idleVoltage = 0; activeVoltage = 0;}

void SENSOR::runAllSensor()
{
  if (runSensor(sensorFrontLeft) > wallExistDist)
    setWall(true);
  if (runSensor(sensorFrontRight) > wallExistDist)
    setWall(true);
  if (runSensor(sensorDiagonalLeft) > wallExistDist)
    setWall(true);
  if (runSensor(sensorDiagonalRight) > wallExistDist)
    setWall(true);
  if (runSensor(sensorSideLeft) > wallExistDist)
    setWall(true);
  if (runSensor(sensorSideRight) > wallExistDist)
    setWall(true);
}

int SENSOR::runSensor(int sensorRef)
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
  
  return distance;
}

int SENSOR::convertDistance()
{
  
  
}
void SENSOR::setWall()
{
  
}


