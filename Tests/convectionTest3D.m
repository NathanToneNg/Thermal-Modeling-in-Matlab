global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 4;
global borders
borders = 1;
global constant
constant = 0.00038172;
global convection
convection = 1;
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
finalTemps = '8.0959';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '45.4346      38.2076      32.1319      27.0242      22.7303      19.1204      16.0857      13.5345      11.3897      9.58657      8.07074      6.79641      5.72511      4.82448      4.06733      3.43081       2.8957      2.44585      2.06766      1.74972';
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
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '210.2238      176.7847      148.6729      125.0399       105.172       88.4694      74.42781      62.62329      52.69943      44.35661      37.34295      31.44668      26.48979      22.32262      18.81935      15.87421      13.39828      11.31681      9.566954       8.09588';
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
experimentalTemps = list ./ specific_heat ./ density ./ dd ./ dd ./ dd;
analyticalTemps = 250.*(exp(-3.*x.*20./specific_heat./density./dd)); %Not meant to work with single pixel/layer
differences = (abs((experimentalTemps - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)

