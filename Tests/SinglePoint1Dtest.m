global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 4;
global borders
borders = 0;
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
finalTemps = '0.27196';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '1475650.9616       1007671.861      688236.70089      470195.29398      321363.66531      219773.54074      150429.72247      103096.72477      70787.966376      48734.516985      33681.179929      23406.009251      16392.339653        11604.9193      8337.1016033      6106.5407345      4583.9950326      3544.7293274      2835.3429328      2351.1269577';
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
tempsList = '170.6942      116.5612      79.61095      54.38928      37.17336      25.42204      17.40078      11.92559      8.188313      5.637307       3.89603      2.707462      1.896164      1.342385     0.9643842     0.7063668     0.5302481     0.4100323     0.3279749     0.2719638';
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
xdist = 0;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;

x = 25:25:500;
experimentalTemps = list ./ specific_heat ./ density ./ dd
analyticalTemps = 250.*(exp(-2.*x.*thermal_Conductivity./specific_heat./density./dd./dd))
differences = (abs((experimentalTemps - analyticalTemps) ./ analyticalTemps)) %Higher at end because of smaller temperatures
mean(differences(1:10))
