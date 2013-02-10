const int PWMA = 25;
const int AIN2 = 22;
const int AIN1 = 21;
const int STBY = 20;
const int BIN1 = 19;
const int BIN2 = 18;
const int PWMB = 15;

void setup()
{
  pinMode(PWMA, PWM);
  pinMode(AIN2, OUTPUT);
  pinMode(AIN1, OUTPUT);
  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);  
  pinMode(STBY, OUTPUT);
  pinMode(PWMB, PWM);
  digitalWrite(STBY, HIGH);
  
}

void loop()
{
  digitalWrite(AIN1, HIGH);
  digitalWrite(AIN2, LOW);
  
  digitalWrite(BIN1, LOW);
  digitalWrite(BIN2, HIGH);
  pwmWrite(PWMA, 2768);
  pwmWrite(PWMB, 2768);
}
