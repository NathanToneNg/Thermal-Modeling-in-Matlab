global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 0;
global bottomLoss
bottomLoss = 1;
global constant
constant = 5.5921e-05;
global convecc
convecc = 1020;
global convection
convection = 0;
global cycle
cycle = 1;
global cycleIntervals
cycleIntervals = 20;
global cycleSpeed
cycleSpeed = 20;
global dd
dd = 0.0025;
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
elevatedTemp = 500;
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
load finalTempsGaussTest3DSuccess0x2Em
global framerate
framerate = 2000;
global frequency2
frequency2 = 12;
global graph
graph = 1;
global initialGrid
initialGrid = 0;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 1;
global list
list = '14.25';
list = str2num(list);
global materialMatrix
load materialMatrixGaussTest3DSuccess0x2Em
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
tempsList = '0.0078125';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.51;
global thermal_Conductivity2
thermal_Conductivity2 = 0.33;
global thin
thin = 0;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global total_time
total_time = 100;
global xdist
xdist = 0.1;
global ydist
ydist = 0.1;
global zdist
zdist = 0.1;

x = [dd/2:dd:xdist]';

D = thermal_Conductivity / specific_heat / density;
f = fit(x,finalTemps(:,20,20),'gauss1');

theoreticalC = sqrt(4 .* D .* (5:5:100)');


(theoreticalC(20) - f.c1) / theoreticalC(20)

fprintf('Inaccuracy from gaussian model is %d after %d seconds with %d distance increment.\n',...
    (theoreticalC(20) - f.c1) / theoreticalC(20), total_time, dd);


phi100 = f.a1 * (4 * pi * D * total_time)^(3/2)