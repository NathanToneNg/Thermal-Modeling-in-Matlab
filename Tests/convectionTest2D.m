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
global convecc
convecc = 20;
global convection
convection = 1;
global cycle
cycle = 5;
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
finalTemps = '2.7615';
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
list = '8576.3591      6807.6104      5404.4426      4290.8089      3406.8704      2706.0289      2150.1612      1708.7933      1358.2446      1080.6059      860.51623      685.56171       546.3911      436.46417      349.44056      280.06347      224.66023       181.1961      146.90547      119.36785';
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
tempsList = '198.412      157.4924      125.0305      99.26683      78.81713      62.60333      49.74346      39.53252      31.42266      24.99956      19.90784      15.86031      12.64063      10.09749      8.084223      6.479201       5.19746      4.191928      3.398623      2.761547';
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
analyticalTemps = 250.*(exp(-4.*x.*20./specific_heat./density./dd));
differences = (abs((experimentalTemps - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)