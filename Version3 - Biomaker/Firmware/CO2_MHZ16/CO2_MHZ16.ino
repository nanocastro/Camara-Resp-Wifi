/***************************************************
* Infrared CO2 Sensor MH-Z16 0-50000ppm(Wide Range)
* ****************************************************
* The follow is used to detect CO2 concentration and includes autocalibration turn-off and zero calibration.
* Is used as the firmware for a soil respiration chamber 
* Based on the example of
* @author lg.gang(lg.gang@qq.com)
* @version  V1.0
* @date  2016-6-6

* GNU Lesser General Public License.
* See <http://www.gnu.org/licenses/> for details.
* All above must be included in any redistribution
* ****************************************************/
#include <SoftwareSerial.h>
SoftwareSerial mySerial(2, 3); // RX, TX
unsigned char hexdata[9] = {0xFF,0x01,0x86,0x00,0x00,0x00,0x00,0x00,0x79}; //Read the gas density command /Don't change the order
unsigned long getDataTimer = 0;
unsigned char hexautocal[9]={0xFF,0x01,0x79,0x00,0x00,0x00,0x00,0x00,0x86};//Command to turn-off autocalibration
unsigned char hexzerocal[9]={0xFF,0x01,0x87,0x00,0x00,0x00,0x00,0x00,0x78};//Command for zero calibration (400ppm)

const int cal_pin = 6;  // calibration button
unsigned long timeElapse = 0;//used to wait the sensor to stabilize before calibration

void setup() {

  Serial.begin(9600);
  while (!Serial) {
  }
  mySerial.begin(9600);
  mySerial.write(hexautocal,9);// turn off autocalibration
  pinMode(cal_pin, INPUT_PULLUP); // push button for calibration, as pullup to avoid additional resistence

}

void loop() {
   if (digitalRead(cal_pin) == LOW) {  // if cal button is pressed enters calibration routine
    Serial.write("calibrando");
    calibrar();
  }  
 if (millis() - getDataTimer >= 30000)
 {
 //Send command and read CO2 measurement
 mySerial.write(hexdata,9);
 for(int i=0,j=0;i<9;i++)
 {
  if (mySerial.available()>0)
  {
     long hi,lo,CO2;
     int ch=mySerial.read();

    if(i==2){     hi=ch;   }   //High concentration
    if(i==3){     lo=ch;   }   //Low concentration
    if(i==8) {
               CO2=hi*256+lo;  //CO2 concentration
     Serial.print(getDataTimer);
    Serial.print(" ");
    Serial.print(CO2);
    Serial.println();
             }
  }
 }
     getDataTimer = millis(); //updates timer
 }
}

void calibrar()
{
  timeElapse = getDataTimer+12e5;                    //  20 minutes in milliseconds
    while(millis() < timeElapse) {};      //  wait this duration to stabilize sensor
  mySerial.write(hexzerocal,9);//set zero point calibration (400ppm])
   
}
