int dir = 29;
int clock = 28;

volatile int count = 0;

void setup()
{
  pinMode(dir, INPUT);
  pinMode(clock, INPUT);
  attachInterrupt(clock, encode, CHANGE);
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
