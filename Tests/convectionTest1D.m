global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 1;
global bottomLoss
bottomLoss = 1;
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
finalTemps = '27.8892';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global graph
graph = 0;
global initialGrid
initialGrid = 0;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 0;
global list
list = '51.0799      45.7746      41.0203      36.7599      32.9419      29.5205      26.4544      23.7068      21.2446      19.0381      17.0607      15.2888      13.7008      12.2778      11.0026      9.85987       8.8358      7.91809       7.0957      6.35873';
list = str2num(list);
global materialMatrix
materialMatrix = '1';
materialMatrix = str2num(materialMatrix);
global materials
materials = 1;
global melting
melting = 0;
global precision
precision = 10;
global radiation
radiation = 0;
global roomTemp
roomTemp = 0;
global saveMovie
saveMovie = 0;
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '224.0344      200.7657      179.9137      161.2275       144.482      129.4758      116.0282      103.9772       93.1779      83.50023      74.82771      67.05594      60.09136      53.85013      48.25714      43.24504      38.75351      34.72849      31.12151      27.88916';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.33;
global thermal_Conductivity2
thermal_Conductivity2 = 0.33;
global thin
thin = 0;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global total_time
total_time = 500;
global xdist
xdist = 0.005;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;


x = 25:25:500;
analyticalTemps = 250.*(exp(-x.*2.*20./specific_heat./density./dd));
differences = (abs((tempsList - analyticalTemps) ./ analyticalTemps)); 
offset = mean(differences)

