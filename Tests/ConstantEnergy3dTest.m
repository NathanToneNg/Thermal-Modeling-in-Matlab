global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 1;
global constant
constant = 0.00038172;
global convecc
convecc = 20;
global convection
convection = 0;
global cycle
cycle = 1;
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
distribution = 2;
global distributionFrequency
distributionFrequency = 12;
global dt
dt = 0.05;
global elevFrequency
elevFrequency = 12;
global elevLocation
elevLocation = 3;
global elevatedTemp
elevatedTemp = 250;
global emissivity
emissivity = 0.97;
global energyRate
energyRate = 0;
global extraConduction
extraConduction = 0;
global extraConvection
extraConvection = 0;
global extraRadiation
extraRadiation = 0;
global finalTemps
load finalTempsConstantEnergy3dTest0x2Em
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 0;
global list
list = '303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75        303794.75';
list = str2num(list);
global materialMatrix
load materialMatrixConstantEnergy3dTest0x2Em
global materials
materials = 3;
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
tempsList = '21.8716      21.8691      21.8673      21.8659      21.8648      21.8639      21.8632      21.8626      21.8621      21.8616      21.8612      21.8609      21.8606      21.8603      21.8601      21.8599      21.8597      21.8595      21.8593      21.8591';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.33;
global thermal_Conductivity2
thermal_Conductivity2 = 0.4;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global total_time
total_time = 500;
global xdist
xdist = 0.2;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;

diffAmount = (list(2:end) - list(1:end-1))./list(1:end-1)
