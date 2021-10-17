EESchema Schematic File Version 4
EELAYER 30 0
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
L HeyListen:ESP-01 U1
U 1 1 616A6070
P 3000 2300
F 0 "U1" H 3000 2715 50  0000 C CNN
F 1 "ESP-01" H 3000 2624 50  0000 C CNN
F 2 "HeyListen:ESP-01" H 3000 2300 50  0001 C CNN
F 3 "" H 3000 2300 50  0001 C CNN
	1    3000 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 2150 2500 2150
Wire Wire Line
	2650 2250 2400 2250
Wire Wire Line
	2650 2350 2300 2350
Wire Wire Line
	2650 2450 2200 2450
Wire Wire Line
	3350 2150 3500 2150
Wire Wire Line
	3350 2250 3600 2250
Wire Wire Line
	3350 2350 3700 2350
Wire Wire Line
	3350 2450 3800 2450
Text Label 2500 2150 2    50   ~ 0
TX1
Text Label 2300 2350 2    50   ~ 0
RST1
Text Label 2200 2450 2    50   ~ 0
V3P3
Text Label 3500 2150 0    50   ~ 0
GND
Text Label 3700 2350 0    50   ~ 0
PRG1
Text Label 3800 2450 0    50   ~ 0
RX1
$Comp
L HeyListen:ESP-01 U2
U 1 1 616A878D
P 3000 3250
F 0 "U2" H 3000 3665 50  0000 C CNN
F 1 "ESP-01" H 3000 3574 50  0000 C CNN
F 2 "HeyListen:ESP-01" H 3000 3250 50  0001 C CNN
F 3 "" H 3000 3250 50  0001 C CNN
	1    3000 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 3100 2500 3100
Wire Wire Line
	2650 3200 2400 3200
Wire Wire Line
	2650 3300 2300 3300
Wire Wire Line
	2650 3400 2200 3400
Wire Wire Line
	3350 3100 3500 3100
Wire Wire Line
	3350 3200 3600 3200
Wire Wire Line
	3350 3300 3700 3300
Wire Wire Line
	3350 3400 3800 3400
Text Label 2500 3100 2    50   ~ 0
TX2
Text Label 2300 3300 2    50   ~ 0
RST2
Text Label 2200 3400 2    50   ~ 0
V3P3
Text Label 3500 3100 0    50   ~ 0
GND
Text Label 3600 3200 0    50   ~ 0
LEDSIG
Text Label 3700 3300 0    50   ~ 0
PRG2
Text Label 3800 3400 0    50   ~ 0
RX2
$Comp
L HeyListen:ESP-01 U3
U 1 1 616A9082
P 3000 4300
F 0 "U3" H 3000 4715 50  0000 C CNN
F 1 "ESP-01" H 3000 4624 50  0000 C CNN
F 2 "HeyListen:ESP-01" H 3000 4300 50  0001 C CNN
F 3 "" H 3000 4300 50  0001 C CNN
	1    3000 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4150 2500 4150
Wire Wire Line
	2650 4250 2400 4250
Wire Wire Line
	2650 4350 2300 4350
Wire Wire Line
	2650 4450 2200 4450
Wire Wire Line
	3350 4150 3500 4150
Wire Wire Line
	3350 4250 3600 4250
Wire Wire Line
	3350 4350 3700 4350
Wire Wire Line
	3350 4450 3800 4450
Text Label 2500 4150 2    50   ~ 0
TX3
Text Label 2300 4350 2    50   ~ 0
RST3
Text Label 2200 4450 2    50   ~ 0
V3P3
Text Label 3500 4150 0    50   ~ 0
GND
Text Label 3600 4250 0    50   ~ 0
RSTMASTER
Text Label 3700 4350 0    50   ~ 0
PRG3
Text Label 3800 4450 0    50   ~ 0
RX3
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 616AD4E3
P 8550 2000
F 0 "J4" H 8630 1992 50  0000 L CNN
F 1 "Conn_01x02" H 8630 1901 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 8550 2000 50  0001 C CNN
F 3 "~" H 8550 2000 50  0001 C CNN
	1    8550 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 2000 8200 2000
Wire Wire Line
	8350 2100 8050 2100
Text Label 8200 2000 2    50   ~ 0
V3P3
Text Label 8050 2100 2    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_01x02 J5
U 1 1 616AEE34
P 8550 2450
F 0 "J5" H 8630 2442 50  0000 L CNN
F 1 "Conn_01x02" H 8630 2351 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 8550 2450 50  0001 C CNN
F 3 "~" H 8550 2450 50  0001 C CNN
	1    8550 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 2450 8200 2450
Wire Wire Line
	8350 2550 8050 2550
Text Label 8200 2450 2    50   ~ 0
V3P3
Text Label 8050 2550 2    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_01x03 J6
U 1 1 616B0E1F
P 8550 3000
F 0 "J6" H 8630 3042 50  0000 L CNN
F 1 "Conn_01x03" H 8630 2951 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 8550 3000 50  0001 C CNN
F 3 "~" H 8550 3000 50  0001 C CNN
	1    8550 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 2900 8200 2900
Wire Wire Line
	8350 3000 8050 3000
Wire Wire Line
	8350 3100 7950 3100
Text Label 8200 2900 2    50   ~ 0
GND
Text Label 8050 3000 2    50   ~ 0
LEDSIG
Text Label 7950 3100 2    50   ~ 0
V3P3
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 616B5B44
P 5500 2250
F 0 "J1" H 5580 2242 50  0000 L CNN
F 1 "Conn_01x04" H 5580 2151 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5500 2250 50  0001 C CNN
F 3 "~" H 5500 2250 50  0001 C CNN
	1    5500 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 2150 5150 2150
Wire Wire Line
	5300 2250 5000 2250
Wire Wire Line
	5300 2350 4850 2350
Wire Wire Line
	5300 2450 4700 2450
Text Label 5150 2150 2    50   ~ 0
RST1
Text Label 5000 2250 2    50   ~ 0
PRG1
Text Label 4850 2350 2    50   ~ 0
TX1
Text Label 4700 2450 2    50   ~ 0
RX1
$Comp
L Connector_Generic:Conn_01x04 J2
U 1 1 616B9D72
P 5500 3200
F 0 "J2" H 5580 3192 50  0000 L CNN
F 1 "Conn_01x04" H 5580 3101 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5500 3200 50  0001 C CNN
F 3 "~" H 5500 3200 50  0001 C CNN
	1    5500 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 3100 5150 3100
Wire Wire Line
	5300 3200 5000 3200
Wire Wire Line
	5300 3300 4850 3300
Wire Wire Line
	5300 3400 4700 3400
Text Label 5150 3100 2    50   ~ 0
RST2
Text Label 5000 3200 2    50   ~ 0
PRG2
Text Label 4850 3300 2    50   ~ 0
TX2
Text Label 4700 3400 2    50   ~ 0
RX2
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 616BAE9B
P 5500 4250
F 0 "J3" H 5580 4242 50  0000 L CNN
F 1 "Conn_01x04" H 5580 4151 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5500 4250 50  0001 C CNN
F 3 "~" H 5500 4250 50  0001 C CNN
	1    5500 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 4150 5150 4150
Wire Wire Line
	5300 4250 5000 4250
Wire Wire Line
	5300 4350 4850 4350
Wire Wire Line
	5300 4450 4700 4450
Text Label 5150 4150 2    50   ~ 0
RST3
Text Label 5000 4250 2    50   ~ 0
PRG3
Text Label 4850 4350 2    50   ~ 0
TX3
Text Label 4700 4450 2    50   ~ 0
RX3
Wire Notes Line
	1750 1750 6100 1750
Text Notes 4850 1900 2    50   ~ 0
SINGLE MODULE WITH DEBUG HEADER
Wire Notes Line
	6100 2650 1750 2650
Wire Notes Line
	1750 1750 1750 2650
Wire Notes Line
	6100 1750 6100 2650
$Comp
L Jumper:Jumper_2_Open JP1
U 1 1 616E4CBC
P 3250 5750
F 0 "JP1" H 3250 5985 50  0000 C CNN
F 1 "Jumper_2_Open" H 3250 5894 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 3250 5750 50  0001 C CNN
F 3 "~" H 3250 5750 50  0001 C CNN
	1    3250 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 5750 2800 5750
Wire Wire Line
	3450 5750 3800 5750
Text Label 2800 5750 2    50   ~ 0
RX1
Text Label 3800 5750 2    50   ~ 0
I2S
$Comp
L Device:R R1
U 1 1 616E79FE
P 3200 6550
F 0 "R1" V 2993 6550 50  0000 C CNN
F 1 "R" V 3084 6550 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 3130 6550 50  0001 C CNN
F 3 "~" H 3200 6550 50  0001 C CNN
	1    3200 6550
	0    1    1    0   
$EndComp
$Comp
L Transistor_BJT:2N3904 Q1
U 1 1 616EB69F
P 3950 6550
F 0 "Q1" H 4140 6596 50  0000 L CNN
F 1 "2N3904" H 4140 6505 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 4150 6475 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/2N3903-D.PDF" H 3950 6550 50  0001 L CNN
	1    3950 6550
	1    0    0    -1  
$EndComp
$Comp
L Device:Speaker LS1
U 1 1 616EC783
P 4500 6050
F 0 "LS1" H 4670 6046 50  0000 L CNN
F 1 "Speaker" H 4670 5955 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 4500 5850 50  0001 C CNN
F 3 "~" H 4490 6000 50  0001 C CNN
	1    4500 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 6750 4050 6950
Text Label 4050 6950 2    50   ~ 0
GND
Wire Wire Line
	4050 6350 4300 6350
Wire Wire Line
	4300 6350 4300 6150
Wire Wire Line
	4050 6050 4300 6050
Text Label 4050 6050 2    50   ~ 0
V3P3
Wire Wire Line
	3350 6550 3750 6550
Wire Wire Line
	3050 6550 2800 6550
Text Label 2800 6550 2    50   ~ 0
I2S
Wire Notes Line
	2500 7000 5350 7000
Wire Notes Line
	5350 7000 5350 5400
Wire Notes Line
	5350 5400 2500 5400
Wire Notes Line
	2500 5400 2500 7000
Text Notes 5200 5550 2    50   ~ 0
AUDIO CIRCUIT
$EndSCHEMATC
