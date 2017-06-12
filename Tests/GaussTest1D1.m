global Tm
Tm = 110;
global Tm2
Tm2 = 110;
global absorption
absorption = 6;
global borders
borders = 1;
global constant
constant = 5.5921e-05;
global convection
convection = 0;
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
dt = 0.005;
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
finalTemps = ['2.283162e-16';'3.892448e-15';'6.638533e-14';'1.073101e-12';'1.638887e-11';'2.356818e-10';'3.179182e-09';'4.005332e-08';'4.689717e-07';'5.074098e-06';'5.039411e-05';'0.0004558143';' 0.003719461';'   0.0270676';'   0.1731653';'   0.9561932';'    4.448375';'    16.86666';'    49.69152';'    105.7247';'    144.2162';'    105.7247';'    49.69152';'    16.86666';'    4.448375';'   0.9561932';'   0.1731653';'   0.0270676';' 0.003719461';'0.0004558143';'5.039411e-05';'5.074098e-06';'4.689717e-07';'4.005332e-08';'3.179182e-09';'2.356818e-10';'1.638887e-11';'1.073101e-12';'6.638533e-14';'3.892448e-15';'2.283162e-16'];
finalTemps = str2num(finalTemps);
global framerate
framerate = 1000;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 0;
global list
list = '111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122      111219.5122';
list = str2num(list);
global materialMatrix
materialMatrix = ['1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1';'1'];
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
tempsList = '12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951      12.1951';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.51;
global thermal_Conductivity2
thermal_Conductivity2 = 0.33;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global total_time
total_time = 100;
global xdist
xdist = 0.2;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;

x = [0:dd:xdist]';
D = thermal_Conductivity / specific_heat / density;
f = fit(x,finalTemps,'gauss1');
maxes = ones(20,1);
maxes(1) = 448.5;
maxes(2) = 404.8;
maxes(3) = 367.6;
maxes(4) = 335.7;
maxes(5) = 308.3;
maxes(6) = 284.4;
maxes(20) = 140.1;
phi = maxes .* sqrt(D .* 4 .* pi .* (5:5:100)');
c = ones(20,1);
c(1) = 0.002944;
c(2) = 0.003374;
c(3) = 0.003729;
c(4) = 0.004059;
c(5) = 0.004382;
c(6) = 0.004713;
c(20) = 0.00989;

theoreticalC = ones(20,1);
theoreticalC = sqrt(4 .* D .* (5:5:100)');

%plot(1:100,prctile(finalTemps,1:100));