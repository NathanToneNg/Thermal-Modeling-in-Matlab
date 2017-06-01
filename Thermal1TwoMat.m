function Thermal1TwoMat

%Globals allow this to carry over from set-up functions. They are used
%instead of persistent so that they can be used in the command frame if
%necessary.
global precision xdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm thermal_Conductivity roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2 extraConduction extraConvection extraRadiation;
clear global list;
clear global tempsList;
clear global materialMatrix;
global list;
global tempsList;
global materialMatrix;
global finalTemps;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rng('default'); %This can be used to make the randomized distributions
%consistent for repeatability

%Precision marks how many digits out calculations are carried to. The
%normal precision is 32, but using lower numbers saves time.
digits(precision);

%Index for frames in the movie
index = 1;

%Number of pixels across the grid
xintervals = floor(xdist / dd + 1);
mid = ceil(xintervals/2);


%This creates a temporary grid of which pixels start at higher temperature
Tempgrid = zeros(xintervals,1) + roomTemp;
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

%Total number of time steps that are taken.
iter = total_time/dt;
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

%Holds a grid of constants so that less calculations need to be repeated.
constants = ones(xintervals, 1) .* dt ./ (specific_heat .* dd .* dd .* density);
materialMatrix = ones(xintervals, 1);

%Holds the thermal conductivities at each pixel in each direction.
k = ones(xintervals, 1) * thermal_Conductivity;
leftK = ones(xintervals, 1);
rightK = ones(xintervals, 1);

%Declare where the second material is based on parameter "distribution" and
%the frequencies
second = zeros(xintervals,1);
switch distribution
    case 1
        %Center pixel
        second(mid) = 1;
    case 2
        %Center block (5th of size in each direction)
        second(mid - ceil(mid/10): mid + ceil(mid/10)) = 1;
    case 3
        %Uniform distribution
        second(1:ceil(frequency2):xintervals) = 1;
    case 4
        %Random distribution
        if frequency2 <= 1.1
            second(:) = 1;
        else
            i = 1;
            %Fills until the ratio is fulfilled.
            while i <= ceil(xintervals/frequency2)
                potentialRand = randi(xintervals);
                if(second(potentialRand) ~= 1)
                    second(potentialRand) = 1;
                    i = i + 1;
                end
            end
        end
    case 5
        %Random spheres
        if frequency2 <= 1.1
            second(:) = 1;
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
%Easier to assign as a matrix of doubles, but then make it a logical matrix
%afterwards.
second = logical(second);

%essentially gives the heat capacity constant used for most calculations
constants(second) = dt / (specific_heat2 * dd * dd * density2);
materialMatrix(second) = 2;
k(second) = thermal_Conductivity2;


%Determine where the receiver materials are. Same possibilities as for
%second material.
if materials == 3
    receivers = second;
else
    receivers = zeros(xintervals, 1);
    switch absorption
        case 1
            receivers(mid) = 1;
        case 2
            receivers(mid - ceil(mid/10): mid + ceil(mid/10)) = 1;
        case 3
            receivers(1:ceil(distributionFrequency):end) = 1;
        case 4
            if distributionFrequency <= 1.1
                receivers(:) = 1;
            else
                i = 1;
                while i <= ceil(xintervals/distributionFrequency)
                    potentialRand = randi(xintervals);
                    if(receivers(potentialRand) ~= 1)
                        receivers(potentialRand) = 1;
                        i = i + 1;
                    end
                end
            end
        case 5
            if distributionFrequency <= 1.1
                receivers(:) = 1;
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
                        if(receiver(j) ~= 1)
                            second(j) = 1;
                            i = i + 1;
                        end
                    end
                end
            end
        
    end
end
%Receivers is the iteratable size matrix, bigReceivers holds when we need to
%access from the matrix with edges.
receivers = logical(receivers);
bigReceivers = zeros(xintervals + 2, 1);
bigReceivers = logical(bigReceivers);
bigReceivers(2:end-1) = receivers;
        
%Creates the directional thermal conductivities matrices. Borders are
%different, and then conductivity depends on what two materials heat
%transfers between.
for i = 1:xintervals
    if i == 1
        leftK(i) = 0.33;
    else
        if(materialMatrix(i) == 1 && materialMatrix(i-1) == 1)    
            leftK(i) = thermal_Conductivity;
        elseif materialMatrix(i) == 2 && materialMatrix(i-1) == 2
            leftK(i) = thermal_Conductivity2;
        else
            leftK(i) = interfaceK;
        end
    end
    if i == xintervals
        rightK(i) = 0.33;
    else
        if(materialMatrix(i) == 1 && materialMatrix(i+1) == 1)    
            rightK(i) = thermal_Conductivity;
        elseif materialMatrix(i) == 2 && materialMatrix(i+1) == 2
            rightK(i) = thermal_Conductivity2;
        else
            rightK(i) = interfaceK;
        end
    end
end

%The initial temperature grid is assigned.
wholeMatrix = zeros(xintervals + 2, 1) + roomTemp;
wholeMatrix(2:end-1) = Tempgrid;

%%% movie stuff
clear F;
F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);

%Creates a logical that assigns where the borders are. Not meant to be accurate 
%with single dimension sizes in this form.
if radiation || convection
    boundaries = zeros(xintervals + 2,1);
    boundaries([2,end-1]) = 1;
    boundaries = logical(boundaries);
    parameterBounds = boundaries(2:end-1);
end

%If extra loss is turned on, that means we are treating it as
%thin, where heat loss is off all area.
if radiation && extraRadiation
    area = 5;
else
    area = 1;
end

%Ratios and room temperature constants set ahead of time for less
%calculation between timesteps.
if radiation
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(parameterBounds) .* area .* dd;
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if radiation && extraRadiation
    rMidConst = sigma .* emissivity .* constants(2:end-1) .* 4 .* dd;
    rMidAir = rMidConst .* (roomTemp + 273.15)^4;
end
if convection && extraConvection
    area = 5;
else
    area = 1;
end
if convection
    convRatio = 20 .* constants(parameterBounds) .* area .* dd;
    convAir = convRatio .* roomTemp;
end
if convection && extraConvection
    convMidRatio = 20 .* constants(2:end-1) .* 4 .* dd;
    convMidAir = convMidRatio .* roomTemp;
end
%%%


% This is where the program iterates through time steps. The first time
% step is considered the initial values, and iter + 1 is the last. 
for j= 2:iter + 1
    if any(isnan(wholeMatrix))
        text = strcat('Error at iteration ', num2str(j));
        disp(text);
        return
    end
    %Keep an older version so we aren't counting changes in the same time
    old = wholeMatrix(:);
    
    %If borders are on, we want no conduction off edges so we make the
    %edges the same temperature so there is no difference and so no
    %change
    if borders
        old(1) = old(2);
        old(end) = old(end-1);
    end
    %Use constants, thermal conductivity, and difference in temperatures
    %between pixels on the grid to calculate conductive transfer
    wholeMatrix(2:end-1) = wholeMatrix(2:end-1) + ...
        (old(1:end-2) - old(2:end-1)).*constants .* leftK + ...
        (old(3:end) - old(2:end-1)).*constants .* rightK;
    if ~borders && extraConduction
        wholeMatrix(2:end-1) = wholeMatrix(2:end-1) - 4.* old(2:end-1) .* constants .* k;
    end
    %Changes based on radiation
    if radiation
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
    end
    if extraRadiation
        wholeMatrix(3:end-2) = wholeMatrix(3:end-2) - ...
            (rMidConst .* ((old(3:end-2) + 273.15).^4)) + rMidAir;
    end
    %Changes based on convection
    if convection
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            ((old(boundaries) .* convRatio) - convAir);
    end
    if extraConvection
        wholeMatrix(3:end-2) = wholeMatrix(3:end-2) - ...
            ((old(3:end-2) .*convMidRatio) - convMidAir);
    end
    %Increments by energy (turned into temp) if between the correct time
    %interval
    if j >= iterOn && j <= iterOff
        wholeMatrix(bigReceivers) = wholeMatrix(bigReceivers) + energyRate .* constants(receivers) .* dd;
    end
    
    %Will graph/ save averages at correct framerate checking multiplicity.
    if mod(j - 1, framerate) == 0 %Could alternatively be mod(j, framerate) == 1
        list(index) = mean(wholeMatrix(2:end-1)./constants.* dt ./ dd); %Energy per meter squared
        tempsList(index) = mean(wholeMatrix(2:end-1));
        figure;
        plot(0:dd:xdist, wholeMatrix(2:end-1));
        %ylim([0 50]);
        %alpha(0.7);
        drawnow
        F(index) = getframe(gcf);
        index = index + 1;
    end
end

%Save final data frame in finalTemps
finalTemps = wholeMatrix(2:end-1);

%Will wait for user to give word, and will then close all windows, play the
%movie, and then show just the last screen. 
pause
close all;
fig = figure;
movie(fig,F,1)
close all;

plot(0:dd:xdist, wholeMatrix(2:end-1));
%ylim([0 50]);

%Used in tests where we need to check what percent of the material melts in
%a given heating simulation. Checks over all materials at the Tm passed in.
melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);

end