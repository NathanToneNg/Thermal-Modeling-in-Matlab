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
convection = 1;
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
dimensions = 2;
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
finalTemps = '3.1097';
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
list = '45.7735      36.7581      29.5184      23.7045      19.0358      15.2865      12.2758      9.85797      7.91638       6.3572      5.10511      4.09962      3.29218      2.64376      2.12305      1.70491      1.36911      1.09946     0.882912     0.709017';
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
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '200.7609      161.2197      129.4665      103.9672      83.49019      67.04626      53.84106      43.23672      34.72097      27.88245      22.39082       17.9808      14.43937      11.59544      9.311644      7.477655      6.004883      4.822182      3.872422      3.109724';
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
xdist = 0.005;
global ydist
ydist = 0.005;
global zdist
zdist = 0.2;

x = 25:25:500;
analyticalTemps = 250.*(exp(-4.*x.*20./specific_heat./density./dd));
differences = (abs((tempsList - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)
