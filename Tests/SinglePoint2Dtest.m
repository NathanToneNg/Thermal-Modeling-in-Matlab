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
finalTemps = '0.075815';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '5035.1415      2347.0442       1094.968      511.76931      240.12396      113.59556       54.66049      27.209402       14.42309      8.4674138      5.6933476      4.4012283      3.7993782      3.5190453      3.3884704      3.3276505      3.2993215      3.2861262      3.2799801      3.2771173';
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
tempsList = '116.4868       54.2983      25.33182      11.83966       5.55521      2.628006      1.264557      0.629483     0.3336747     0.1958916     0.1317142     0.1018214     0.0878977    0.08141227    0.07839145    0.07698439    0.07632901    0.07602374    0.07588155    0.07581532';
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

