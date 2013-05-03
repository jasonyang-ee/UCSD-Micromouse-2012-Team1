#include "global.h"


void setup()
{
/*=======================================================  pin setup  =======================================================*/
  pinMode(sensorFrontLeft,INPUT_ANALOG);      //int sensorFrontLeft
  pinMode(sensorFrontRight,INPUT_ANALOG);     //int sensorFrontRight
  pinMode(sensorDiagonalLeft,INPUT_ANALOG);   //int sensorDiagonalLeft
  pinMode(sensorDiagonalRight,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(sensorSideLeft,INPUT_ANALOG);       //int sensorSideLeft
  pinMode(sensorSideRight,INPUT_ANALOG);      //int sensorSideRight

  pinMode(ledOne,OUTPUT);    //int led
  pinMode(ledTwo,OUTPUT);    //int led
  pinMode(ledThree,OUTPUT);  //int led

  pinMode(PWMLeft, PWM);
  pinMode(motorLeft1, OUTPUT);
  pinMode(motorLeft2, OUTPUT);
  pinMode(PWMRight, PWM);
  pinMode(motorRight1, OUTPUT);
  pinMode(motorRight2, OUTPUT);  
  pwmWrite(PWMLeft, 0);
  pwmWrite(PWMRight, 0);

  pinMode(encoderLeftCLK, INPUT);    //encoder clock pin
  pinMode(encoderLeftDirc, INPUT);   //encoder direction pin
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDirc, INPUT);

/*=======================================================  Interrupts  =======================================================*/
  Timer2.pause();                                      // to set timer clock, please go global.h to change timerRate
  Timer2.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72 = 1MHz, counter++ for every 1us
  Timer2.setOverflow(timerRate);                       // Set period = timerRate * 1us
  Timer2.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer2 is pin D11
  Timer2.setCompare(TIMER_CH1, 1);                     // Interrupt at counter = 1
  Timer2.attachCompare1Interrupt(globalInterrupt);     // the function that will be called
  Timer2.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer2.resume();                                     // Start the timer counting

  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
//  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);  //broken encoder
  
/*=======================================================  Initialize  =======================================================*/
  status.initialize();
  maze.initialize();
}

void globalInterrupt(void)
{
  //sensor
  sensor.runAllSensor();

  //apply PID
  motor.PID();
}

void encoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)  status.countLeft++;
  else  status.countLeft--;
}

void encoderRightInterrupts(void)
{
  if(digitalRead(encoderRightDirc) == HIGH)  status.countRight++;
  else  status.countRight--;
}


void loop()
{
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
/*===================  Encoder print  =======================*/
/*
  SerialUSB.print(status.wheelCountLeft);
  SerialUSB.print("\t");

  SerialUSB.print(status.wheelCountRight);
  SerialUSB.print("\t");
  SerialUSB.println(status.speedLeft);
*
/*=======================================================  End  =======================================================*/
}






