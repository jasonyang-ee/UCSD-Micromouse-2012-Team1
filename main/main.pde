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

  pinMode(PWMLeft, PWM);          //PWM control of Left Motor
  pinMode(motorLeft1, OUTPUT);    //direction control of Left Motor
  pinMode(motorLeft2, OUTPUT);    //direction control of Left Motor
  pinMode(PWMRight, PWM);         //PWM control of Right Motor
  pinMode(motorRight1, OUTPUT);   //direction control of Right Motor
  pinMode(motorRight2, OUTPUT);   //direction control of Right Motor
  pwmWrite(PWMLeft, 0);           //initialize speed of 
  pwmWrite(PWMRight, 0);          //both motors to 0

  pinMode(encoderLeftCLK, INPUT);    //Left encoder clock pin
  pinMode(encoderLeftDirc, INPUT);   //Left encoder direction pin
  pinMode(encoderRightCLK, INPUT);	 //Right encoder clock pin
  pinMode(encoderRightDirc, INPUT);	 //Right encoder direction pin

  for (int i = 0; i < 100; i++)
    sensor.runAllSensor();
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
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);  
  
/*=======================================================  Initialize  =======================================================*/
  status.initialize();
  maze.initialize();
  
  //status.mode = modeStraight;
  //status.scenarioStraight = fishBone;
  //status.scenarioStraight = followBoth;
  //motor.goStraight(10000);
	motor.rotateLeft();
//	motor.rotateRight();
	//motor.rotateBack();
  
//  status.mode = modeRotate; 
//  status.scenarioRotate = left;

}

/* Encoder Interrupts */
void encoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)  status.countLeft++;
  else  status.countLeft--;
}

void encoderRightInterrupts(void)
{
  if(digitalRead(encoderRightDirc) == LOW)  status.countRight++;
  else  status.countRight--;
}


int j = 0;
void globalInterrupt(void)
{
  /*--------------------------------------------------------------
  runAllSensor: reads distance, converte all raw data
    - error from distance
    - angularVelocity
    - converted error sum, error diff
  --------------------------------------------------------------*/
  sensor.runAllSensor();

  /*--------------------------------------------------------------
  PID: continue run motor base on given drive instruction
    - run until the instruction finished, and stop the mouse
    - stop then wait for next instruction
  --------------------------------------------------------------*/
  /*
  if(status.distFront < distWallExist)  
    motor.stop();
  */
  //if (status.countLeft < countCell)
   motor.PID();
 /* else
  {    
    motor.stop();

  /*--------------------------------------------------------------
  mapping: traverse back to the straight path and update wall info
    - use encoder to know #'s of cell, and update those wall info
    - reset encoder
    - set modeWait
  --------------------------------------------------------------*/
//  if(status.mode == modeStop)  maze.mapping();
  
  /*--------------------------------------------------------------
  decide: determine the next path to go after mapping
    - give motor instruciton
  --------------------------------------------------------------*/
//  if(status.mode == modeWait)  maze.decide();
  
}

void loop()
{

SerialUSB.print(status.errorCountLeft);
SerialUSB.print("\t");
SerialUSB.println(status.tick);

	/*
	SerialUSB.print(status.speedLeft);
	SerialUSB.print("\t");
	SerialUSB.println(status.speedRight);
	*/
	
/*===================  Encoder print  =======================*/
/*if(isButtonPressed())
//{
  SerialUSB.print(status.countLeft);
  SerialUSB.print("\t");

  SerialUSB.print(status.countRight);
  SerialUSB.println("\t");
//}
//  SerialUSB.println(status.speedLeft);

/*=======================================================  End  =======================================================*/
/*
SerialUSB.print(status.distFrontRight);
SerialUSB.print("\t");
SerialUSB.println(status.distFrontLeft);
*/
//SerialUSB.println(status.distDiagonalLeft);
}










