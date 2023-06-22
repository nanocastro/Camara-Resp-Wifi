# Cámara de respiración de suelo

Prototipo portátil y de bajo costo para medir el flujo de CO2, la temperatura y la humedad del suelo y estimar su actividad microbiana.  

![](/Versión1-%20PA/Imagenes/respira.jpeg)

Este prototipo es parte del trabajo que estamos desarrollando en el [Laboratorio agroecológico abierto](https://regosh.libres.cc/proyectos/lab-agroeco-abierto/) y el nodo [ReGOSH de Mendoza](https://regosh.libres.cc/).

Su desarrollo está basado en el [prototipo abierto de Hackteria](https://www.hackteria.org/wiki/CO2_Soil_Respiration_Chamber).  

El costo de este prototipo es de 2 órdenes de magnitud menor que el de una [cámara comercial](https://gitlab.com/nanocastro/camara-respiracion-suelo/-/blob/master/Presupuestos%20Nro%2012426.PDF).  

## Prototipos
Estos prototipos están aún en fase de desarrollo. Necesitamos testear en campo y mejorar la documentación y el diseño.

### Prototipo actual - Versión Mendoza

<img src=/Version2-Mza/Imagenes/WhatsApp%20Image%202021-08-02%20at%2021.34.24%20(1).jpeg alt="SRC" width="300"/> <img src=/Version2-Mza/Imagenes/MzaTest/pantalla1.jpg  alt="SRC" width="400"/>

Este prototipo utiliza el sensor de CO2 infrarrojo MH-Z19B que se coloca en el interior de una cámara para medir el flujo de CO2 y es controlado por una placa Arduino UNO. Los datos son transmitidos por bluetooth a un script de python que recibe los datos, los grafica en tiempo real y calcula la regresión lineal de un intervalo deseado. El dispositivo mide también la temperatura y la humedad de suelo

> [Aquí la documentación completa](/Version2-Mza) 

### Primer prototipo - Residencia Porto Alegre

![](/Versión1-%20PA/Imagenes/camara.png)

[Primer prototipo](/Versión1-%20PA) desarrollado en el marco de la residencia ReGOSH (Porto Alegre) financiadas por CYTED.   
Este dispositivo utiliza un sensor MH-Z16 y una placa Teensy 4.0. Los datos se visualizan en una pantalla OLED

### Cómo funciona y para que sirve una cámara de respiración de suelo?
[Aqui](/Referencias) puedes encontrar algunos documentos que explican el funcionamiento de las cámaras de respiración de suelo y presentan algunos de sus usos

### Licencia 
Este proyecto es de código abierto y se libera bajo [licencia CERN para hardware abierto](https://gitlab.com/nanocastro/camara-respiracion-suelo/-/blob/master/License). 

### Te interesa colaborar?

Si te interesa el proyecto y quisieras colaborar podes escribirnos a 

ferhcastro at gmail.com o pcremades at gmail.com





