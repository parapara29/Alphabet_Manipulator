#include<Servo.h>

Servo s;
Servo s2;

void setup() {
  Serial.begin(9600);
  // put your setup code here, to run once:
  s.attach(9);
  s2.attach(10);

  pinMode(A0,INPUT);
  pinMode(A5,INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
    float val2 = analogRead(A5);
    float feed2 = 0.33898*(val2-64);
    s.write(feed2);
    float val = analogRead(A0);
    float feed = 0.33898*(val-64);
    s2.write(feed);
}
