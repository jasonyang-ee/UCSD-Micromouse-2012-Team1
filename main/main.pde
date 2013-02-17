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
  pinMode(STBY, OUTPUT);
  digitalWrite(STBY, HIGH);
  
  pinMode(encoderLeftCLK, INPUT);
  pinMode(encoderLeftDirc, INPUT);
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDirc, INPUT);

  //global interrupts for sensor
  Timer4.pause();
  Timer4.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72000 = 1kHz
  Timer4.setPeriod(sensorRate);                        // Set up period, 1period = 1 ms
  Timer4.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer4 is pin D16
  Timer4.setCompare(TIMER_CH1, 1);                     // Interrupt for every 1 update
  Timer4.attachCompare1Interrupt(sensorInterrupt);     // the function that will be called
  Timer4.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer4.resume();                                     // Start the timer counting
  
  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);

}

/*===================  Interrput functions  =======================*/
void sensorInterrupt(void)
{
  //push back current status to old status array
  for (int i=9; i>0; i--)
    oldStatus[i] = oldStatus[i-1];
  oldStatus[0] = status;
  //update current status
  sensor.runAllSensor();
}

void encoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)
    status.leftWheelCount++;
  else
    status.leftWheelCount--;
}

void encoderRightInterrupts(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)
    status.rightWheelCount++;
  else
    status.leftWheelCount--;
}
/*===================  End Interrput functions  =======================*/

void loop()
{
  //initialize for the beginning
  if(initialize == false)
  {
    maze.initialize();
    status.initialize();
    initialize = true;
  }
  
  //slow donw for a wall
  if(status.frontDist < 100)
    motor.driveStraight(fullSpeed/500);
  
  //if path on right turn right and update compass
  if(status.currentCell.wall[1]==false)
  {
    while(status.currentCell.wall[0]==true)
      motor.driveRight(fullSpeed/500);
    status.compass = (status.compass+1) % 4;
  }

  //if path on left turn left and update compass
  if(status.currentCell.wall[3]==false)
  {
    while(status.currentCell.wall[0]==true)
      motor.driveLeft(fullSpeed/500);
    status.compass = (status.compass+3) % 4;
  }
  
  //if no wall in front then go straight
  if(status.currentCell.wall[0]==false)
    motor.driveStraight(fullSpeed/100);
  
  //if no path in front then stop
  if(status.currentCell.wall[0]==true)
    motor.stop();
  
  //if dead end then turn back and update compass
  if(status.currentCell.wall[0]==true && status.currentCell.wall[1]==true
    && status.currentCell.wall[3]==true)
  {
    while(abs(status.sideLeftDist-status.sideRightDist)>50)
      motor.turnBack();
    status.compass = (status.compass+2) % 4;
  }
    
    
    
    
  //if dist count % 14 == 0, cell++  (14 counts gives 18cm if 1 rotate = 150 counts)
}
  




