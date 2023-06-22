#include <Arduino.h>   
#include "MHZ19.h"
#include <SoftwareSerial.h>                                // Remove if using HardwareSerial
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>
#include <DS18B20.h>

/////////////////////////////////////
// MHZ19 Define pines comunicacion MHZ19
#define RX_PIN 10                                          // Rx pin which the MHZ19 Tx pin is attached to
#define TX_PIN 11                                          // Tx pin which the MHZ19 Rx pin is attached to
#define BAUDRATE 9600                                      // Device to MH-Z19 Serial baudrate (should not be changed)
MHZ19 myMHZ19;                                             // Constructor for library
SoftwareSerial mySerial(RX_PIN, TX_PIN);                   // (Uno example) create device to MH-Z19 serial

////////////////////////////////////
// LCD
LiquidCrystal_I2C display(0x27,16,2);  //Crear el objeto display  dirección  0x27 y 16 columnas x 2 filas

//////////////////////////////////
// Sensor temperatura suelo
DS18B20 ds(2);
float tempC;
//////////////////////////////////
// Sensor capacitivo de humedad de suelo
//Valores iniciales y calibracion sensor capacitivo humedad
const int AirValue = 446;   //valor del ADC para 0% humedad
const int WaterValue = 205;  //valor del ADC para 100% humedad
int soilMoistureValue = 0;
int soilmoisturepercent=0;

////////////////////////////////
// Variables globales del programa
unsigned long getDataTimer = 0; //Timer del programa
unsigned long timeElapse = 0;//Timer de la rutina de calibracion
const int cal_pin = 13;  // entrada pulsador calibración


void setup()
{
  Serial.begin(9600);                                     // Device to serial monitor feedback

  mySerial.begin(BAUDRATE);                               // (Uno example) device to MH-Z19 serial start
  myMHZ19.begin(mySerial);                                // *Serial(Stream) refence must be passed to library begin().
  myMHZ19.autoCalibration(false);                              // Turn auto calibration ON (OFF autoCalibration(false))

  pinMode(cal_pin, INPUT_PULLUP); // entrada pulsado para calibrar, seteada como pulluppara poder conectar pulsador sin poenr resistencia adicional

  display.init(); // Inicializar el display
  display.clear(); // borra pantalla
  display.backlight(); //Encender la luz de fondo.
  display.setCursor(0, 1); // Ubicamos el cursor en la primera posición(columna:0) de la segunda línea(fila:1)
  display.print("INICIANDO");
  delay(60000);// Demora 1 min en enviar datos para calentar el sensor
  display.clear(); // borra pantalla
}

void loop()
{

   if (digitalRead(cal_pin) == LOW) {  // si detecta el botón de calibrar apretado, calibra
      calibrar();
  }  
  if (millis() - getDataTimer >= 30000)
  {
    int CO2;
    /* note: getCO2() default is command "CO2 Unlimited". This returns the correct CO2 reading even
      if below background CO2 levels or above range (useful to validate sensor). You can use the
      usual documented command with getCO2(false) */
    CO2 = myMHZ19.getCO2();                             // Request CO2 (as ppm)
    /*int8_t Temp;
    Temp = myMHZ19.getTemperature();                     // Request Temperature (as Celsius)
    Serial.print("Temperature (C): ");
    Serial.println(Temp);*/
    //Serial print para enviar los datos al programa de viusualizacion de python  
    Serial.print(getDataTimer);
    Serial.print(" ");
    Serial.print (CO2);
    Serial.println();
    
    //Lee valor de temperatura
    tempC=ds.getTempC();
    
    //Lee y escribe valores sensor capacitivo humedad
    soilMoistureValue = analogRead(A0);  //put Sensor insert into soil
    soilmoisturepercent = map(soilMoistureValue, AirValue, WaterValue, 0, 100);

    // Datos por display
    display.clear();
    display.setCursor(0,0);
    display.print("CO2(ppm):");
    display.setCursor(10,0);
    display.print(CO2);
    display.setCursor(0,1);
    display.print("T:");
    display.setCursor(3,1);
    display.print(tempC);       
    //display.setCursor(7,1);
    //display.print(soilMoistureValue); 
    if(soilmoisturepercent >= 100)
      {
        display.setCursor(9,1);
        display.print("HR:");
        display.setCursor(12,1);
        display.print("100");
        Serial.print(100.0);
      }
        else if(soilmoisturepercent <=0)
      {
        display.setCursor(9,1);
        display.print("HR:");
        display.setCursor(12,1);
        display.print("0");
        Serial.print(0.0);
      }
        else if(soilmoisturepercent >0 && soilmoisturepercent < 100)
      {
        display.setCursor(9,1);
        display.print("HR:");
        display.setCursor(12,1);
        display.print(soilmoisturepercent);
        Serial.print(soilmoisturepercent);
      }
    Serial.println();
    getDataTimer = millis();
  }
}

void calibrar()
{
    int CO2Background ;
    CO2Background=myMHZ19.getBackgroundCO2();
    display.clear();
    display.setCursor(0,0);
    display.print("Background:");
    display.setCursor(0,1);
    display.print(CO2Background);

    display.clear();
    display.setCursor(0,0);
    display.print("Espera 20 min...");
//    Serial.println("Concentracion de background:");
//    Serial.println(CO2Background);
//    Serial.println("ABC Status: "); myMHZ19.getABC() ? Serial.println("ON") :  Serial.println("OFF");  // now print it's status
    
    //Serial.println("Waiting 20 minutes to stabalise...");
   /* if you don't need to wait (it's already been this amount of time), remove the next 2 lines */
    timeElapse = getDataTimer+12e5;                    //  20 minutes in milliseconds
    while(millis() < timeElapse) {};      //  wait this duration

    display.setCursor(0,1);
    display.print("Calibrando...");
    //Serial.println("Calibrating..");
    myMHZ19.calibrate();    // Take a reading which be used as the zero point for 400 ppm 
}
