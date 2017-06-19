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
list = '320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396           320396';
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
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '21.8718      21.8695      21.8677      21.8664      21.8654      21.8645      21.8638      21.8633      21.8628      21.8624       21.862      21.8617      21.8615      21.8612       21.861      21.8608      21.8606      21.8604      21.8602        21.86';
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
