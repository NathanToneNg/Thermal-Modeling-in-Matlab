%overallGUI: Initializes to default variables and accepts input for dimensions and
%number of materials from user.
%
%Clarifications: 2 Materials mean there are two different materials, but 
%   neither is necessarily the receptor. 1 Matrix/ 1 Receptor guarantees that 
%   the receptors will be located where the second material is.
function overallGUI
    global precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    thermal_Conductivity2 interfaceK density2 specific_heat2 distribution frequency2 ...
    extraConduction cycle cycleIntervals cycleSpeed ...
    saveMovie isotherm convecc melting Tm2 graph thin bottomLoss initialGrid topCheck depth ...
    heating roomTempFunc finalGrid consistent gradientPlot recordGradient infinitex ...
    infinitey infinitez;

    
    %%%%Defaults
    precision = 10;
    xdist = 0.2;
    ydist = 0.2;
    zdist = 0.2;
    dd = 0.005;
    total_time = 30;
    dt = 0.005;
    framerate = 400;
    Tm = 110; %Melting point
    specific_heat = 1900;
    density = 960; %kg/m^3
    thermal_Conductivity = 0.51;
    constant = thermal_Conductivity * dt / (density * specific_heat * dd * dd);
    emissivity = 0.97;
    roomTemp = 0;
    elevatedTemp = 250;
    elevLocation = 1;
    elevFrequency = 12;
    absorption = 4;
    energyRate = 1250;
    distributionFrequency = 12;
    timeOn = 0;
    timeOff = 500;
    convection = false;
    radiation = false;
    thermal_Conductivity2 = 120;
    interfaceK = 60;
    density2 = 3210;
    specific_heat2 = 750;
    Tm2 = 150;
    distribution = 1;
    frequency2 = 12;
    extraConduction = false;
    thin = false;
    cycle = 1;
    cycleIntervals = 20;
    cycleSpeed = 20;
    isotherm = false;
    convecc = 20;
    saveMovie = false;
    melting = false;
    graph = true;
    bottomLoss = true;
    initialGrid = false;
    finalGrid = false;
    topCheck = false;
    depth = 0.0038;
    heating = false;
    roomTempFunc = @(x)0;
    consistent = false;
    gradientPlot = 0;
    recordGradient = false;
    %%%%%%%%%%%%
    
    
    repickDimensions

end