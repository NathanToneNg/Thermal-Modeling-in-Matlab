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
finalTemps = '25.2983';
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
list = '1925661.4907      1715916.4028      1529122.1616      1362662.7998      1214316.8889      1082283.4791      964711.21228      859911.58883      766489.32569      683379.36501      609385.84754       543404.1617       484559.1249      432248.96077      385690.47984      344146.65769      307069.74139      274149.61384      244862.88211      218703.93659';
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
tempsList = '222.7486      198.4866      176.8794      157.6244      140.4646      125.1918      111.5918      99.46924      88.66273      79.04909      70.48998      62.85762       56.0508      49.99988      44.61428      39.80875      35.51992      31.71193      28.32422      25.29832';
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
experimentalTemps = list ./ specific_heat ./ density ./ dd;
analyticalTemps = 250.*(exp(-x.*2.*20./specific_heat./density./dd));
differences = (abs((experimentalTemps - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)
