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

//called in main
void SENSOR::runAllSensor()
{ 
  //obtain more accurate wall reading for front
  int frontReading[2];
  while(abs(frontReading[0]-frontReading[1]) > 50)
  {
    frontReading[0] = runSensor(sensorFrontLeft);
    frontReading[1] = runSensor(sensorFrontRight);
  }
  
  //need to measure wallExistDist value, the dist between wall and mouse when mouse is in center
  /*
  Direction code
            N          0
          W   E  ==  3   1
            S          2
  */        
  if((frontReading[0]+frontReading[1])/2 > wallExistDist)
    setWall((currentPos+0)%4, true); 
  if (runSensor(sensorSideLeft) > wallExistDist)
    setWall((currentPos+3)%4, true);
  if (runSensor(sensorSideRight) > wallExistDist)
    setWall((currentPos+1)%4, true);
}

//controll individual sensor
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
  convertDistance(activeVoltage);
  return distance;
}

//converte voltage signal to distance value in mm (not very accurate)
void SENSOR::convertDistance(int activeVoltage)
{
  distance = (1 / pow(activeVoltage, 2) + 4.28) / 66.4
}

void SENSOR::setWall(int position, int existance)
{
  
}


