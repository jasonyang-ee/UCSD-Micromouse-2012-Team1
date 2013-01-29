/* refference of variable name  
#define sensorFrontLeft 1
#define sensorFrontRight 2
#define sensorDiagonalLeft 3
#define sensorDiagonalRight 4
#define sensorSideLeft 5
#define sensorSideRight 6
*/
void runAllSensor()
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

int runSensor(int sensorRef)
{
  //initialize variables
  voltageTemp = 0;
  idleVoltage = 0;

  digitalWrite(sensorFrontLeft, LOW);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);
    idleVoltage += voltageTemp;
    delay(sampleRate);
  }
  idleVoltage /= sampleNum;
  
  togglePin(sensorFrontLeft);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);
    activeVoltage += voltageTemp;
    delay(sampleRate);
  }
  activeVoltage /= sampleNum;
  activeVoltage -= idleVoltage;
  
  return distance;
}

int convertDistance()
{
  
  
}
void setWall()
{
  
}


