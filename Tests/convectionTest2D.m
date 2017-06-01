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
finalTemps = '25.1731';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '9628.0696      8578.6009      7643.7826      6811.0897      6069.3652      5408.6714      4820.1558      4295.9333      3828.9801      3413.0397      3042.5393      2712.5146      2418.5438      2156.6882      1923.4394      1715.6721      1530.6025      1365.7511      1218.9091       1088.109';
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
tempsList = '222.7431      198.4639      176.8371      157.5729      140.4133      125.1283      111.5131      99.38539      88.58254      78.95985      70.38842      62.75337      55.95243      49.89446      44.49831      39.69166      35.41012      31.59632      28.19917      25.17314';
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
zdist = 0.2;

x = 25:25:500;
experimentalTemps = list ./ specific_heat ./ density ./ dd ./ dd;
analyticalTemps = 250.*(exp(-2.*x.*20./specific_heat./density./dd)); %Not meant to work with single pixel/layer
differences = (abs((experimentalTemps - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)

