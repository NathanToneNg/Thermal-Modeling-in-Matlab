global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 1;
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
global finalTemps
finalTemps = [' 72.8354';' 63.1604';' 47.6799';' 31.6078';' 18.7942';' 10.7669';' 7.43611';' 8.21993';' 12.5861';' 19.7775';' 28.1661';' 35.0892';' 37.8051';' 35.1206';' 28.2111';' 19.7297';' 12.0579';' 2.33904';'0.751259';'0.898048';'  2.9016';' 8.31416';' 26.5995';' 34.8111';'  37.937';'  35.267';' 28.2695';' 19.7793';' 12.4299';' 7.71705';' 6.12425';' 7.71298';' 12.4218';' 19.7766';' 28.3272';' 35.5874';' 39.0939';' 38.1178';' 34.4765';' 31.4257'];
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
list = '228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228           228';
list = str2num(list);
global materialMatrix
materialMatrix = ['1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'2';'2';'2';'2';'2';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1'];
materialMatrix = str2num(materialMatrix);
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
tempsList = '24.9979      24.9867      24.9641      24.9308      24.8887      24.8398      24.7859      24.7283      24.6683      24.6067      24.5443      24.4816      24.4191      24.3569      24.2954      24.2348      24.1752      24.1166      24.0593      24.0031';
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
