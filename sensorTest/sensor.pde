void Sensor::runAllSensor()
{ 
  int frontReading[3];
  frontReading[1] = runSensor(sensorFrontLeft);
  frontReading[2] = runSensor(sensorFrontRight);
  frontReading[0] = frontReading[1]<frontReading[2] ? frontReading[1] : frontReading[2];
  
  status.frontVolt = frontReading[0];
  SL = (runSensor(sensorSideLeft));
  SR = (runSensor(sensorSideRight));
  DL = (runSensor(sensorDiagonalLeft));
  DR = (runSensor(sensorDiagonalRight));
  
  SerialUSB.print("avtive Voltage:\n");
  SerialUSB.print("SL \tDL \tFL \tFR \tDR \tSR\n");
  SerialUSB.print("%lf \t%lf \t%lf \t%lf \t%lf \t%lf\n", );
  SerialUSB.print("\tdark Voltage = ");
  SerialUSB.print("SL \tDL \tFL \tFR \tDR \tSR\n");
  SerialUSB.print("%lf \t%lf \t%lf \t%lf \t%lf \t%lf\n", );

  delay(500);
}




int Sensor::runSensor(int sensorRef)
{
  //obtain dark voltage with IR turned off
  digitalWrite(ledOne, LOW);
  digitalWrite(ledTwo, LOW);
  digitalWrite(ledThree, LOW);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);   //read voltage
    idleVoltage += voltageTemp;            //sum all the voltage reading
    delay(sampleRate);
  }
  idleVoltage /= sampleNum;                //get average reading
  
  //obtain active voltage with IR turned on
  togglePin(ledOne);
  togglePin(ledTwo);
  togglePin(ledThree);
  for(int i=0; i<sampleNum; i++)
  {
    voltageTemp = analogRead(sensorRef);    //read voltage
    activeVoltage += voltageTemp;           //sum all the voltage reading
    delay(sampleRate);
  }
  activeVoltage /= sampleNum;                     //get average reading
  resultVoltage = activeVoltage - idleVoltage;    //get result of difference between dark and active voltage
  return convertDistance(activeVoltage);
}
