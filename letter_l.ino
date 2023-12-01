#include<Servo.h>
#include<math.h>

Servo s1;
Servo s2;


float X[]={0,0.2500,0.5000,0.7500,1.0000,1.0000,1.2500,1.5000,1.7500,2.0000,2.0000,1.7500,1.5000,1.2500,1.0000,1.0000,1.0000,1.0000,1.0000,1.0000};
float Y[]={16.0000,15.7500,15.5000,15.2500,15.0000,15.0000,15.2500,15.5000,15.7500,16.0000,16.0000,15.7500,15.5000,15.2500,15.0000,15.0000,14.7500,14.5000,14.2500,14.0000};

float l1=9; //length of rod1
float l2=8; // lenght of rod2

int i=0;



void setup() {
  Serial.begin(9600);
  s1.attach(9);
  s2.attach(10);
  pinMode(13, OUTPUT);
  float init_x = X[0];
  float init_y = Y[0];
  float init_th2 = acos((init_x*init_x + init_y*init_y -l1*l1 -l2*l2)/(2*l1*l2));
  float init_th1 = atan2(init_y,init_x) -atan2(l2*sin(init_th2),l1 +l2*cos(init_th2));
  s1.write(init_th1*180/(M_PI));
  s2.write(init_th2*180/(M_PI)+90);
  digitalWrite(13,HIGH);
  delay(8000);
  digitalWrite(13,LOW);

  delay(500);
  // for Y shape i<20
  for(i=1;i<20;i++)
  {
    float x= X[i];
    float y= Y[i];
    float theta2 = acos((x*x +y*y -l1*l1 -l2*l2)/(2*l1*l2));
    float theta1 = atan2(y,x) -atan2(l2*sin(theta2),l1 +l2*cos(theta2));
    s1.write(theta1*180/(M_PI));
    s2.write(theta2*180/(M_PI)+90);
    // Serial.print("Theta 1: ");
    // Serial.print(theta1);
    // Serial.print("       Theta 2: ");
    // Serial.println(theta2);
    delay(500);
  }

  
}

void loop() {
  // put your main code here, to run repeatedly:




}
