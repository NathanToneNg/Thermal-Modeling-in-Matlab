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
finalTemps = '0.0001281';
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
list = '27.6284      13.3917      6.49106      3.14627      1.52502     0.739191     0.358292     0.173667    0.0841777    0.0408016    0.0197769   0.00958602   0.00464642   0.00225216   0.00109164  0.000529126  0.000256472  0.000124314   6.0256e-05  2.92066e-05';
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
tempsList = '121.177      58.73548      28.46956      13.79943      6.688695      3.242064      1.571455     0.7616969     0.3692007     0.1789545    0.08674072    0.04204393    0.02037903   0.009877882   0.004787889   0.002320729   0.001124876  0.0005452365  0.0002642805  0.0001280989';
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
analyticalTemps = 250.*(exp(-4.*x.*thermal_Conductivity./specific_heat./density./dd./dd))
differences = (abs((tempsList - analyticalTemps) ./ analyticalTemps)) %Higher at end because of smaller temperatures
percentOffest = mean(differences)
