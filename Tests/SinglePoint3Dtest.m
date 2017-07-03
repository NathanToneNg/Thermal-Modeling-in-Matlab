global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 0;
global bottomLoss
bottomLoss = 1;
global constant
constant = 0.00038172;
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
finalTemps = '2.7524e-08';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global graph
graph = 0;
global initialGrid
initialGrid = 0;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 1;
global list
list = '17.1685      5.45534      1.73344     0.550805      0.17502    0.0556128    0.0176711   0.00561502   0.00178418  0.000566928  0.000180143  5.72407e-05  1.81883e-05  5.77938e-06  1.83641e-06  5.83523e-07  1.85416e-07  5.89162e-08  1.87207e-08  5.94855e-09';
list = str2num(list);
global materialMatrix
materialMatrix = '1';
materialMatrix = str2num(materialMatrix);
global materials
materials = 1;
global melting
melting = 0;
global precision
precision = 10;
global radiation
radiation = 0;
global roomTemp
roomTemp = 0;
global saveMovie
saveMovie = 0;
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '79.438      25.2416      8.02056      2.54855     0.809807     0.257318    0.0817633    0.0259804   0.00825534   0.00262315  0.000833511   0.00026485  8.41566e-05  2.67409e-05  8.49698e-06  2.69993e-06  8.57909e-07  2.72602e-07  8.66199e-08  2.75237e-08';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.33;
global thermal_Conductivity2
thermal_Conductivity2 = 0.33;
global thin
thin = 0;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global total_time
total_time = 500;
global xdist
xdist = 0.005;
global ydist
ydist = 0.005;
global zdist
zdist = 0.005;

x = 25:25:500;
analyticalTemps = 250.*(exp(-6.*x.*thermal_Conductivity./specific_heat./density./dd./dd))
differences = (abs((tempsList - analyticalTemps) ./ analyticalTemps))
percentOffest = mean(differences(1:10))


