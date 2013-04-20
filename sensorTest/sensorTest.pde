#include "global.h"

void sensorInterrupt(void);

void setup()
{
  //pin setup
  pinMode(sensorFrontLeft,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(sensorFrontRight,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(sensorDiagonalLeft,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(sensorDiagonalRight,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(sensorSideLeft,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(sensorSideRight,INPUT_ANALOG);  //int sensorSideRight
  
  pinMode(ledOne,OUTPUT);  //int led
  pinMode(ledTwo,OUTPUT);  //int led
  pinMode(ledThree,OUTPUT);  //int led

  //global interrupts for sensor
  Timer2.pause();
  Timer2.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72000 = 1kHz
  Timer2.setPeriod(sensorRate);                        // Set up period, 1period = 1 ms
  Timer2.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer2 is pin D11
  Timer2.setCompare(TIMER_CH1, 1);                     // Interrupt for every 1 update
  Timer2.attachCompare1Interrupt(sensorInterrupt);     // the function that will be called
  Timer2.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer2.resume();                                     // Start the timer counting

  digitalWrite(ledOne, HIGH);
  digitalWrite(ledTwo, HIGH);
  digitalWrite(ledThree, HIGH);
}

/*===================  Interrput functions  =======================*/

void sensorInterrupt(void)
{
  if(printing == false)
  {
    sensor.runAllSensor();
    printing = true;
  }
}



void loop()
{
  delay(100);
  if(printing == true)
  {
    status.printAll();
    printing = false;
  }
}

