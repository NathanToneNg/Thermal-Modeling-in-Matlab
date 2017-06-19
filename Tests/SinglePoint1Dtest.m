global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 0;
global constant
constant = 0.00036184;
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
finalTemps = '0.17942';
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
list = '39.6892      27.6356      19.2427      13.3987      9.32954      6.49617      4.52329      3.14957      2.19305      1.52702      1.06327     0.740355      0.51551      0.35895     0.249937     0.174032     0.121178    0.0843767    0.0587516    0.0409088';
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
tempsList = '174.0753      121.2088      84.39782       58.7663      40.91904      28.49197      19.83899      13.81391      9.618641      6.697471      4.663456       3.24717      2.261008      1.574342      1.096216     0.7632966     0.5314842     0.3700731     0.2576823     0.1794245';
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
ydist = 0.2;
global zdist
zdist = 0.2;


x = 25:25:500;
analyticalTemps = 250.*(exp(-2.*x.*thermal_Conductivity./specific_heat./density./dd./dd))
differences = (abs((tempsList - analyticalTemps) ./ analyticalTemps)) %Higher at end because of smaller temperatures
mean(differences(1:10))