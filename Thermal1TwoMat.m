function Thermal1TwoMat
%% Initialize globals
%Globals allow this to carry over from set-up functions. They are used
%instead of persistent so that they can be used in the command frame if
%necessary.
global precision xdist dd total_time dt framerate convection radiation ...
    specific_heat density Tm thermal_Conductivity roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2 cycle cycleIntervals ...
    cycleSpeed convecc saveMovie melting Tm2 graph thin initialGrid heating roomTempFunc ...
    finalGrid consistent bottomLoss;
clear global list;
clear global tempsList;
clear global materialMatrix;
global list tempsList materialMatrix; %Results

if isempty(cycle)
    cycle = 1;
end
if isempty(convecc)
    convecc = 20;
end
if isempty(saveMovie)
    saveMovie = false;
end
if isempty(melting)
    melting = false;
end
if isempty(graph)
    graph = true;
end
if isempty(thin)
    global extraConvection extraRadiation
    thin = extraConvection || extraRadiation;
    clear global extraConvection
    clear global extraRadiation
end
if isempty(initialGrid)
    initialGrid = false;
end
if isempty(heating)
    heating = false;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(consistent) && consistent
    rng('default'); %This can be used to make the randomized distributions consistent
end

%Precision marks how many digits out calculations are carried to. The
%normal precision is 32, but using lower numbers saves time.
try
    digits(precision);
catch
    error('Must set parameters: use overallGUI');
end

%Index for frames in the movie
index = 1;

%Number of pixels across the grid
xintervals = floor(xdist / dd);
mid = ceil(xintervals/2);

%% Create Initial temperatures
%This creates a temporary grid of which pixels start at higher temperature
if heating
    Tempgrid = zeros(xintervals, 1) + roomTempFunc(0);
else
    Tempgrid = zeros(xintervals,1) + roomTemp;
end
switch elevLocation 
    case 1
        %Center pixel
        Tempgrid(mid) = elevatedTemp;
    case 2
        %Center block, 1/5 in each direction
        Tempgrid(mid - ceil(mid/10): mid + ceil(mid/10)) = elevatedTemp;
    case 3
        %Uniform distribution
        Tempgrid(1:elevFrequency:end) = elevatedTemp;
end
if initialGrid
    global initialFrame
    initialFrame = Tempgrid;
end

%Total number of time steps that are taken.
iter = total_time/dt;
if framerate > iter
    disp('Framerate too high- adjusting to graph only last frame.')
    framerate = iter;
end
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

%% Create relevant constants
%Holds a grid of constants so that less calculations need to be repeated.
constants = ones(xintervals, 1) .* dt ./ (specific_heat .* dd .* dd .* density);
constants = ones(xintervals, 1) .* dt ./ specific_heat;
materialMatrix = int8(ones(xintervals, 1));

%Holds the thermal conductivities at each pixel in each direction.
leftK = zeros(xintervals,1);
rightK = zeros(xintervals,1);
kArray = zeros(7,1);
kArray(3) = thermal_Conductivity; %Mat 1 with Mat 1
kArray(5) = interfaceK; %Mat 1 with Mat 2
kArray(7) = thermal_Conductivity2; %Mat 2 with Mat 2

%% Create materials grid
%Declare where the second material is based on parameter "distribution" and
%the frequencies
second = false(xintervals,1);
switch distribution
    case 1
        %Center pixel
        second(mid) = true;
    case 2
        %Center block (5th of size in each direction)
        second(mid - ceil(mid/10): mid + ceil(mid/10)) = true;
    case 3
        %Uniform distribution
        second(1:ceil(frequency2):xintervals) = true;
    case 4
        %Random distribution
        if frequency2 <= 1.1
            second(:) = true;
        else
            i = 1;
            %Fills until the ratio is fulfilled.
            while i <= ceil(xintervals/frequency2)
                potentialRand = randi(xintervals);
                if(~second(potentialRand))
                    second(potentialRand) = true;
                    i = i + 1;
                end
            end
        end
    case 5
        %Random spheres
        if frequency2 <= 1.1
            second(:) = true;
        else
            i = 0;
            num = ceil(xintervals/frequency2);
            %Fills until the ratio is fulfilled
            while i <= num
                potentialRand = randi(xintervals);
                %Picks a random radius, and then random center after
                randRadius = randi((num)/2);
                if(potentialRand - randRadius < 1)
                    start = 1;
                else
                    start = potentialRand - randRadius;
                end
                if(potentialRand + randRadius > xintervals)
                    ending = xintervals;
                else
                    ending = potentialRand + randRadius;
                end
                for j = start:ending
                    if(~second(j))
                        second(j) = true;
                        i = i + 1;
                    end
                end
            end
        end
end

%essentially gives the heat capacity constant used for most calculations
constants(second) = dt / (specific_heat2 * dd * dd * density2);
insertion(second) = dt / specific_heat2;
materialMatrix(second) = 2;
k(second) = thermal_Conductivity2;
Tms = ones(xintervals, 1) .* Tm;
Tms(second) = Tm2;

%Determine where the receiver materials are. Same possibilities as for
%second material.
if materials == 3
    receivers = second;
else
    receivers = false(xintervals, 1);
    switch absorption
        case 1
            receivers(mid) = true;
        case 2
            receivers(mid - ceil(mid/10): mid + ceil(mid/10)) = true;
        case 3
            receivers(1:ceil(distributionFrequency):end) = true;
        case 4
            if distributionFrequency <= 1.1
                receivers(:) = true;
            else
                i = 1;
                while i <= ceil(xintervals/distributionFrequency)
                    potentialRand = randi(xintervals);
                    if(~receivers(potentialRand))
                        receivers(potentialRand) = true;
                        i = i + 1;
                    end
                end
            end
        case 5
            if distributionFrequency <= 1.1
                receivers(:) = true;
            else
                i = 0;
                num = ceil(xintervals/distributionFrequency);
                while i <= num
                    potentialRand = randi(xintervals);
                    randRadius = randi((num)/2);
                    if(potentialRand - randRadius < 1)
                        start = 1;
                    else
                        start = potentialRand - randRadius;
                    end
                    if(potentialRand + randRadius > xintervals)
                        ending = xintervals;
                    else
                        ending = potentialRand + randRadius;
                    end
                    for j = start:ending
                        if(~receivers(j))
                            receivers(j) = true;
                            i = i + 1;
                        end
                    end
                end
            end
        
    end
end
%Receivers is the iteratable size matrix, bigReceivers holds when we need to
%access from the matrix with edges.
bigReceivers = false(xintervals + 2, 1);
bigReceivers(2:end-1) = receivers;

%% Create cycle if relevant
%Cycle setup. In try catch so older tests still work
rotation = ones(sum(receivers), 1);
try 
    cycleRate = round(cycleSpeed ./ dt ./ cycleIntervals);
    ratios = sin(0:pi/cycleIntervals:pi-pi/cycleIntervals);
    if cycle == 1
        ratios(:) = 1;
    end
    %Set however spread you want rotation to be, and where in the cycle each
    %starts
    if cycle == 3 || cycle == 5
        ratios = ratios .* 2;
    end
    if cycle == 4 || cycle == 5
        for i = 1:cycleIntervals
            %Right now this makes it into 20 groups (by matlab ordering, which 
            %is in x first, then y then z).
            rotation(1+floor(sum(receivers)/cycleIntervals*(i-1)):floor(sum(receivers)/cycleIntervals*i)) = i;
        end
    end
catch
    ratios = 1;
    rotation = rotation';
    disp('No rotation');
end
     
%% Create conductivity grids
%Creates the directional thermal conductivities matrices. Borders are
%different, and then conductivity depends on what two materials heat
%transfers between.
for i = 1:xintervals
    if i ~= 1
        leftK(i) = kArray(materialMatrix(i) + materialMatrix(i-1)+1);
%   else
%       leftK(i) = 0;
    end
    if i ~= xintervals
        rightK(i) = kArray(materialMatrix(i) + materialMatrix(i+1) + 1);
    end
end

%The initial temperature grid is assigned.
wholeMatrix = zeros(xintervals + 2, 1) + roomTemp;
wholeMatrix(2:end-1) = Tempgrid;

%%% movie stuff
F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);

%Melting Stuff
melted = false(xintervals,1);

%% Create constants for radiation and convection
%Creates a logical that assigns where the borders are. Not meant to be accurate 
%with single dimension sizes in this form.
if radiation || convection
    boundaries = false(xintervals + 2,1);
    boundaries([2,end-1]) = true;
    parameterBounds = boundaries(2:end-1);
end

%If extra loss is turned on, that means we are treating it as
%thin, where heat loss is off all area.
if radiation && thin
    area = 5;
else
    area = 1;
end
area = area + (xintervals == 1);

%Ratios and room temperature constants set ahead of time for less
%calculation between timesteps.
if radiation
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(parameterBounds) .* area .* dd;
    if ~heating
        rAir = rConst .* (roomTemp + 273.15)^4;
    end
    if thin
        rMidConst = sigma .* emissivity .* constants(2:end-1) .* 4 .* dd;
        rMidAir = rMidConst .* (roomTemp + 273.15)^4;
    end
end

if convection && thin
    area = 4 + bottomLoss;
else
    area = 1;
end
area = area + (xintervals == 1);

if convection
    convRatio = convecc .* constants(parameterBounds) .* area .* dd;
    if ~heating
        convAir = convRatio .* roomTemp;
    end
    if thin
        convMidRatio = convecc .* constants(2:end-1) .* 4 .* dd;
        convMidAir = convMidRatio .* roomTemp;
    end
end
%%%

%% Iterate
% This is where the program iterates through time steps. The first time
% step is considered the initial values, and iter + 1 is the last. 
for j= 2:iter + 1
    if any(isnan(wholeMatrix))
        text = strcat('Error at iteration ', num2str(j));
        disp(text);
        return
    end
    %Keep an older version so we aren't counting changes in the same time
    old = wholeMatrix;
    
    %Use constants, thermal conductivity, and difference in temperatures
    %between pixels on the grid to calculate conductive transfer
    wholeMatrix(2:end-1) = wholeMatrix(2:end-1) + ...
        (old(1:end-2) - old(2:end-1)).*constants .* leftK + ...
        (old(3:end) - old(2:end-1)).*constants .* rightK;
    %Changes based on radiation
    if radiation
        if heating
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                (rConst .* (((old(boundaries) + 273.15).^4) - ...
                (roomTempFunc(j * dt) + 273.15).^4));
            if thin
                wholeMatrix(3:end-2) = wholeMatrix(3:end-2) - ...
                (rConst .* (((old(3:end-2) + 273.15).^4) - ...
                (roomTempFunc(j * dt) + 273.15).^4));
            end
        else
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
            if thin
                wholeMatrix(3:end-2) = wholeMatrix(3:end-2) - ...
                    (rMidConst .* ((old(3:end-2) + 273.15).^4)) + rMidAir;
            end
        end
    end
    
    %Changes based on convection
    if convection
        if heating
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                ((old(boundaries) - roomTempFunc(j * dt)) .* convRatio);
            if thin
                wholeMatrix(3:end-2) = wholeMatrix(3:end-2) - ...
                ((old(3:end-2) - roomTempFunc(j * dt)) .* convRatio);
            end
        else
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                ((old(boundaries) .* convRatio) - convAir);
            if thin
                wholeMatrix(3:end-2) = wholeMatrix(3:end-2) - ...
                    ((old(3:end-2) .*convMidRatio) - convMidAir);
            end
        end
    end
    
    %Increments by energy (turned into temp) if between the correct time
    %interval
    if j >= iterOn && j <= iterOff
        wholeMatrix(bigReceivers) = wholeMatrix(bigReceivers) + energyRate .* insertion(receivers) .* ratios(rotation)';
    end
    %If cycle/rotations are on, this will change
    if ~isempty(cycle) && cycle ~= 1 && mod(j - 1, cycleRate) == 0
        rotation = rotation + 1;
        rotation(rotation > cycleIntervals) = 1;
    end
    
    
    %Will graph/ save total energy/ average temps at correct framerate.
    if mod(j - 1, framerate) == 0 %Could alternatively be mod(j, framerate) == 1
        list(index) = sum(wholeMatrix(2:end-1)./constants) .* dt .* dd; %Energy per meter squared
        tempsList(index) = mean(wholeMatrix(2:end-1));
        if graph
            figure;
            plot(dd/2:dd:xdist, wholeMatrix(2:end-1));
            %ylim([0 50]);
            %alpha(0.7);
            drawnow
            F(index) = getframe(gcf);
        end
        index = index + 1;
        if melting
            melted = anyMeltingIter(wholeMatrix(2:end-1),melted,Tms);
        end
    end
end

%% Save final settings and play movie/ display final frame
%Save final data frame in finalTemps
if ~isempty(finalGrid) && finalGrid
    clear global finalTemps
    global finalTemps
    finalTemps = wholeMatrix(2:end-1);
end

%Will wait for user to give word, and will then close all windows, play the
%movie, and then show just the last screen. 
if graph
    pause
    close all;
    fig = figure;
    movie(fig,F,1)
    close all;
    if saveMovie
        v = VideoWriter('recentTestMovie','Motion JPEG 2000');
        v.open;
        v.writeVideo(F)
        v.close;
    end

    plot(dd/2:dd:xdist, wholeMatrix(2:end-1));
    %ylim([0 50]);
end

%Used in tests where we need to check what percent of the material melts in
%a given heating simulation. Checks over all materials at the Tm passed in.
if melting
    num = xintervals;
    ratio = sum(melted)/num;

    fprintf('Ratio Melted = %d / %d = %g = %g%%\n', sum(melted), num, ratio, ratio*100);
end

end