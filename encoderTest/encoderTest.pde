int dir = 31;
int clock = 30;

int count = 0;

void setup()
{
  pinMode(dir, INPUT);
  pinMode(clock, INPUT);
  
  attachInterrupt(clock, encode, RISING);
}

void loop()
{
  SerialUSB.println(count);
}

void encode()
{
  if (digitalRead(dir) == HIGH)
    count++;
  else
    count--;
}
