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
finalTemps = '57.766';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '47.7382      42.7478       38.664       35.243      32.3248      29.7995      27.5883      25.6332      23.8904       22.326      20.9132      19.6307       18.461      17.3899      16.4056      15.4981      14.6589      13.8809       13.158      12.4847';
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
tempsList = '220.8822      197.7919      178.8966      163.0678      149.5655      137.8808      127.6496      118.6036      110.5399      103.3014      96.76454      90.83026      85.41823      80.46243      75.90799      71.70888      67.82612      64.22646      60.88133      57.76598';
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

sigma = 5.67 * 10^-8;

z = 273.15 + roomTemp;
T = 273.15 + elevatedTemp;
C = ((1/(4*sqrt(2)*(z^3))) * (-log(T^2 - sqrt(2)*T*z + z^2) + log(T^2 + sqrt(2)*T*z + z^2) - 2*atan(1 - sqrt(2)*T/z)+ 2*atan(1 + sqrt(2)*T/z)))


x = 25:25:500;
kelvinList = tempsList + 273.15;
analyticalTimes = (((1/(4*sqrt(2)*(z^3))) * (-log(kelvinList.^2 - sqrt(2).*kelvinList.*z + z.^2) + log(kelvinList.^2 + ...
    sqrt(2).*kelvinList.*z + z.^2) - 2*atan(1 - sqrt(2).*kelvinList./z)+ 2*atan(1 + sqrt(2).*kelvinList./z))) - C) ...
    .* -(1/3) .*density .* specific_heat .* dd ./ emissivity ./ sigma
