#include "global.h"

void setup()
{
  //pin setup
  pinMode(6,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(5,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(7,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(4,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(8,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(3,INPUT_ANALOG);  //int sensorSideRight
  
  pinMode(14,OUTPUT);  //int led
  pinMode(13,OUTPUT);  //int led
  pinMode(12,OUTPUT);  //int led
  
  pinMode(28,OUTPUT);  //int motorLeft+
  pinMode(29,OUTPUT);  //int motorLeft-
  pinMode(30,OUTPUT);  //int motorRight+
  pinMode(31,OUTPUT);  //int motorRight-

  //global interrupts for sensor
  Timer4.pause();
  Timer4.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72000 = 1kHz
  Timer4.setPeriod(sensorRate);                        // Set up period, 1period = 1 ms
  Timer4.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer4 is pin D16
  Timer4.setCompare(TIMER_CH1, 1);                     // Interrupt for every 1 update
  Timer4.attachCompare1Interrupt(interruptFunction);   // the function that will be called
  Timer4.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer4.resume();                                     // Start the timer counting
}

void loop()
{

}
  
void interruptFunction(void)
{
  sensor.runAllSensor();
}






