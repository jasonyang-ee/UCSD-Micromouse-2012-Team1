#include "global.h"

void setup()
{
  //pin setup
  pinMode(encoderLeftCLK, INPUT);  //encoder clock pin
  pinMode(encoderLeftDirc, INPUT);  //encoder direction pin
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDirc, INPUT);

  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);
}


/*===================  Interrput functions  =======================*/
void encoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)
    status.wheelCountLeft++;
  else
    status.wheelCountLeft--;
}

void encoderRightInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)
    status.wheelCountRight++;
  else
    status.wheelCountRight--;
}



void loop()
{
  status.printAll();
}
