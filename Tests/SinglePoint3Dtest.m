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
finalTemps = '0.050505';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '17.176      5.46515      1.74401      0.56161       0.1859     0.066517    0.0285829    0.0165293    0.0126992    0.0114822    0.0110955    0.0109726    0.0109336    0.0109212    0.0109172     0.010916    0.0109156    0.0109155    0.0109154    0.0109154';
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
tempsList = '79.4725       25.287      8.06945      2.59854     0.860148     0.307771     0.132252    0.0764802    0.0587587    0.0531277    0.0513384    0.0507698    0.0505892    0.0505318    0.0505135    0.0505077    0.0505059    0.0505053    0.0505051    0.0505051';
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
ydist = 0;
global zdist
zdist = 0;

x = 25:25:500;
experimentalTemps = list ./ specific_heat ./ density ./ dd ./ dd ./ dd
analyticalTemps = 250.*(exp(-6.*x.*thermal_Conductivity./specific_heat./density./dd./dd))
differences = (abs((experimentalTemps - analyticalTemps) ./ analyticalTemps));
%percentOffest = mean(differences)
