global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 1;
global bottomLoss
bottomLoss = 1;
global consistent
consistent = 0;
global constant
constant = 0.00036184;
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
density = 960;
global density2
density2 = 1600;
global depth
depth = 0.0038;
global dimensions
dimensions = 1;
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
global finalGrid
finalGrid = 1;
global finalTemps
finalTemps = ['72.8354';'63.1604';'47.6799';'31.6078';'18.7942';'10.7669';'7.43617';'8.22018';'12.5871';'19.7815';'28.1808';' 35.139';'37.9611';'35.5711';'29.4023';'22.5948';'18.2814';'      0';'      0';'      0';'      0';'      0';'47.6208';'46.9487';'44.1682';'38.1344';'29.4614';'20.2299';'12.5859';'7.76676';'6.13891';'7.71701';'12.4228';'19.7768';'28.3273';'35.5874';'39.0939';'38.1178';'34.4765';'31.4257'];
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
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
list = '228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228';
list = str2num(list);
global materialMatrix
materialMatrix = ['1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'2';'2';'2';'2';'2';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1'];
materialMatrix = str2num(materialMatrix);
global materials
materials = 3;
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
roomTempFunc = @(x)0;
global saveMovie
saveMovie = 0;
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '25           25           25           25           25           25           25           25           25           25           25           25           25           25           25           25           25           25           25           25';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.33;
global thermal_Conductivity2
thermal_Conductivity2 = 0.4;
global thin
thin = 0;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global topCheck
topCheck = 0;
global total_time
total_time = 500;
global xdist
xdist = 0.2;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;

list(2:end) - list(1:end-1)
