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
global consistent
consistent = 0;
global constant
constant = 0.00036184;
global convecc
convecc = 20;
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
global depth
depth = 0.0038;
global dimensions
dimensions = 3;
global distribution
distribution = 2;
global distributionFrequency
distributionFrequency = 12;
global dt
dt = 0.005;
global elevFrequency
elevFrequency = 12;
global elevLocation
elevLocation = 3;
global elevatedTemp
elevatedTemp = 250;
global emissivity
emissivity = 0.97;
global energyRate
energyRate = 0;
global extraConduction
extraConduction = 0;
global extraConvection
extraConvection = 0;
global extraRadiation
extraRadiation = 0;
global finalGrid
finalGrid = 1;
global finalTemps
load ConstantEnergy3dTestPrecise1finalTemps
global framerate
framerate = 5000;
global frequency2
frequency2 = 12;
global gradientData
gradientData = ;
global gradientPlot
gradientPlot = 0;
global graph
graph = 1;
global heating
heating = 0;
global histogramPlot
global initialGrid
initialGrid = 0;
global interfaceK
interfaceK = 0.2;
global isotherm
isotherm = 0;
global list
list = '305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234           305234';
list = str2num(list);
global materialMatrix
load ConstantEnergy3dTestPrecise1materialMatrix
global materials
materials = 3;
global melting
melting = 0;
global precision
precision = 10;
global radiation
radiation = 0;
global recordGradient
recordGradient = 0;
global roomTemp
roomTemp = 0;
global roomTempFunc
roomTempFunc = @(x)0;
global saveMovie
saveMovie = 0;
global self_set
self_set = 0;
global specific_heat
specific_heat = 1900;
global specific_heat2
specific_heat2 = 4130;
global tempsList
tempsList = '20.8331      20.8311      20.8296      20.8284      20.8274      20.8266      20.8259      20.8253      20.8248      20.8243      20.8239      20.8236      20.8232      20.8229      20.8227      20.8224      20.8222       20.822      20.8218      20.8216';
tempsList = str2num(tempsList);
global thermal_Conductivity
thermal_Conductivity = 0.33;
global thermal_Conductivity2
thermal_Conductivity2 = 0.4;
global thin
thin = 0;
global timeOff
timeOff = 500;
global timeOn
timeOn = 0;
global topCheck
topCheck = 0;
global topTemps
global total_time
total_time = 500;
global xdist
xdist = 0.2;
global ydist
ydist = 0.2;
global zdist
zdist = 0.2;

list(2:end) - list(1:end-1)

