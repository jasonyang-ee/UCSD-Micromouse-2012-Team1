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
  //attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);
}

/*===================  Interrput functions  =======================*/
int error = 0;
int last_errorr = 0;
int d_error = 0;
void globalInterrupt(void)
{
  //Sensor

  sensor.runAllSensor();
  
/*  
  if ( abs(abs(status.wheelCountLeft) - turnCount) != 0 )
  {
    last_errorr = error;
    error = turnCount - abs(status.wheelCountLeft);
    d_error = error - last_errorr; 
    motor.turnLeft(2000*(error) + 10*d_error/.001);
  }
  else
    motor.stop();
*/

  
 
  if (status.frontLeftDist > 10)
    {
      int correction = round(1000 * status.orientation+ .2*(status.orientation-d_error)/.001);
      motor.motorRight(10000 + correction);
      motor.motorLeft(10000 - correction);
      d_error = status.orientation;
    }
  else
    motor.stop();
    

  //Mapping motor handling

  //motor.applyMotorMapping();


}

void encoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)
    status.wheelCountLeft++;
  else
    status.wheelCountLeft--;
}

void encoderRightInterrupts(void)
{
  if(digitalRead(encoderRightDirc) == HIGH)
    status.wheelCountRight++;
  else
    status.wheelCountRight--;
}


/*=======================  Void Loop  =========================*/
void loop()
{
//SerialUSB.println(status.wheelCountLeft);
/*SerialUSB.print(status.diagonalRightDist);
SerialUSB.print("\t");
SerialUSB.println(status.diagonalLeftDist);*/

/*===================  one time instructions  =======================*/
/*
  //initail setup
  if(initializeState==false)
   {
     status.initialize();
     maze.initialize();
     initializeState = true;
   }


/*===================  Encoder testing  =======================*/

/*

  SerialUSB.print(status.wheelCountLeft);
  SerialUSB.print("\t");

  SerialUSB.print(status.wheelCountRight);
  SerialUSB.print("\t");
  SerialUSB.println(status.speedLeft);



/*===================  Sensor testing  =======================*/
/*
  status.printAll();

/*===================  Driving test  =======================*/
/*
  if(status.frontLeftDist > 5)
    motor.goStraight(driveSpeed);
  motor.stop();


/*===================  Turnning test  =======================*/
/*
  if(turn==false)
  {
    motor.turnLeft(turnSpeed);
    turn = true;
  }
*/

/*===================  FullSpeed test  =======================*/
/*
  int count = status.wheelCountLeft;
  
  if(status.wheelCountLeft - count < 5000)
    motor.goStraight(fullSpeed);
  else
    motor.stop();





/*===================  END  =======================*/
}






