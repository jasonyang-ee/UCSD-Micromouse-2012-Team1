void setup()
{
  //Reciever
  #define sensorFrontLeft 6
  #define sensorFrontRight 5
  #define sensorDiagonalLeft 7
  #define sensorDiagonalRight 4
  #define sensorSideLeft 8
  #define sensorSideRight 3
  
  //IR LED
  #define ledOne 12
  #define ledTwo 13
  #define ledThree 14
  
  Sensor sensor;
  
  pinMode(sensorFrontLeft,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(sensorFrontRight,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(sensorDiagonalLeft,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(sensorDiagonalRight,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(sensorSideLeft,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(sensorSideRight,INPUT_ANALOG);  //int sensorSideRight
  pinMode(ledOne, OUTPUT);
  pinMode(ledTwo, OUTPUT);
  pinMode(ledThree, OUTPUT);
  
  digitalWrite(ledOne, HIGH);
  digitalWrite(ledTwo, HIGH);
  digitalWrite(ledThree, HIGH);
}

void loop()
{
  
  togglePin(ledOne);
  togglePin(ledTwo);
  togglePin(ledThree);
  
  activeV = 0;
  for(int i=0; i<5; i++)
  {
    activeV += analogRead(sensor);
    delay(5);
  }
  activeV /= 5;   


}
