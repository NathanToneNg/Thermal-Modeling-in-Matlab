global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 1;
global bottomLoss
bottomLoss = 0;
global consistent
consistent = ;
global constant
constant = 5.5921e-05;
global convecc
convecc = 1020;
global convection
convection = 0;
global cycle
cycle = 1;
global cycleIntervals
cycleIntervals = 20;
global cycleSpeed
cycleSpeed = 20;
global dd
dd = 5e-06;
global density
density = 960;
global density2
density2 = 1600;
global dimensions
dimensions = 1;
global distribution
distribution = 0;
global distributionFrequency
distributionFrequency = 12;
global dt
dt = 5e-06;
global elevFrequency
elevFrequency = 12;
global elevLocation
elevLocation = 1;
global elevatedTemp
elevatedTemp = 500;
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
global finalGrid
finalGrid = 0;
global finalTemps
global framerate
framerate = 100000;
global frequency2
frequency2 = 12;
global gradientPlot
gradientPlot = 0;
global graph
graph = 1;
global heating
heating = 0;
global initialGrid
initialGrid = 0;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 0;
global list
list = '1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07    1.14e-07';
list = str2num(list);
global materialMatrix
load GaussTest1DSuccessVPrecisematerialMatrix
global materials
materials = 1;
global melting
melting = 0;
global precision
precision = 10;
global radiation
radiation = 0;
global recordGradient
recordGradient = 0;
global roomTemp
roomTemp = 0;
global roomTempFunc
roomTempFunc = ;
global saveMovie
saveMovie = 0;
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125      0.0125';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.51;
global thermal_Conductivity2
thermal_Conductivity2 = 0.33;
global thin
thin = 0;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global total_time
total_time = 100;
global xdist
xdist = 0.2;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;
