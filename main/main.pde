#include "global.h"

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

  pinMode(PWMLeft, PWM);
  pinMode(motorLeft1, OUTPUT);
  pinMode(motorLeft2, OUTPUT);
  pinMode(PWMRight, PWM);
  pinMode(motorRight1, OUTPUT);
  pinMode(motorRight2, OUTPUT);  
  pwmWrite(PWMLeft, 0);
  pwmWrite(PWMRight, 0);

  pinMode(encoderLeftCLK, INPUT);  //encoder clock pin
  pinMode(encoderLeftDirc, INPUT);  //encoder direction pin
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDirc, INPUT);

  //global interrupts for sensor
  Timer2.pause();
  Timer2.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72000 = 1kHz
  Timer2.setPeriod(sensorRate);                        // Set up period, 1period = 1 ms
  Timer2.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer4 is pin D16
  Timer2.setCompare(TIMER_CH1, 1);                     // Interrupt for every 1 update
  Timer2.attachCompare1Interrupt(globalInterrupt);     // the function that will be called
  Timer2.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer2.resume();                                     // Start the timer counting

  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);
}

/*===================  Interrput functions  =======================*/
void globalInterrupt(void)
{
  //Sensor
  sensor.runAllSensor();
  
  //Mapping motor handling


}

void encoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == LOW)
    status.wheelCountLeft++;
  else
    status.wheelCountLeft--;
}

void encoderRightInterrupts(void)
{
  if(digitalRead(encoderRightDirc) == LOW)
    status.wheelCountRight++;
  else
    status.wheelCountRight--;
}


/*=======================  Void Loop  =========================*/
void loop()
{
/*===================  one time instructions  =======================*/
  //initail setup
  if(initializeState==false)
   {
   //set map size
   cell[8][8].goal = true;   cell[8][9].goal = true;
   cell[9][8].goal = true;   cell[9][9].goal = true;
   
   status.initialize();
   maze.initialize();
   
   initializeState = true;
   }


/*===================  Encoder testing  =======================*/
  SerialUSB.print(status.wheelCountRight);
  SerialUSB.print("\t");
  SerialUSB.println(status.wheelCountLeft);


/*===================  Turnning test  =======================*/
/*
  while(status.frontRightDist > 5)
    motor.goStraight(5000);
  motor.stop();
  delay(1000);
    motor.turnLeft(3000);
*/

}






