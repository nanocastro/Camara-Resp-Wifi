# Cámara de Respiración de Suelo: Guía de armado
__Nodo reGOSH Mendoza - Equipo de Física Experimental II, FCEN - 2022__
## Descripción del dispositivo
El dispositivo puede medir la concentración de CO2, la temperatura y la humedad del suelo.  

<img src=/Version2-Mza/Imagenes/WhatsApp%20Image%202021-08-02%20at%2021.34.24.jpeg alt="SRC" width="400"/> <img src=/Version2-Mza/Imagenes/pantalla_py.jpeg  alt="SRC" width="500"/>

## BOM
[Lista de materiales](/Version2-Mza/ListaMateriales.ods)

## Ensamblado
El dispositivo cuenta con 2 partes, una cámara donde se aloja el sensor de CO2 y una unidad de control que se encarga de la comunicación con los sensores y de enviar lsos datos vía bluetooth a una PC donde se pueden visualizar y analizar. 
__Herramientas necesarias:__

* Soldador de estaño
* Pistola de silicona
* 4 tornillos de 2 cm
* Alicate
* Taladro
* Mecha para taladro de 18mm

## (2) Cableado y test inicial
En primer lugar debemos probar que la electrónica funcione correctamente, para ello:

* Realizamos el cableado según la figura:

Atención! El módulo bluetooth lo debemos conectar luego de que esté cargado el firmware.
  
<img src=/Version2-Mza/Hardware/crs_fritzing_bb.png alt="Esquematico Fritzing" width="500"/>   

### Ensamblado cámara de respiración
La cámara está compuesta por un tramo de 15-20cm de caño sanitario de 110mm y una tapa para dicho caño.   
  
Una vez que hemos comprobado el correcto funcionamiento del dispositivo podemos colocar y cablear el sensor de CO2 dentro de la cámara de respiración.  

<img src="/img/WhatsApp Image 2022-04-18 at 6.15.52 PM.jpeg" alt="Esquematico Fritzing" width="500"/>   

<img src="/img/WhatsApp Image 2022-04-18 at 6.30.37 PM(1).jpeg" alt="Esquematico Fritzing" width="500"/>     
Pegamos con silicona el [adaptador impreso](/Version2-Mza/Hardware/STL/mz_holder_soil_resp.stl) del sensor en el lado interno de la tapa y perforamos un hoyo del diámetro de la rosca del lado hembra de un conector GX12 de 4 pines.  
Luego pegamos el sensor al adaptador y colocamos el conector en la tapa.   

:eyes: Es conveniente soldar pines en el sensor de CO2 para facilitar su conexión.

:eyes: El módulo de bluetooth lo debemos conectar una vez que esté cargado el firmware.

## (3) Ensamblado de la cámara de respiración

La cámara está compuesta por un tramo de 15 a 20 cm de caño sanitario de 110 mm y una tapa para caño. (Ver Figura)

<img src=/Version2-Mza/Imagenes/img_10-5-22/cano_tapa_unitcontrol.jpg alt="SRC" width="300"/>  

Una vez que hemos comprobado el correcto funcionamiento del dispositivo (ver sección 2) podemos colocar y cablear el sensor de CO2 dentro de la cámara de respiración:

* Perforar con taladro un agujero del diámetro de la rosca del lado hembra de un conector GX12 de 4 pines.
* Colocar el conector en el agujero y fijar con silicona de ser necesario.
* Pegar con silicona el sensor de CO2 al adaptador.
* Atornillar la placa impresa, previamente unida al sensor, en la tapa de la cámara.

<img src=/Version2-Mza/Imagenes/img_10-5-22/sensordentrodetapa.jpg alt="SRC" width="700"/>

1. Adaptador impreso para sensor CO2
2. Conector GX12 de 4 pines
3. Conector GX12 ya colocado en la tapa de la cámara previamente agujereada.
4. Sensor CO2 que se fijará en el adaptador impreso.

Aquí se muestra el resultado final de la instalación del sensor de CO2 en el lado interno de la tapa de la cámara de respiración de suelo:

<img src=/Version2-Mza/Imagenes/img_10-5-22/sensorfijado.jpg alt="SRC" width="500"/>  

## (4) Ensamblado unidad de control 

La unidad de control está compuesta por una caja de peso plástica, una base para apoyar el Arduino y una carcasa para colocar el display.

* Fijar con silicona el soporte para placa Arduino en el fondo de la caja plástica.
* Usar el taladro con mecha 18 mm para hacer 3 agujeros en el frente de la caja de paso. Los agujeros tendrán que tener un diámetro acorde a los conectores GX12 de 3 pines.
* En nuestro caso, fue necesario agregar una cuarta perforación en el lado trasero de la caja. Esto se hizo para poder conectar nuestra placa Arduino UNO con su transformador 9V.

Aquí mostramos la unidad de control con las perforaciones realizadas:

<img src=/Version2-Mza/Imagenes/img_10-5-22/unidad_de_control.jpg alt="SRC" width="500"/>  

## (5) Conexiones

En esta etapa realizaremos las conexiones necesarias para el funcionamiento de los sensores. También es necesario replicar conexiones especificadas en la sección (2), pero esta vez en la unidad de control. Será necesario utilizar estaño y soldadora.

### Conexión: unidad de control - cámara de respiración
Se necesita armar un cable para conectar la unidad de control con la cámara de respiración. Para ello utilizamos un cable de 4 hilos y los lados macho de 2 conectores GX12 de 4 pines.
### Conexión: Conectores GX12 ficha hembra - Placa Arduino
Para los sensores de humedad y temperatura se utilizan 2 conectores GX12 de 3 pines:
* El lado hembra se conecta en un agujero perforado en la caja plástica y se conectan los cables de conexión al Arduino.
* Al lado macho se conectan los cables provenienties de los sensores.
* Fijar las fichas de los conectores en los agujeros de la caja de paso.

<img src=/Version2-Mza/Imagenes/img_10-5-22/conexiones_y_arduino.jpg alt="SRC" width="700"/>  
1. Unión del lado hembra de conectores GX12 con el cableado de cada sensor hacia la placa Arduino.
2. Placa Arduino, ya fijada en la unidad de control.

### Conexión: Sensores - Conector GX12 ficha macho
* Para el sensor de temperatura simplemente soldar su cable de 3 hilos con el lado macho del conector.
* Para entender la conexión del sensor de humedad ver Figura debajo. Se debe conectar el lado A de la placa de la ficha con la ficha macho del conector GX12. El cableado B corresponde a la cabecera del sensor de humedad.

<img src=/Version2-Mza/Imagenes/img_10-5-22/SENSORESTH.jpg alt="SRC" width="850"/>  
1. Placa de circuitos del sensor de humedad.
2. Cabecera del sensor de humedad.
3. Conexión del sensor de temperatura a ficha macho del conector GX12

### Conexión: Módulo BT - Placa Arduino

Esta conexión debe realizarse luego de corroborar el correcto funcionamiento de los sensores y el firmware.
* Utilizar cables conectores con ficha macho-hembra para la conexión del módulo BT con la placa Arduino.
