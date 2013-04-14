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
  Timer2.attachCompare1Interrupt(sensorInterrupt);     // the function that will be called
  Timer2.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer2.resume();                                     // Start the timer counting


  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);
}

/*===================  Interrput functions  =======================*/
void sensorInterrupt(void)
{
  sensor.runAllSensor();
  
  //
  
  
  int scenario;

  switch (scenario)
  {
    case 1: //straightaway, walls on both left and right side
      if (status.frontRightDist > 5 && (status.diagonalRightDist < 5 && status.diagonalLeftDist < 5))
        motor.goStraight (5000);
      else
      {
        //need a function here to cruise into the middle of the cell or soemthing, idk
        //from there, jump to scenario -1
        //scenario = -1;
      }
      break;
    case 2:	// left turn
                //modify turnLeft to keep turning, bring the if statement here;
                //since global interupt runs every millisecond, and turning left takes longer than that
      if (status.wheelCountLeft < turnCount)
        motor.turnLeft (5000); 
      else
      {
        motor.stop();
        scenario = -1;			
      }
      break;
    case 3: // right turn
            //same as above
      if (status.wheelCountLeft < turnCount)
        motor.turnRight (5000);
      else
      {
        motor.stop();
        scenario = -1;
      }
      break;
    case 4: //180 Degree Turn
      if (status.wheelCountLeft < UturnCount)
        motor.turnRight (5000);
      else
      {
        motor.stop();
        scenario = -1;
      }
      break;
    case 5: //floodfill?
            //floodfill();
      break;
    default:
            // checks front to see that there's no wall there, and the left/right diagonals to be sure there are walls there
      if (status.frontRightDist > 5 && (status.diagonalRightDist < 5 && status.diagonalLeftDist < 5))  
        scenario = 1;
            //also need a scenario to like... drive up to the middle of a cell without wobbling.
            //right/left diagonals will flag higher than 5 before the mouse actually gets into the cell
      else
      {
        if (status.sideRightDist > 5)
          scenario = 3;
        else if (status.sideLeftDist > 5)
          scenario = 2;
        else 
          scenario = 4;
      }
  }
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

void loop()
{
  while(status.frontRightDist > 5)
    motor.goStraight(5000);
  motor.stop();
  delay(1000);  
    motor.turnLeft(3000);
  /*
  if (check == false)
   {
   motor.turnRight(5000);
   check = true;
   }
   else
   motor.stop();
   motor.stop();
   */


  /*
  SerialUSB.print(status.rightFrontDist);
   SerialUSB.print("\t");
   SerialUSB.print(status.diagonalLeftDist);
   SerialUSB.print("\t");
   SerialUSB.print(status.diagonalRightDist);
   SerialUSB.println("\t");
   */


/*  if(status.rightFrontDist > 5)
    motor.goStraight(5000);
  else
    motor.stop();
  */  
  /*
  SerialUSB.print(status.wheelCountRight);
   SerialUSB.print("\t");
   SerialUSB.println(status.wheelCountLeft);
   */

  /*===================  one time instructions  =======================*/
  //initail setup
  /*
  if(initializeState==false)
   {
   //set map size
   cell[8][8].goal = true;   cell[8][9].goal = true;
   cell[9][8].goal = true;   cell[9][9].goal = true;
   
   status.initialize();
   maze.initialize();
   
   initializeState = true;
   }
   */
  /*
  //mapping
   if(mappingState==false)
   {
   maze.mapping();
   mappingState = true;
   }
   */


}






