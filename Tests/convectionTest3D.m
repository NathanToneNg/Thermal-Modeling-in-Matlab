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
finalTemps = '0.34658';
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
list = '41.0174      29.5162        21.24      15.2843      10.9987      7.91467      5.69542      4.09844      2.94925      2.12229      1.52721      1.09898      0.79083     0.569084     0.409514     0.294688     0.212058     0.152598      0.10981    0.0790195';
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
tempsList = '179.9007      129.4571      93.15773      67.03658      48.23972      34.71345       24.9799      17.97561       12.9353      9.308283      6.698269      4.820094      3.468554      2.495982      1.796116       1.29249       0.93008     0.6692884     0.4816219     0.3465766';
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
zdist = 0.005;

x = 25:25:500;
analyticalTemps = 250.*(exp(-6.*x.*20./specific_heat./density./dd));
differences = (abs((tempsList - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)
