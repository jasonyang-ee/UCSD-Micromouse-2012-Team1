const int PWMA = 15;
const int AIN2 = 21;
const int AIN1 = 22;

const int BIN1 = 25;
const int BIN2 = 26;
const int PWMB = 27;

void setup()
{
  pinMode(PWMA, PWM);
  pinMode(AIN2, OUTPUT);
  pinMode(AIN1, OUTPUT);
  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);  
  pinMode(PWMB, PWM);
  
}

void loop()
{
  digitalWrite(AIN1, HIGH);
  digitalWrite(AIN2, LOW);
  
  digitalWrite(BIN1, LOW);
  digitalWrite(BIN2, HIGH);
  pwmWrite(PWMA, 640000);
  pwmWrite(PWMB, 640000);
  
  delay (2000);
  
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, HIGH);
  
  digitalWrite(BIN1, HIGH);
  digitalWrite(BIN2, LOW);
  pwmWrite(PWMA, 640000);
  pwmWrite(PWMB, 640000);
  
  delay(3000);
  
  pwmWrite(PWMA, 0);
  pwmWrite(PWMB, 0);
  
  delay(2000);
}
