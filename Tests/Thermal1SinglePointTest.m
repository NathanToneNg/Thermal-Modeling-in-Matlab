global Tm
Tm = 110
global absorption
absorption = 4
global borders
borders = 0
global constant
constant = 0.00038172
global convection
convection = 0
global dd
dd = 0.005
global density
density = 910
global density2
density2 = 1600
global dimensions
dimensions = 1
global distribution
distribution = 0
global distributionFrequency
distributionFrequency = 12
global dt
dt = 0.05
global elevFrequency
elevFrequency = 12
global elevLocation
elevLocation = 1
global elevatedTemp
elevatedTemp = 250
global emissivity
emissivity = 0.97
global energyRate
energyRate = 20
global extraConduction
extraConduction = 0
global extraConvection
extraConvection = 0
global extraRadiation
extraRadiation = 0
global framerate
framerate = 500
global frequency2
frequency2 = 12
global interfaceK
interfaceK = 0.2
%list = 36.8809      25.1743      17.1836      11.7292       8.0062       5.4649      3.73026      2.54622      1.73801      1.18634     0.809774     0.552739     0.377291     0.257533     0.175788      0.11999    0.0819033    0.0559059    0.0381605    0.0260477
global materials
materials = 1
global precision
precision = 10
global radiation
radiation = 0
global roomTemp
roomTemp = 0
global self_set
self_set = 0
global specific_heat
specific_heat = 1900
global specific_heat2
specific_heat2 = 4130
global thermal_Conductivity
thermal_Conductivity = 0.33
global thermal_Conductivity2
thermal_Conductivity2 = 0.33
global timeOff
timeOff = 500
global timeOn
timeOn = 0
global total_time
total_time = 500
global xdist
xdist = 0
global ydist
ydist = 0.2
global zdist
zdist = 0.2

x = 25:25:500;
experimentalTemps = list ./ specific_heat ./ density ./ dd ./ dd ./ dd;
analyticalTemps = 250.*(exp(-2.*x.*thermal_Conductivity./specific_heat./density./dd./dd));
differences = experimentalTemps - analyticalTemps;
