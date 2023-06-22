# CO2 sensor performance test

We wanted to evaluate the performance of different CO2 sensors to be used into a soil respiration chamber. You can find more info about [our prototype](https://gitlab.com/nanocastro/camara-respiracion-suelo/-/wikis/home) here and several more version on [Hackteria wiki.](https://www.hackteria.org/wiki/CO2_Soil_Respiration_Chamber#URO.C5.A0_new_CO2_soil_chambers)

Our test doesn't include CO2 standards so we are not looking at absolute values but only the behavior of the different sensors in different situations: exposed to ambient air, inside an empty closed chamber and inside the same chamber but in the presence of a rewetted soil sample.

## Sensors

We used three different CO2 sensors  

| Sensor          | Technology                                                   | Aprox Price (USD) | Datasheet                                                    | Code Reference                                               |
| --------------- | ------------------------------------------------------------ | ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Winsen MH-Z16   | [NDIR](https://en.wikipedia.org/wiki/Nondispersive_infrared_sensor) | 80                | [MH-Z16](https://www.winsen-sensor.com/d/files/MH-Z16.pdf)   | [Arduino example](https://wiki.dfrobot.com/Infrared_CO2_Sensor_0-50000ppm_SKU__SEN0220) |
| Winsen MH-Z19   | NDIR                                                         | 30                | [MH-Z19](https://www.winsen-sensor.com/d/files/infrared-gas-sensor/ndir-co2-sensor/mh-z19b-co2-manual(ver1_6).pdf) | [Arduino library](https://github.com/WifWaf/MH-Z19)          |
| Sensirion SCD41 | [Photoacustic](https://www.hackteria.org/wiki/Testing_and_hacking_the_SCD_41) | 55                | [SCD41](https://sensirion.com/media/documents/C4B87CE6/61652F80/Sensirion_CO2_Sensors_SCD4x_Datasheet.pdf) | [Arduino example](https://github.com/Sensirion/arduino-snippets) |

All sensors are wide range (400 to 5000 ppm or more) and its declared accuracy is around ± 40ppm. 

First two sensors were provided in the context of [Biomaker 2022](https://www.biomaker.org/challenge) and the SCD41 as part of project [UROS](https://www.hackteria.org/wiki/UROS)

## Hardware

Each sensor was connected to an Arduino UNO and to a push button used for calibration.

<img src=/Version3%20-%20Biomaker/Test/test3sens/Imagenes/photo5078354689703127606.jpg width="600"/>

---TO DO--- Add schematics

## Firmware 

The firmware includes the same features for the three sensors:

- Turn off autocalibration

- Push button to allow span calibration (clean air -> aprox 400 ppm)

- Takes a measurement and sends data via serial port to the software every 30 seconds

  | [MH-Z16](https://gitlab.com/nanocastro/camara-respiracion-suelo/-/blob/master/Versionn%203%20-%20Biomaker/Firmware/CO2_MHZ16/CO2_MHZ16.ino) | [MH-Z19](https://gitlab.com/nanocastro/camara-respiracion-suelo/-/tree/master/Version2-Mza/Firmware/CO2_serial_py) | [SCD41](https://gitlab.com/nanocastro/camara-respiracion-suelo/-/blob/master/Versionn%203%20-%20Biomaker/Firmware/CO2_SDC41_calib/CO2_SDC41_calib.ino) |
  | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

## Software

We are using a [Python application](https://gitlab.fcen.uncu.edu.ar/pcremades/co2-chamber-plot) to read and graph data received through serial port in real time.  The software saves CO2 concentration data in a .csv format with a timestamp to allow for comparisons. 

It also calculates a linear regression of a selected range and the .png figure can be saved.

## Protocol

### Setup and calibration

Before each test all sensors were exposed to free air and then calibrated. The calibration procedure lasts 20 minutes and considers the in free air the concentration of CO2 is 400 ppm.  After calibration the sensors were left in free air for another 20 minutes.   
All sensors were connected through serial port to a computer were we open a Python instance for each to run the software. Measurements were taken every 30 seconds.

<img src=/Version3%20-%20Biomaker/Test/test3sens/Imagenes/photo5073743174727477962.jpg width="500"/>  <img src=/Version3%20-%20Biomaker/Test/test3sens/Imagenes/photo5073743174727477958.jpg width="500"/>

### Test chamber

The test chamber is made out of 110 mm standard sanitary pipe closed tightly by two lids were the sensors are installed. 

<img src=/Version3%20-%20Biomaker/Test/test3sens/Imagenes/photo5073743174727477957.jpg alt="photo5073743174727477957" width="500"/>

## Results

### Free air

After calibration the sensors were left measuring in free air for 30 minutes. 

<img src=/Version3%20-%20Biomaker/Test/test3sens/open_window.png alt="open window"/>

| Sensor | Min.  | Median | Mean  | Max.  |
| ------ | ----- | ------ | ----- | ----- |
| MH-Z19 | 404.0 | 407.0  | 409.5 | 426.0 |
| MH-Z16 | 395.0 | 405.0  | 405.5 | 417.0 |
| SCD41  | 397.0 | 420.5  | 419.7 | 433.0 |

### Empty chamber

After calibration the sensors were exposed to free air and then the empty chamber was capped with the lids (vertical red line) . The measurement lasted for around 6 hours. 

<img src=/Version3%20-%20Biomaker/Test/test3sens/closed_chamber.png alt="closed chamber"/>

### Rewetted soil sample

After calibration the sensors were exposed to free air and then a dry soil sample (aprox 120 gr) was rewetted with 30 ml of tap water and introduced into the chamber inside the chamber. The chamber was capped with the lids (vertical red line)  and the measurement lasted for around 6 hours. 


<img src=/Version3%20-%20Biomaker/Test/test3sens/Imagenes/photo5075994974541163228.jpg height="500"/>
<img src=/Version3%20-%20Biomaker/Test/test3sens/rewetted_soil.png alt="rewetted soil"/>


## Some fast observations

### Trend
Further analysis is needed to understand better the response of different sensors but at first glance all of them follow similar paterns inside the camber. SCD41 seems like the most stable sensor and has a very similar behavior to the MH-Z19. 
The starting slope (after the clousure bump) is very similar for all three sensors. This is an important fact for short field measurements.

### Closing bump
We need to improve the how to close the chamber and to avoid a jump in concentrations. We think this is due to a great amount of air trapped in a smaller volume, giving a higher concentration. 
In field measurements this CO2 puff, were the concentration suddenly rise at closing time, is called the [dead band](https://www.youtube.com/watch?v=1EkkB8JaIzQ&ab_channel=MethodsinSoilOrganicMatterandBiogeochemistry) and is not part of the valid data.
We did some further analysis of this in our chambers (red vertical line is for closing, yellow vertical line for opening).    
First we did a normal open an closing to check the puff and then we loose a little bit the lids and the puff dimished considerably.  
<img src=/Version3%20-%20Biomaker/Test/closing_chamber/normal_closing.png width="500" alt="closing"/> <img src=/Version3%20-%20Biomaker/Test/closing_chamber/soft_closing.png width="500" alt="soft closing"/>  
We will install a BMP280 sensor inside the chamber to study better changes in pressure.
One possible solution to the closing puff is to add a small vent that can serve at compensate the pressure when closing. 



