/*----------------------------------------------------------
    MH-Z19 CO2 sensor  SAMPLE
  ----------------------------------------------------------*/

#include <MHZ19_uart.h>

const int rx_pin = 10;	//Serial rx pin no
const int tx_pin = 11;	//Serial tx pin no

MHZ19_uart mhz19;

unsigned long getDataTimer = 0;

const int cal_pin = 13;  // entrada pulsador calibración
unsigned long timeElapse = 0;


/*----------------------------------------------------------
    MH-Z19 CO2 sensor  setup
  ----------------------------------------------------------*/
void setup() {
  Serial.begin(9600);
  mhz19.begin(rx_pin, tx_pin);
  mhz19.setAutoCalibration(false);
  
  pinMode(cal_pin, INPUT_PULLUP); // entrada pulsado para calibrar, seteada como pulluppara poder conectar pulsador sin poenr resistencia adicional
  
 delay(60000);// Demora 1 min en enviar datos para calentar el sensor
  
}

/*----------------------------------------------------------
    MH-Z19 CO2 sensor  loop
  ----------------------------------------------------------*/
void loop() {
  
     if (digitalRead(cal_pin) == LOW) {  // si detecta el botón de calibrar apretado, calibra
      calibrar();
  }  

  if (millis() - getDataTimer >= 10000)
  {
  int co2ppm = mhz19.getPPM();
  //int temp = mhz19.getTemperature();
  Serial.print(getDataTimer);
  Serial.print(" ");
  Serial.print(co2ppm);
  Serial.println();
  //Serial.print("temp: "); Serial.println(temp);
  
   getDataTimer = millis();
  }
}

void calibrar()
{
long cnt = 0;
const int waitingMinutes = 30;  //waiting 30 minutes
const long waitingSeconds = waitingMinutes * 60L;

  if ( ++cnt % 60 == 0) {
    Serial.print(cnt / 60); Serial.println("min.");
    Serial.print("co2: "); Serial.print(mhz19.getPPM()); Serial.println("ppm now.");
  } else {
    Serial.print(".");
  }
  delay(1000);

  if (cnt > waitingSeconds) {
    Serial.println("");
    mhz19.calibrateZero();
    Serial.println("1st zero calibration now .");

    delay(60000);
    mhz19.calibrateZero();  // Just in case
    Serial.println("2nd zero calibration now .");

    for ( int i = 0; i < 10; i++) {
      Serial.print("co2: "); Serial.print(mhz19.getPPM()); Serial.println("ppm now.");
      delay(10000);
    }
    cnt = 0;
    return;
  }
}
