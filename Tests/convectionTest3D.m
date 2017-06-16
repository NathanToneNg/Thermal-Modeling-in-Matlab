global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 4;
global borders
borders = 1;
global constant
constant = 0.00038172;
global convecc
convecc = 20;
global convection
convection = 1;
global cycle
cycle = 5;
global cycleIntervals
cycleIntervals = 20;
global cycleSpeed
cycleSpeed = 20;
global dd
dd = 0.005;
global density
density = 910;
global density2
density2 = 1600;
global dimensions
dimensions = 3;
global distribution
distribution = 0;
global distributionFrequency
distributionFrequency = 12;
global dt
dt = 0.05;
global elevFrequency
elevFrequency = 12;
global elevLocation
elevLocation = 1;
global elevatedTemp
elevatedTemp = 250;
global emissivity
emissivity = 0.97;
global energyRate
energyRate = 20;
global extraConduction
extraConduction = 0;
global extraConvection
extraConvection = 0;
global extraRadiation
extraRadiation = 0;
global finalTemps
finalTemps = '0.45637';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 0;
global list
list = '38.1957       27.007      19.1009      13.5121      9.56061      6.77041      4.79958      3.40525      2.41808      1.72275      1.23237     0.884288     0.636504       0.4637     0.342596     0.255479     0.192121     0.149653     0.120657    0.0986331';
list = str2num(list);
global materialMatrix
materialMatrix = '1';
materialMatrix = str2num(materialMatrix);
global materials
materials = 1;
global precision
precision = 10;
global radiation
radiation = 0;
global roomTemp
roomTemp = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '176.7298      124.9601      88.37884      62.51961      44.23647      31.32636      22.20742      15.75593      11.18835      7.971081      5.702131      4.091559      2.945075      2.145519      1.585177      1.182087     0.8889364     0.6924349     0.5582758     0.4563706';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.33;
global thermal_Conductivity2
thermal_Conductivity2 = 0.33;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global total_time
total_time = 500;
global xdist
xdist = 0;
global ydist
ydist = 0;
global zdist
zdist = 0;

x = 25:25:500;
experimentalTemps = list ./ specific_heat ./ density ./ dd ./ dd ./ dd;
analyticalTemps = 250.*(exp(-6.*x.*20./specific_heat./density./dd));
differences = (abs((experimentalTemps - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)
