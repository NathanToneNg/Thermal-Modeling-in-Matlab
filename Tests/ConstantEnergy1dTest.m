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
global convection
convection = 0;
global dd
dd = 0.005;
global density
density = 910;
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
finalTemps = ['  70.985';' 62.0324';' 47.5376';'  32.212';' 19.7145';' 11.6902';' 8.25411';' 8.92727';' 13.1313';' 19.9965';' 27.8739';' 34.2821';' 36.7753';' 34.3065';' 27.8878';' 19.8478';' 12.3449';' 2.42827';'0.664723';'0.364722';' 1.01861';' 3.42782';' 9.15926';' 17.8523';'  28.524';' 29.7867';' 25.9807';' 19.4371';' 12.9538';' 8.47166';' 6.86616';' 8.38185';' 12.9359';' 19.9368';' 27.8739';' 34.3418';' 36.9706';' 34.8519';' 29.2756';' 23.0658';' 19.1038'];
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585      210853.6585';
list = str2num(list);
global materialMatrix
materialMatrix = ['1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'2';'2';'2';'2';'2';'2';'2';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1'];
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
tempsList = '23.9458      23.6186      23.3701      23.1759      23.0196      22.8905       22.781       22.686       22.602      22.5263       22.457      22.3929       22.333      22.2765      22.2229      22.1719       22.123       22.076      22.0308      21.9871';
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
