EESchema Schematic File Version 4
LIBS:PlacaBase-cache
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
L Amplifier_Operational:LM358 U1
U 1 1 5D40B2D9
P 2800 1800
F 0 "U1" H 2800 2167 50  0000 C CNN
F 1 "LM358" H 2800 2076 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm_Socket" H 2800 1800 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 2800 1800 50  0001 C CNN
	1    2800 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5D40B37B
P 2750 2200
F 0 "R2" V 2543 2200 50  0000 C CNN
F 1 "10k" V 2634 2200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 2680 2200 50  0001 C CNN
F 3 "~" H 2750 2200 50  0001 C CNN
	1    2750 2200
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 5D40B3FA
P 2200 1900
F 0 "R1" V 1993 1900 50  0000 C CNN
F 1 "10k" V 2084 1900 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 2130 1900 50  0001 C CNN
F 3 "~" H 2200 1900 50  0001 C CNN
	1    2200 1900
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5D40B45F
P 2450 1650
F 0 "#PWR01" H 2450 1400 50  0001 C CNN
F 1 "GND" H 2455 1477 50  0000 C CNN
F 2 "" H 2450 1650 50  0001 C CNN
F 3 "" H 2450 1650 50  0001 C CNN
	1    2450 1650
	-1   0    0    1   
$EndComp
Wire Wire Line
	2350 1900 2400 1900
Wire Wire Line
	2600 2200 2400 2200
Wire Wire Line
	2400 2200 2400 1900
Connection ~ 2400 1900
Wire Wire Line
	2400 1900 2500 1900
Wire Wire Line
	2900 2200 3100 2200
Wire Wire Line
	3100 2200 3100 1800
Text GLabel 2050 1900 0    50   Input ~ 0
input
Wire Wire Line
	2450 1650 2450 1700
Wire Wire Line
	2450 1700 2500 1700
Text GLabel 3100 1800 2    50   Input ~ 0
output
$Comp
L Connector:Conn_01x04_Female J1
U 1 1 5D40B72F
P 4250 1750
F 0 "J1" H 4277 1726 50  0000 L CNN
F 1 "Conn" H 4277 1635 50  0000 L CNN
F 2 "Connector_PinHeader_1.00mm:PinHeader_1x04_P1.00mm_Vertical" H 4250 1750 50  0001 C CNN
F 3 "~" H 4250 1750 50  0001 C CNN
	1    4250 1750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5D40B789
P 4050 1750
F 0 "#PWR03" H 4050 1500 50  0001 C CNN
F 1 "GND" V 4055 1622 50  0000 R CNN
F 2 "" H 4050 1750 50  0001 C CNN
F 3 "" H 4050 1750 50  0001 C CNN
	1    4050 1750
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR02
U 1 1 5D40B817
P 4050 1650
F 0 "#PWR02" H 4050 1500 50  0001 C CNN
F 1 "VCC" V 4068 1777 50  0000 L CNN
F 2 "" H 4050 1650 50  0001 C CNN
F 3 "" H 4050 1650 50  0001 C CNN
	1    4050 1650
	0    -1   -1   0   
$EndComp
Text GLabel 4050 1850 0    50   Input ~ 0
input
Text GLabel 4050 1950 0    50   Input ~ 0
output
$EndSCHEMATC
