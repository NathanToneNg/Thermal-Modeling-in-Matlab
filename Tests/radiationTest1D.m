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
convection = 0;
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
finalTemps = '131.4084';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '2070514.5514      1987241.0203      1910451.2957      1839340.5841       1773239.492        1711585.83      1653903.3113      1599785.2335      1548881.8147      1500890.2525      1455546.8375      1412620.6353      1371908.3805      1333230.3153      1296426.7735      1261355.3546      1227888.5728      1195911.8875      1165322.0442      1136025.6704';
list = str2num(list);
global materialMatrix
materialMatrix = '1';
materialMatrix = str2num(materialMatrix);
global materials
materials = 1;
global precision
precision = 10;
global radiation
radiation = 1;
global roomTemp
roomTemp = 0;
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '239.5043      229.8717      220.9892      212.7635      205.1174      197.9856      191.3133      185.0532       179.165      173.6137      168.3686      163.4032      158.6939      154.2198      149.9626      145.9058      142.0345      138.3357      134.7972      131.4084';
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
sigma = 5.67 * 10^-8;

z = 273.15 + roomTemp;
T = 273.15 + elevatedTemp;
C = ((1/(4*sqrt(2)*(z^3))) * (-log(T^2 - sqrt(2)*T*z + z^2) + log(T^2 + sqrt(2)*T*z + z^2) - 2*atan(1 - sqrt(2)*T/z)+ 2*atan(1 + sqrt(2)*T/z)))


x = 25:25:500;
kelvinList = tempsList + 273.15;
analyticalTimes = (((1/(4*sqrt(2)*(z^3))) * (-log(kelvinList.^2 - sqrt(2).*kelvinList.*z + z.^2) + log(kelvinList.^2 + ...
    sqrt(2).*kelvinList.*z + z.^2) - 2*atan(1 - sqrt(2).*kelvinList./z)+ 2*atan(1 + sqrt(2).*kelvinList./z))) - C) ...
    .* -1 .*density .* specific_heat .* dd ./ emissivity ./ sigma


