#include "c1.h"
#include "global.h"


void c1::c1_func1()
{
  togglePin(33);
  delay(200);
}

void c1::c1_func2()
{
  digitalWrite(32, LOW);
}
