#include "blink.h"

void blinking::run()
{
  digitalWrite(10, HIGH);        // Turn the LED from off to on, or on to off
  delay(1000);          // Wait for 1 second (1000 milliseconds)
}
