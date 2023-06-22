#include <Arduino.h>   
#include "MHZ19.h"
#include <SoftwareSerial.h>                                // Remove if using HardwareSerial

#define RX_PIN 10                                          // Rx pin which the MHZ19 Tx pin is attached to
#define TX_PIN 11                                          // Tx pin which the MHZ19 Rx pin is attached to
#define BAUDRATE 9600                                      // Device to MH-Z19 Serial baudrate (should not be changed)

MHZ19 myMHZ19;                                             // Constructor for library
SoftwareSerial mySerial(RX_PIN, TX_PIN);                   // (Uno example) create device to MH-Z19 serial

unsigned long getDataTimer = 0;

const int cal_pin = 13;  // entrada pulsador calibración
unsigned long timeElapse = 0;

void setup()
{
  Serial.begin(9600);                                     // Device to serial monitor feedback

  mySerial.begin(BAUDRATE);                               // (Uno example) device to MH-Z19 serial start
  myMHZ19.begin(mySerial);                                // *Serial(Stream) refence must be passed to library begin().

  myMHZ19.autoCalibration(false);                              // Turn auto calibration ON (OFF autoCalibration(false))

  pinMode(cal_pin, INPUT_PULLUP); // entrada pulsado para calibrar, seteada como pulluppara poder conectar pulsador sin poenr resistencia adicional

 delay(60000);// Demora 1 min en enviar datos para calentar el sensor
}

void loop()
{

   if (digitalRead(cal_pin) == LOW) {  // si detecta el botón de calibrar apretado, calibra
      calibrar();
  }  
  if (millis() - getDataTimer >= 5000)
  {
    int CO2;

    /* note: getCO2() default is command "CO2 Unlimited". This returns the correct CO2 reading even
      if below background CO2 levels or above range (useful to validate sensor). You can use the
      usual documented command with getCO2(false) */

    CO2 = myMHZ19.getCO2();                             // Request CO2 (as ppm)

    //Serial.print("CO2 (ppm): ");
    Serial.print(getDataTimer);
    Serial.print(" ");
    Serial.print (CO2);
    Serial.println();

    /*int8_t Temp;
    Temp = myMHZ19.getTemperature();                     // Request Temperature (as Celsius)
    Serial.print("Temperature (C): ");
    Serial.println(Temp);*/

    getDataTimer = millis();
  }
}

void calibrar()
{
    int CO2Background ;
    CO2Background=myMHZ19.getBackgroundCO2();
    Serial.println("Concentracion de background:");
    Serial.println(CO2Background);
    Serial.println("ABC Status: "); myMHZ19.getABC() ? Serial.println("ON") :  Serial.println("OFF");  // now print it's status
    
    
    Serial.println("Waiting 20 minutes to stabalise...");
   /* if you don't need to wait (it's already been this amount of time), remove the next 2 lines */
    timeElapse = getDataTimer+12e5;                    //  20 minutes in milliseconds
    while(millis() < timeElapse) {};      //  wait this duration

    Serial.println("Calibrating..");
    myMHZ19.calibrate();    // Take a reading which be used as the zero point for 400 ppm 
}
