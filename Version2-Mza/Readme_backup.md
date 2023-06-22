# Descripción del dispositivo
El dispositivo puede medir la concentración de CO2, la temperatura y la humedad del suelo.  


<img src=/Version2-Mza/Imagenes/WhatsApp%20Image%202021-08-02%20at%2021.34.24.jpeg alt="SRC" width="400"/> <img src=/Version2-Mza/Imagenes/pantalla_py.jpeg  alt="SRC" width="500"/>


## BOM
[Lista de materiales](/Version2-Mza/ListaMateriales.ods)

## Ensamblado
El dispositivos cuenta con 2 partes, una cámara donde se aloja el sensor de CO2 y una unidad de control que se encarga de la comunicación con los sensores y de enviar los datos via bluetooth a una PC donde se pueden visualizar y analizar.  
**Herramientas necesarias:**
* Soldador de estaño
* Pistola de siliconas
* Alicate

### Cableado y test inicial
En primer lugar debemos probar que la electrónica funcione correctamente. Para ello realizamos el cableado según el esquemático y luego cargamos firmware para chequear el funcionamiento.
Es conveniente soldar pines en el sensor de CO2 para facilitar su conexión.   

<img src=/Version2-Mza/Imagenes/mhz19_front.jpeg alt="mhz19" width="400"/> <img src=/Version2-Mza/Imagenes/mhz19_back.jpeg alt="mhz19" width="400"/>   

Atención! El módulo bluetooth lo debemos conectar luego de que esté cargado el firmware.  
<img src=/Version2-Mza/Imagenes/crs_fritzing_bb.png alt="Esquematico Fritzing" width="500"/>   

### Ensamblado cámara de respiración
La cámara está compuesta por un tramo de 15-20cm de caño sanitario de 110mm y una tapa para dicho caño.   

<img src=/Version2-Mza/Imagenes/tubo110.jpeg alt="caño sanitario 110" width="400"/>   
  
Una vez que hemos comprobado el correcto funcionamiento del dispositivo podemos colocar y cablear el sensor de CO2 dentro de la cámara de respiración.  
Pegamos con silicona el [adaptador impreso](/Version2-Mza/Hardware/STL/mz_holder_soil_resp.stl) del sensor en el lado interno de la tapa y perforamos un hoyo del diámetro de la rosca del lado hembra de un conector GX12 de 4 pines.  
Luego pegamos el sensor al adaptador y colocamos el conector en la tapa.   

### Cable de conexión 
Se necesita armar un cable para conectar la unidad de control con la cámara de respiración. Para ello utilizamos un cable de 4 hilos y los lados macho de 2 conectores GX12 de 4 pines.

### Ensamblado unidad de control  
La unidad de control está compuesta por una caja de paso plástica, una base para apoyar el Arduino y una carcaza para colocar el display.  
Para los sensores de humedad y temperatura se utilizan 2 conectores GX12 de 3 pines.  El lado hembra se conecta en un agujero perforado en la caja plástica y se conectan los cables de conexión al Arduino. Al lado macho se conectan a los cables de los sensores.  
Una vez colocada la base para el Arduino en el fondo de la caja se mide y se corta la misma para permitir la entrada de la alimentación/USB.  
 
## Firmware
Última versión del [firmware](Version2-Mza/Firmware/CO2_serial_py_LCD_Temp/CO2_serial_py_LCD_Temp.ino)
El firmware se carga por medio de la [IDE de Arduino](https://www.arduino.cc/en/software)  

Librerias  utilizadas
* Para el MH-Z19 se utiliza una [librería](https://github.com/WifWaf/MH-Z19) que permite medir por debajo de 400ppm 
	
* Las libreías de la pantalla (LiquidCristal_I2C) y del sensor de temperatura (DSB18B20) se pueden descargar directamente del gestor de librerías de la IDE.  

## Software
[Aplicación de Python](https://gitlab.fcen.uncu.edu.ar/pcremades/co2-chamber-plot) para visualizar y analizar los datos en tiempo real desarrollada por Pablo Cremades.

[Soft alternativo](https://snapcraft.io/tauno-serial-plotter) para graficar el serial   

## Primeras experiencias
Realizamos una serie de [mediciones preliminares](/Version2-Mza/Mediciones_iniciales.md) para estudiar la respuesta de sensor. 

## Protocolos de medición
[Aquí](/Referencias/Talking_SMAAC_A_New_Tool_to_Measure_Soil_Respirati.pdf) se puede encontrar una referencia de las distintas formas de medir con algunas indicaciones de los protocolos  
- En campo -> mediciónes de 2 minutos
  - [protocolo de LICOR](https://www.youtube.com/watch?v=1EkkB8JaIzQ&ab_channel=MethodsinSoilOrganicMatterandBiogeochemistry)   
- En laboratorio - 24h burst test
  - [protocolo de Solvita](https://www.youtube.com/watch?v=_x7i7pDybJI)
- Soil induced respiration



