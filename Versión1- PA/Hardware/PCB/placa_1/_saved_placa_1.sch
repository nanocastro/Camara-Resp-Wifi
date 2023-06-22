EESchema Schematic File Version 4
LIBS:placa_1-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Sensor_Temperature:DS1822 Sensor_Temp1
U 1 1 5D419D78
P 2050 1450
F 0 "Sensor_Temp1" H 1820 1496 50  0000 R CNN
F 1 "DS1822" H 1820 1405 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 1050 1200 50  0001 C CNN
F 3 "http://datasheets.maximintegrated.com/en/ds/DS1822.pdf" H 1900 1700 50  0001 C CNN
	1    2050 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 1150 2500 1150
Wire Wire Line
	2350 1450 2500 1450
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 5D41A80D
P 3700 1400
F 0 "J1" H 3950 1400 50  0000 L CNN
F 1 "Sensor_CO2" V 3850 1150 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 3700 1400 50  0001 C CNN
F 3 "~" H 3700 1400 50  0001 C CNN
	1    3700 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5D41A89D
P 2050 1750
F 0 "#PWR0101" H 2050 1500 50  0001 C CNN
F 1 "GND" H 2055 1577 50  0000 C CNN
F 2 "" H 2050 1750 50  0001 C CNN
F 3 "" H 2050 1750 50  0001 C CNN
	1    2050 1750
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0102
U 1 1 5D41A990
P 2500 1150
F 0 "#PWR0102" H 2500 1000 50  0001 C CNN
F 1 "+3.3V" H 2515 1323 50  0000 C CNN
F 2 "" H 2500 1150 50  0001 C CNN
F 3 "" H 2500 1150 50  0001 C CNN
	1    2500 1150
	1    0    0    -1  
$EndComp
Text GLabel 2650 1450 2    50   Input ~ 0
Temp
$Comp
L power:GND #PWR0103
U 1 1 5D41AAB1
P 3500 1300
F 0 "#PWR0103" H 3500 1050 50  0001 C CNN
F 1 "GND" V 3505 1172 50  0000 R CNN
F 2 "" H 3500 1300 50  0001 C CNN
F 3 "" H 3500 1300 50  0001 C CNN
	1    3500 1300
	0    1    1    0   
$EndComp
Text GLabel 3500 1400 0    50   Input ~ 0
Vin
Text GLabel 3500 1500 0    50   Input ~ 0
TX1
Text GLabel 3500 1600 0    50   Input ~ 0
RX1
$Comp
L Connector:AudioJack3 J2
U 1 1 5D41B862
P 4900 1400
F 0 "J2" H 4880 1725 50  0000 C CNN
F 1 "AudioJack3" H 4880 1634 50  0000 C CNN
F 2 "Personal:AudioJack" H 4900 1400 50  0001 C CNN
F 3 "~" H 4900 1400 50  0001 C CNN
	1    4900 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5D41B936
P 5100 1300
F 0 "#PWR0104" H 5100 1050 50  0001 C CNN
F 1 "GND" V 5105 1172 50  0000 R CNN
F 2 "" H 5100 1300 50  0001 C CNN
F 3 "" H 5100 1300 50  0001 C CNN
	1    5100 1300
	0    -1   -1   0   
$EndComp
Text GLabel 5100 1500 2    50   Input ~ 0
Audio
$Comp
L Device:LED D1
U 1 1 5D41C581
P 6150 2400
F 0 "D1" V 6095 2478 50  0000 L CNN
F 1 "LED" V 6186 2478 50  0000 L CNN
F 2 "LED_THT:LED_D3.0mm_IRBlack" H 6150 2400 50  0001 C CNN
F 3 "~" H 6150 2400 50  0001 C CNN
	1    6150 2400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5D41C5F3
P 6150 2550
F 0 "#PWR0105" H 6150 2300 50  0001 C CNN
F 1 "GND" H 6155 2377 50  0000 C CNN
F 2 "" H 6150 2550 50  0001 C CNN
F 3 "" H 6150 2550 50  0001 C CNN
	1    6150 2550
	1    0    0    -1  
$EndComp
$Comp
L teensy:Teensy3.2 U2
U 1 1 5D41C6BD
P 7800 2300
F 0 "U2" H 7800 3887 60  0000 C CNN
F 1 "Teensy3.2" H 7800 3781 60  0000 C CNN
F 2 "teensy_library-master:Teensy30_31_32_LC" H 7800 1500 60  0001 C CNN
F 3 "" H 7800 1500 60  0000 C CNN
	1    7800 2300
	1    0    0    -1  
$EndComp
Text GLabel 6800 2800 0    50   Input ~ 0
Audio
Text GLabel 8800 3100 2    50   Input ~ 0
Vin
$Comp
L Switch:SW_Push_Dual button1
U 1 1 5D41C854
P 4800 2200
F 0 "button1" H 4800 2485 50  0000 C CNN
F 1 "SW_Push_Dual" H 4800 2394 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 4800 2400 50  0001 C CNN
F 3 "" H 4800 2400 50  0001 C CNN
	1    4800 2200
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push_Dual button2
U 1 1 5D41C8F8
P 4800 2850
F 0 "button2" H 4800 3135 50  0000 C CNN
F 1 "SW_Push_Dual" H 4800 3044 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 4800 3050 50  0001 C CNN
F 3 "" H 4800 3050 50  0001 C CNN
	1    4800 2850
	1    0    0    -1  
$EndComp
$Comp
L placa_1-rescue:OLED-Personal U1
U 1 1 5D41CABA
P 2650 2750
F 0 "U1" H 2978 2928 50  0000 L CNN
F 1 "OLED" H 2978 2837 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 2650 2750 50  0001 C CNN
F 3 "" H 2650 2750 50  0001 C CNN
	1    2650 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 2200 6150 2200
Wire Wire Line
	6150 2200 6150 2250
$Comp
L power:GND #PWR0107
U 1 1 5D41CCB4
P 2450 2300
F 0 "#PWR0107" H 2450 2050 50  0001 C CNN
F 1 "GND" H 2455 2127 50  0000 C CNN
F 2 "" H 2450 2300 50  0001 C CNN
F 3 "" H 2450 2300 50  0001 C CNN
	1    2450 2300
	-1   0    0    1   
$EndComp
Text GLabel 2600 2300 1    50   Input ~ 0
Vin
Text GLabel 2750 2300 1    50   Input ~ 0
SCL
Text GLabel 2900 2300 1    50   Input ~ 0
SDA
$Comp
L Device:R R1
U 1 1 5D41CF41
P 2500 1300
F 0 "R1" H 2570 1346 50  0000 L CNN
F 1 "4.7K" H 2570 1255 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2430 1300 50  0001 C CNN
F 3 "~" H 2500 1300 50  0001 C CNN
	1    2500 1300
	1    0    0    -1  
$EndComp
Connection ~ 2500 1150
Wire Wire Line
	2650 1450 2500 1450
Connection ~ 2500 1450
$Comp
L power:+3.3V #PWR0108
U 1 1 5D41D04D
P 8800 3300
F 0 "#PWR0108" H 8800 3150 50  0001 C CNN
F 1 "+3.3V" V 8815 3428 50  0000 L CNN
F 2 "" H 8800 3300 50  0001 C CNN
F 3 "" H 8800 3300 50  0001 C CNN
	1    8800 3300
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5D41E04B
P 4600 2200
F 0 "#PWR0106" H 4600 1950 50  0001 C CNN
F 1 "GND" V 4605 2072 50  0000 R CNN
F 2 "" H 4600 2200 50  0001 C CNN
F 3 "" H 4600 2200 50  0001 C CNN
	1    4600 2200
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5D41E078
P 4600 2850
F 0 "#PWR0109" H 4600 2600 50  0001 C CNN
F 1 "GND" V 4605 2722 50  0000 R CNN
F 2 "" H 4600 2850 50  0001 C CNN
F 3 "" H 4600 2850 50  0001 C CNN
	1    4600 2850
	0    1    1    0   
$EndComp
Text GLabel 5000 2200 2    50   Input ~ 0
but1
Text GLabel 5000 2850 2    50   Input ~ 0
but2
Text GLabel 6800 1800 0    50   Input ~ 0
but2
Text GLabel 6800 1900 0    50   Input ~ 0
but1
Text GLabel 6800 3500 0    50   Input ~ 0
SCL
Text GLabel 6800 3400 0    50   Input ~ 0
SDA
Text GLabel 6800 1200 0    50   Input ~ 0
TX1
Text GLabel 6800 1100 0    50   Input ~ 0
RX1
Text GLabel 6800 1000 0    50   Input ~ 0
GND
$Comp
L placa_1-rescue:BT-Personal U3
U 1 1 5D429FBD
P 1800 2300
F 0 "U3" V 2065 2994 50  0000 C CNN
F 1 "BT" V 1974 2994 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 1650 3200 50  0001 C CNN
F 3 "" H 1650 3200 50  0001 C CNN
	1    1800 2300
	0    -1   -1   0   
$EndComp
$Comp
L power:+3.3V #PWR0110
U 1 1 5D42A1E3
P 1550 2750
F 0 "#PWR0110" H 1550 2600 50  0001 C CNN
F 1 "+3.3V" V 1565 2878 50  0000 L CNN
F 2 "" H 1550 2750 50  0001 C CNN
F 3 "" H 1550 2750 50  0001 C CNN
	1    1550 2750
	0    1    1    0   
$EndComp
Text GLabel 1550 2650 2    50   Input ~ 0
Vin
$Comp
L power:GND #PWR0111
U 1 1 5D42A233
P 1550 2550
F 0 "#PWR0111" H 1550 2300 50  0001 C CNN
F 1 "GND" V 1555 2422 50  0000 R CNN
F 2 "" H 1550 2550 50  0001 C CNN
F 3 "" H 1550 2550 50  0001 C CNN
	1    1550 2550
	0    -1   -1   0   
$EndComp
Text GLabel 1550 2450 2    50   Input ~ 0
RX2
Text GLabel 1550 2350 2    50   Input ~ 0
TX2
Text GLabel 6800 2100 0    50   Input ~ 0
TX2
Text GLabel 6800 2000 0    50   Input ~ 0
RX2
NoConn ~ 8800 1000
NoConn ~ 8800 1100
NoConn ~ 8800 1200
NoConn ~ 8800 1300
NoConn ~ 8800 1400
NoConn ~ 8800 1500
NoConn ~ 8800 1600
NoConn ~ 8800 1700
NoConn ~ 8800 1800
NoConn ~ 8800 1900
NoConn ~ 8800 2000
NoConn ~ 8800 2100
NoConn ~ 8800 2200
NoConn ~ 8800 2300
NoConn ~ 8800 2400
NoConn ~ 8800 2500
NoConn ~ 8800 2600
NoConn ~ 8800 2700
NoConn ~ 8800 2800
NoConn ~ 8800 2900
NoConn ~ 8800 3000
NoConn ~ 8800 3200
NoConn ~ 8800 3400
NoConn ~ 8800 3500
NoConn ~ 8800 3600
NoConn ~ 6800 3600
NoConn ~ 6800 3300
NoConn ~ 6800 3200
NoConn ~ 6800 3100
NoConn ~ 6800 3000
NoConn ~ 6800 2900
NoConn ~ 6800 2700
NoConn ~ 6800 2600
NoConn ~ 6800 2500
NoConn ~ 6800 2400
NoConn ~ 6800 2300
NoConn ~ 6800 1600
NoConn ~ 6800 1500
NoConn ~ 6800 1400
NoConn ~ 6800 1300
NoConn ~ 5100 1400
NoConn ~ 1550 2250
NoConn ~ 4600 3050
NoConn ~ 4600 2400
NoConn ~ 5000 2400
NoConn ~ 5000 3050
Text GLabel 6800 1700 0    50   Input ~ 0
Temp
$EndSCHEMATC
