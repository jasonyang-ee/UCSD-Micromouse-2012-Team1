
#include "motor.h"

/*=======================================================  PID  =======================================================*/
/* PID has a lot of stuff in it. things to note: both modeStraight, modeRotate, and modeTurn have subscenarios within them
that must be changed by setting status.scenario(Straight)(Rotate)(Turn). */
void Motor::PID()
{
	switch (status.mode)
	{
		case modeStop: 
		stop(); break;
		
		case modeDecelerate:
		decelerate(); break;
		
		case modeStraight:
		{
			switch(status.scenarioStraight)
			{
				case followBoth:
				{
					//Gain values for PID
					int Kp = 800;
					int Kd = 130;
					int Ki = 20;
					
					//Correction value from PID
					int correction = round(Kp * status.errorDiagonal + Kd*(status.errorDiagonalDiff)/.001 + Ki*status.errorDiagonalTotal);
					/*suitable for 20,000: int correction = round(1500 * status.errorDiagonal + 200*(status.errorDiagonalDiff)/.001 + 35*status.errorDiagonalTotal);*/
					
					//positive correction corresponds to a left error, negative correction corresponds to a right error
					motor.motorRight(status.speedBase + correction);
					motor.motorLeft(status.speedBase - correction);            
					status.errorDiagonalDiffLast = status.errorDiagonalDiff;
					break;
				}  
				
				case followRight:
				{
					//Gain values for PID
					int Kp = 1000;
					int Kd = 5;
					int correction = round(Kp*status.errorRight + (Kd*(status.errorRightDiff)/(.001)));
					motorRight(status.speedBase + correction);
					motorLeft(status.speedBase - correction); 
					break;
				}
				
				case followLeft: 
				{
					//Gain values for PID
					int Kp = 1000;
					int Kd = 5;
					
					//Correction value from PID
					int correction = round(Kp*status.errorLeft + (Kd*(status.errorLeftDiff)/(.001)));
					
					motorRight(status.speedBase + correction);
					motorLeft(status.speedBase - correction); 
					break;				
				}
				case fishBone: 
				{
					status.errorCountDiff = status.errorCountLeft - status.errorCountRight;
					if(status.distSideLeft > distWallExist || status.distSideRight > distWallExist)
					{
						int correction = round(400*(status.errorCountDiff)/.001);
						motorRight(status.speedBase + correction);
						motorLeft(status.speedBase - correction);
					}
					else
					{
					if(status.distSideLeft - status.distSideLeftLast > 4)  status.countStampLeft = status.countLeft;
					if(status.distSideRight - status.distSideRightLast > 4)  status.countStampRight = status.countRight;
					if(status.countStampLeft!=0 && status.countStampRight!=0)
					{
						int correction = round(400*abs(status.countStampLeft-status.countStampRight)/.001);
						motorRight(status.speedBase + correction);
						motorLeft(status.speedBase - correction);
					}
					}
					status.countLeftLast = status.countLeft;
				}
				
				default: motor.stop(); break;
			}
			break;
		}
		
		
		case modeRotate:
		{
			//initialization of errors
			status.errorCountLeftLast = status.errorCountLeft;
			status.errorCountRightLast = status.errorCountRight;
			status.errorCountLeft = countRotateSide  - abs(status.countLeft);
			status.errorCountRight = countRotateSide - abs(status.countRight);
			
			//Initialization of PID values
			int Kp = 150;
			int Kd =120;
			int Ki = 10;
			
			switch (status.scenarioRotate)
			{
				case left: 
				{
					
					if (status.tick < 10000) //&& status.errorCountRight != 0)
					{
						//only uses the integration value while within 10% of the setpoint value to avoid integral windup
						if (abs(status.errorCountLeft) < countRotateSide/10)
							status.errorCountLeftTotal += status.errorCountLeft;
						else
							status.errorCountLeftTotal = 0;
						
						
						status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
						status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
						int correctionLeft = round(Kp*status.errorCountLeft + Kd*status.errorCountLeftDiff);// + Ki*status.errorCountLeftTotal);
						int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);
						
						//apply PID control over both motors to ensure rotation about center axis
						motor.motorRight(correctionRight);
						motor.motorLeft(-correctionLeft);
						//status.tick = correction;
						//as long as 
						
						if (abs(status.errorCountLeft) < 10)
						status.tick++;
						else
						status.tick = 0;
						
						
					}					
					else
					{
						// togglePin(33);
						motor.motorRight(0);
						motor.motorLeft(0);
						//motor.stop();
					}
					break;
				}
				
				case right:
				{
					if (status.tick < 10000) //&& status.errorCountRight != 0)
					{
						if (abs(status.errorCountRight) < countRotateSide/10)
						status.errorCountRightTotal += status.errorCountRight;
						else
						status.errorCountRightTotal = 0;
						
						status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
						status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
						int correctionLeft = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);// + Ki*status.errorCountLeftTotal);
						int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);
						motor.motorRight(-correctionRight);
						motor.motorLeft(correctionLeft);
						
						//as long as 
						
						if (status.errorCountRight == status.errorCountRightLast )
						status.tick++;
						else
						status.tick = 0;
						
						
					}
					else
					{
						//        togglePin(33);
						motor.motorRight(0);
						motor.motorLeft(0);
						//motor.stop();
					}				
					break;
				}
				case back: 
				{
					status.errorCountLeftLast = status.errorCountLeft;
					status.errorCountRightLast = status.errorCountRight;
					status.errorCountLeft = countRotateBack - abs(status.countLeft);
					status.errorCountRight = countRotateBack - abs(status.countRight);
					if (status.tick < 10000)
					{
						if (abs(status.errorCountLeft) < countRotateBack/10)
						status.errorCountLeftTotal += status.errorCountLeft;
						else
						status.errorCountLeftTotal = 0;
						
						status.errorCountRightDiff = status.errorCountRight - status.errorCountRightLast;
						status.errorCountLeftDiff = status.errorCountLeft - status.errorCountLeftLast;
						int correctionLeft = round(Kp * status.errorCountLeft + Kd * status.errorCountLeftDiff);// + Ki*status.errorCountLeftTotal);
						int correctionRight = round(Kp * status.errorCountRight + Kd * status.errorCountRightDiff);
						motor.motorRight(correctionRight);
						motor.motorLeft(- correctionLeft);
						
						//as long as 
						
						if (status.errorCountLeft == status.errorCountLeftLast )
						status.tick++;
						else
						status.tick = 0;
					}
					else
					{
						//        togglePin(33);
						motor.motorRight(0);
						motor.motorLeft(0);
						motor.stop();
					}					
					break;
				}
				//default: motor.stop();break;
			}
			break;
		}
	}
}

/*=======================================================  stop  =======================================================*/
void Motor::stop()
{ 
	//if( status.angularVelocityRight == 0 && status.angularVelocityLeft == 0) //might need to change this later
	if(status.speedLeft == 0 && status.speedRight == 0)
	{
		motorLeft(0);  motorRight(0);          //set motor=0
		status.mode = modeStop;                //set modd
		status.speedBase = 0;
	}
	else
	decelerate();                        //start decelerate
}

void Motor::decelerate()
{
	if( abs(status.speedLeft) > 1 && abs(status.speedRight) > 1)
	{ 
		status.mode = modeDecelerate;
		int tempL = status.speedLeft * -0.995;
		int tempR = status.speedRight * -0.995;
		motorLeft(tempL);                     //set opposite speed
		motorRight(tempR);                    //set opposite speed
		status.speedLeft *= -1;
		status.speedRight *= -1;
		
		
	}
	if(status.angularVelocityLeft == 0 && status.angularVelocityRight == 0) //might need to change this too
	status.mode = modeStop;
}

/* The following functions set the mode and scenario for PID control
	
	
*/
/*=======================================================  go  =======================================================*/
void Motor::goStraight(int speed)
{
	//Error Initializations
	status.errorDiagonalTotal=0;
	status.errorSideTotal=0;
	status.errorFrontTotal=0;
	
	//Encoder initialization
	status.countRight = 0;
	status.countLeft = 0;
	
	//mode set
	status.mode = modeStraight;          
    
	//speed set
	motorRight(speed);  motorLeft(speed);
	status.speedBase = speed;
}

//Moves forward one cell
void Motor::goStraightOne (int speed)
{
	//Error Initializations
	status.errorDiagonalTotal=0;
	status.errorSideTotal=0;
	status.errorFrontTotal=0;
	
	//mode set
	status.mode = modeStraight;
	
	//Encoder Initialization
	status.countRight = 0;
	status.countLeft = 0;
	
	goStraight(speed);
	
	//how does this even work?
	if((status.countLeft)/2 > countCell)   //stop after one cell
	stop();
}

/*=======================================================  rotate  =======================================================*/
void Motor::rotateLeft()
{
	//mode set
	status.mode = modeRotate;                				
	//scenario set
	status.scenarioRotate = left;
	
	//Encoder Initialization
	status.countLeft = 0;
	status.countRight = 0;	
	
	//Encoder Error Initialization
	status.errorCountLeft = 0;
	status.errorCountRight = 0;
	
	//tick initialization, used to ensure system is within error margin
	status.tick = 0;
	status.compass = (status.compass+west) % 4;   		//set compass
}

void Motor::rotateRight()
{
	status.mode = modeRotate;                				//set mode
	status.scenarioRotate = right;
	status.countLeft = 0;
	status.countRight = 0;
	status.errorCountLeft = 0;
	status.errorCountRight = 0;
	status.tick = 0;
	status.compass = (status.compass+east) % 4;        	//set compass
}
void Motor::rotateBack()
{
	status.mode = modeRotate;                				//set mode
	status.scenarioRotate = back;
	status.countLeft = 0;
	status.countRight = 0;
	status.errorCountLeft = 0;
	status.errorCountRight = 0;
	status.tick = 0;
	status.compass = (status.compass+south) % 4;        	//set compass
}

/*=======================================================  turn  =======================================================*/
void Motor::turnLeft(int speed)
{
	status.errorDiagonalTotal=0;
	status.errorSideTotal=0;
	status.errorFrontTotal=0;
	status.mode = modeTurn;                  		//set mode
	status.compass = (status.compass+3)%4;        //set compass
}

void Motor::turnRight(int speed)
{
	status.errorDiagonalTotal=0;
	status.errorSideTotal=0;
	status.errorFrontTotal=0;
	status.mode = modeTurn;                  		//set mode
	status.compass = (status.compass+1)%4;        //set compass 
}

/*
	The following functions provide raw motor control; positive values set the motors forward, while negative values set the motors backward 
*/
/*=======================================================  motor  =======================================================*/
void Motor::motorLeft(int speed)
{
	status.speedLeft = speed;
	if(speed == 0)                    //stop
	{
		digitalWrite(motorLeft1, LOW);
		digitalWrite(motorLeft2, LOW);
		//pwmWrite(PWMLeft, 0);           //set speed
	}
	else if(speed > 0)                //forward
	{
		digitalWrite(motorLeft1, HIGH);
		digitalWrite(motorLeft2, LOW);
		//pwmWrite(PWMLeft, status.speedLeft);		
		//pwmWrite(PWMLeft, speed);
	}
	else                              //backward
	{
		digitalWrite(motorLeft1, LOW);
		digitalWrite(motorLeft2, HIGH);
		//pwmWrite(PWMLeft, -speed);		
		//pwmWrite(PWMLeft, -status.speedLeft);  //set speed	
	}
	
	int absspeed = abs(speed);
	if (absspeed < speedFull)
	pwmWrite(PWMLeft, absspeed);
	else
	pwmWrite(PWMLeft, speedFull); // preserves sign
	
}

void Motor::motorRight(int speed)
{
	status.speedRight = speed;
	
	if(speed == 0)                    //stop
	{
		digitalWrite(motorRight1, LOW);
		digitalWrite(motorRight2, LOW);
		//pwmWrite(PWMRight, 0);          //set speed
	}
	else if(speed > 0)                //forward
	{
		digitalWrite(motorRight1, HIGH);
		digitalWrite(motorRight2, LOW);
		//pwmWrite(PWMRight, speed);	
		//pwmWrite(PWMRight, status.speedRight);      //set speed		
		
	}
	else                              //backward
	{
		digitalWrite(motorRight1, LOW);
		digitalWrite(motorRight2, HIGH);
		//pwmWrite(PWMRight, -speed);		
		//pwmWrite(PWMRight, -(status.speedRight)); //set speed
	}
	
	int absspeed = abs(speed);
	if (absspeed < speedFull)
	pwmWrite(PWMRight, absspeed);         //save current speed
	else
	pwmWrite(PWMRight, speedFull);
	
}


