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
dimensions = 2;
global distribution
distribution = 0;
global distributionFrequency
distributionFrequency = 12;
global dt
dt = 0.0005;
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
finalTemps = '0.075816';
finalTemps = str2num(finalTemps);
global framerate
framerate = 50000;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '5038.0489      2349.7533      1096.8613      512.94553      240.80899      113.97856       54.86868      27.320259      14.481197      8.4974951      5.7087646      4.4090644      3.8033335      3.5210299      3.3894611      3.3281428      3.2995652      3.2862465      3.2800392      3.2771463';
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
tempsList = '116.5541      54.36098      25.37562      11.86687      5.571058      2.636867      1.269374     0.6320476      0.335019     0.1965875     0.1320709     0.1020026    0.08798921    0.08145818    0.07841437    0.07699579    0.07633465    0.07602652    0.07588292    0.07581599';
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
experimentalTemps = list ./ specific_heat ./ density ./ dd ./ dd
analyticalTemps = 250.*(exp(-4.*x.*thermal_Conductivity./specific_heat./density./dd./dd))
differences = experimentalTemps - analyticalTemps;
percentOffest = mean(differences)
