int IR  = 15;
int sensor = 11;
double value, average, distance, darkValue, darkDistance;

void setup()
{
  pinMode(IR, OUTPUT);
  pinMode(sensor, INPUT_ANALOG);
  digitalWrite(IR, HIGH);
}

void loop()
{
  togglePin(IR);
  average=0;
  for(int i=0; i<5; i++)
  {
    value = analogRead(sensor);
    average += value;
    delay(5);
  }
  average /= 5; 
 
  distance = (1 / pow(average, 2))*1000;
  

  SerialUSB.print("V = ");
  SerialUSB.print(average);
  SerialUSB.print("\tX = ");
  SerialUSB.print(distance);
  SerialUSB.print("\n");
  
  delay(300);
}
