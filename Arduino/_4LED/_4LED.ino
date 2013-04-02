int led[4] = {6,7,8,9};

void setup()
{
  for(int i=0; i<4; i++)
  {
    pinMode(led[i],OUTPUT);
  }
}

void loop()
{
  for(int i; i<4; i++)
  {
    digitalWrite(led[i],HIGH);
    delay(500);
    digitalWrite(led[i],LOW);
    delay(500);
  }
}
