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
finalTemps = '83.9247';
finalTemps = str2num(finalTemps);
global framerate
framerate = 500;
global frequency2
frequency2 = 12;
global interfaceK
interfaceK = 0.2;
global list
list = '9933.8351       9192.297       8551.718      7991.0757       7495.085      7052.3156      6654.0172      6293.3555      5964.9005      5664.2728      5387.8942      5132.8066      4896.5392      4677.0092      4472.4459      4281.3327      4102.3615      3934.3971      3776.4482      3627.6449';
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
tempsList = '229.8169      212.6616      197.8419      184.8716       173.397      163.1536      153.9391      145.5953      137.9965      131.0416      124.6476      118.7462      113.2803      108.2015       103.469       99.0476      94.90715      91.02133      87.36722      83.92469';
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
sigma = 5.67 * 10^-8;

z = 273.15 + roomTemp;
T = 273.15 + elevatedTemp;
C = ((1/(4*sqrt(2)*(z^3))) * (-log(T^2 - sqrt(2)*T*z + z^2) + log(T^2 + sqrt(2)*T*z + z^2) - 2*atan(1 - sqrt(2)*T/z)+ 2*atan(1 + sqrt(2)*T/z)))


x = 25:25:500;
kelvinList = tempsList + 273.15;
analyticalTimes = (((1/(4*sqrt(2)*(z^3))) * (-log(kelvinList.^2 - sqrt(2).*kelvinList.*z + z.^2) + log(kelvinList.^2 + ...
    sqrt(2).*kelvinList.*z + z.^2) - 2*atan(1 - sqrt(2).*kelvinList./z)+ 2*atan(1 + sqrt(2).*kelvinList./z))) - C) ...
    .* -(1/2) .*density .* specific_heat .* dd ./ emissivity ./ sigma
