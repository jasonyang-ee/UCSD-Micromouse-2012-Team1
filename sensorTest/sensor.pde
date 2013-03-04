#include "sensor.h"

void Sensor::runAllSensor()
{ 
  FL = (runSensor(sensorFrontLeft));
  FR = (runSensor(sensorFrontRight));
  SL = (runSensor(sensorSideLeft));
  SR = (runSensor(sensorSideRight));
  DL = (runSensor(sensorDiagonalLeft));
  DR = (runSensor(sensorDiagonalRight));
  
  SerialUSB.print("avtive Voltage:\n");
  SerialUSB.print("SL \tDL \tFL \tFR \tDR \tSR\n");
  SerialUSB.print(SL);
  SerialUSB.print("\t");
  SerialUSB.print(DL);
  SerialUSB.print("\t");
  SerialUSB.print(FL);
  SerialUSB.print("\t");
  SerialUSB.print(FR);
  SerialUSB.print("\t");
  SerialUSB.print(DR);
  SerialUSB.print("\t");
  SerialUSB.print(SR);
  SerialUSB.print("\n");
  
  SerialUSB.print("dark Voltage:\n");
  SerialUSB.print("SL \tDL \tFL \tFR \tDR \tSR\n");
  SerialUSB.print(SL);
  SerialUSB.print("\t");
  SerialUSB.print(DL);
  SerialUSB.print("\t");
  SerialUSB.print(FL);
  SerialUSB.print("\t");
  SerialUSB.print(FR);
  SerialUSB.print("\t");
  SerialUSB.print(DR);
  SerialUSB.print("\t");
  SerialUSB.print(SR);
  SerialUSB.print("\n\n");

  delay(500);
}




double Sensor::runSensor(int sensorRef)
{


  voltageTemp = analogRead(sensorRef);
  delay(1);

  return voltageTemp;
}
