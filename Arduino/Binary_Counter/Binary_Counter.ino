int led[4] = {6,7,8,9};
int count = 0;

void setup()
{
  for(int i=0; i<4; i++)
    pinMode(led[i],OUTPUT);
}

void loop()
{
  count = 0;
  while(count<16)
  {
    if(count%2==0)
      digitalWrite(led[0],LOW);
    else
      digitalWrite(led[0],HIGH);
    if(count%4==0)
      digitalWrite(led[1],LOW);
    else
      digitalWrite(led[1],HIGH);
    if(count%8==0)
      digitalWrite(led[2],LOW);
    else
      digitalWrite(led[2],HIGH);
    if(count%16==0)
      digitalWrite(led[3],LOW);
    else
      digitalWrite(led[3],HIGH);
   count = count+1;  
  }
}
