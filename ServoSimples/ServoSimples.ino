#include <Servo.h>
  Servo ombro;  
  Servo junta;  
  
void setup() {
  Serial.begin(9600);
  ombro.attach(10); 
  junta.attach(11);  
  initprogram();
}

int a, aux1, pos1 = 0;
int b, aux2, pos2 = 0, antombro, antjunta;
int comunica = 0;

void initprogram(void);


void loop() {

  comunica = Serial.read();
  delay(40);
  if((Serial.available()>1)&&(comunica)){
    //obtendo dados
     a = Serial.read();
     delay(25);
     b = Serial.read();
     delay(25);
ombro.write(a);
junta.write(b);
     }
}

void initprogram(){
  int au1 = pos1, au2 = pos2;
  
  for(au1 = pos1; au1!= 95; au1++){
    ombro.write(au1);
    delay(10);}

  for(au2 = pos2; au2!= 160; au2++){
      junta.write(au2);
      delay(10);}    
  pos1 = ombro.read();
  pos2 = junta.read();
    
}



