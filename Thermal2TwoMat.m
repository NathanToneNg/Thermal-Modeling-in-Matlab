function Thermal2TwoMat
%% Initialize globals
%Globals allow this to carry over from set-up functions. They are used
%instead of persistent so that they can be used in the command frame if
%necessary.
global precision xdist ydist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2 extraConduction extraConvection extraRadiation cycle cycleIntervals cycleSpeed convecc;
clear global list;
clear global tempsList;
clear global materialMatrix;
global list tempsList materialMatrix finalTemps; %Results

if isempty(cycle)
    cycle = 1;
end
if isempty(convecc)
    convecc = 20;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rng('default'); %This can be used to make the randomized distributions
%consistent for repeatability

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
yintervals = floor(ydist / dd);

midx = ceil(xintervals/2);
midy = ceil(yintervals/2);

%% Create Initial temperatures 
%This creates a temporary grid of which pixels start at higher temperature
Tempgrid = zeros(xintervals, yintervals) + roomTemp;
switch elevLocation 
    case 1
        %Center pixel
        Tempgrid(midx, midy) = elevatedTemp;
    case 2
        %Center block, 1/5 in each direction
        Tempgrid(midx - ceil(midx/10): midx + ceil(midx/10),...
            midy - ceil(midy/10):midy + ceil(midy/10)) = elevatedTemp;
    case 3
        %Uniform distribution
        xfreq = ceil(sqrt(elevFrequency));
        yfreq = floor(elevFrequency/xfreq);
        Tempgrid(1:xfreq:end,1:yfreq:end) = elevatedTemp;
end

%Total number of time steps that are taken.
iter = total_time/dt;
if absorption
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

%% Create relevant constants
%Holds a grid of constants so that less calculations need to be repeated.
constants = ones(xintervals, yintervals) .* dt ./ (specific_heat .* dd .* dd .* density);
materialMatrix = int8(ones(xintervals, yintervals));


%Holds the thermal conductivities at each pixel in each direction.
k = ones(xintervals, yintervals) * thermal_Conductivity;
leftK = ones(xintervals, yintervals);
rightK = ones(xintervals, yintervals);
upK = ones(xintervals, yintervals);
downK = ones(xintervals, yintervals);

%% Create materials grid
%Declare where the second material is based on parameter "distribution" and
%the frequencies
second = false(xintervals,yintervals);
switch distribution
    case 1
        %Center pixel
        second(midx, midy) = true;
    case 2
        %Center block (5th of size in each direction)
        second(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10)) = true;
    case 3
        %Uniform distribution
        freq = sqrt(frequency2);
        second(ceil(1:freq:xintervals),ceil(1:freq:yintervals)) = true;
    case 4
        %Random distribution
        if frequency2 <= 1.1
            second(:,:) = true;
        else
            i = 1;
            %Fills until the ratio is fulfilled.
            while i <= ceil(xintervals*yintervals/frequency2)
                potentialRand = randi(xintervals);
                potentialRand2 = randi(yintervals);
                if(~second(potentialRand,potentialRand2))
                    second(potentialRand,potentialRand2) = true;
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
            num = ceil(xintervals * yintervals/frequency2);
            %Fills until the ratio is fulfilled
            while i <= num
                potentialRand = randi(xintervals);
                potentialRand2 = randi(yintervals);
                %Picks a random radius, and then random center after
                randRadius = randi(floor(sqrt(num)/3.14));
                if(potentialRand - randRadius < 1)
                    startx = 1;
                else
                    startx = potentialRand - randRadius;
                end
                if(potentialRand + randRadius > xintervals)
                    endingx = xintervals;
                else
                    endingx = potentialRand + randRadius;
                end
                for j = startx:endingx
                    for k = potentialRand2 - ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2)))) : ...
                            potentialRand2 + ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2))))
                        if k > 0 && k < yintervals
                            if(~second(j,k))
                                second(j,k) = true;
                                i = i + 1;
                            end
                        end
                    end
                end
            end
        end
end

%essentially gives the heat capacity constant used for most calculations
constants(second) = dt / (specific_heat2 * dd * dd * density2);
materialMatrix(second) = 2;
k(second) = thermal_Conductivity2;

%Determine where the receiver materials are. Same possibilities as for
%second material.
if materials == 3
    receivers = second;
else
    receivers = false(xintervals, yintervals);
    switch absorption
        case 1
            receivers(midx, midy) = true;
        case 2
            receivers(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): midy + ceil(midy/10)) = true;
        case 3
            frequ = sqrt(distributionFrequency);
            receivers(ceil(1:frequ:xintervals),ceil(1:frequ:yintervals)) = true;
        case 4
            if distributionFrequency <= 1.1
                receivers(:,:) = true;
            else
                i = 1;
                while i <= ceil(xintervals*yintervals/distributionFrequency)
                    potentialRand = randi(xintervals);
                    potentialRand2 = randi(yintervals);
                    if(~receivers(potentialRand,potentialRand2))
                        receivers(potentialRand,potentialRand2) = true;
                        i = i + 1;
                    end
                end
            end
        case 5
            if distributionFrequency <= 1.1
                receivers(:) = true;
            else
                i = 0;
                num = ceil(xintervals * yintervals/distributionFrequency);
                while i <= num
                    potentialRand = randi(xintervals);
                    potentialRand2 = randi(yintervals);
                    randRadius = randi(floor(sqrt(num)/3.14));
                    if(potentialRand - randRadius < 1)
                        startx = 1;
                    else
                        startx = potentialRand - randRadius;
                    end
                    if(potentialRand + randRadius > xintervals)
                        endingx = xintervals;
                    else
                        endingx = potentialRand + randRadius;
                    end
                    for j = startx:endingx
                        for k = potentialRand2 - ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2)))) : ...
                                potentialRand2 + ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2))))
                            if k > 0 && k < yintervals
                                if(~receivers(j,k))
                                    receivers(j,k) = true;
                                    i = i + 1;
                                end
                            end
                        end
                    end
                end
            end   
        
        
    end
end
%Receivers is the iteratable size matrix, bigReceivers holds when we need to
%access from the matrix with edges.
bigReceivers = false(xintervals + 2, yintervals + 2);
bigReceivers(2:end-1,2:end-1) = receivers;

%% Create cycle if relevant
%Cycle setup. In try catch so older tests still work
rotation = ones(sum(sum(receivers)), 1);
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
            rotation(1+floor(sum(sum(receivers))/cycleIntervals*(i-1)):floor(sum(sum(receivers))/cycleIntervals*i)) = i;
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
    for j = 1:yintervals
            if i == 1
                if(materialMatrix(i,j) == 1)
                    leftK(i,j) = thermal_Conductivity;
                else
                    leftK(i,j) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j) == 1 && materialMatrix(i-1,j) == 1)
                    leftK(i,j) = thermal_Conductivity;
                elseif materialMatrix(i,j) == 2 && materialMatrix(i-1,j) == 2
                    leftK(i,j) = thermal_Conductivity2;
                else
                    leftK(i,j) = interfaceK;
                end
            end
            if i == xintervals
                if(materialMatrix(i,j) == 1)
                    rightK(i,j) = thermal_Conductivity;
                else
                    rightK(i,j) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j) == 1 && materialMatrix(i+1,j) == 1)    
                    rightK(i,j) = thermal_Conductivity;
                elseif materialMatrix(i,j) == 2 && materialMatrix(i+1,j) == 2
                    rightK(i,j) = thermal_Conductivity2;
                else
                    rightK(i,j) = interfaceK;
                end
            end
            if j == 1
                if(materialMatrix(i,j) == 1)
                    upK(i,j) = thermal_Conductivity;
                else
                    upK(i,j) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j) == 1 && materialMatrix(i,j-1) == 1)    
                    upK(i,j) = thermal_Conductivity;
                elseif materialMatrix(i,j) == 2 && materialMatrix(i,j-1) == 2
                    upK(i,j) = thermal_Conductivity2;
                else
                    upK(i,j) = interfaceK;
                end
            end
            if j == yintervals
                if(materialMatrix(i,j) == 1)
                    downK(i,j) = thermal_Conductivity;
                else
                    downK(i,j) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j) == 1 && materialMatrix(i,j+1) == 1)    
                    downK(i,j) = thermal_Conductivity;
                elseif materialMatrix(i,j) == 2 && materialMatrix(i,j+1) == 2
                    downK(i,j) = thermal_Conductivity2;
                else
                    downK(i,j) = interfaceK;
                end
            end
    end
end

%The initial temperature grid is assigned.
wholeMatrix = zeros(xintervals + 2, yintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff
F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);
[X,Y] = meshgrid(dd/2:dd:ydist, dd/2:dd:xdist);

%% Create constants for radiation and convection
%Creates logicals that assign where the borders are. Corners have twice the
%area. Not meant to be accurate with single dimension sizes in this form.
if radiation || convection 
    boundaries = zeros(xintervals + 2, yintervals + 2,'logical');
    corners = boundaries;
    boundaries([2,end-1],2:end-1) = true;
    boundaries(2:end-1,[2,end-1]) = true;
    corners([2,end-1],[2,end-1]) = true;
    area = zeros(xintervals, yintervals);
    pBoundaries = boundaries(2:end-1,2:end-1);
    pCorners = corners(2:end-1,2:end-1);
    area(pBoundaries) = 1;
    area(pCorners) = 2;
    area = area + (xintervals == 1) + (yintervals == 1);
end

%If extra loss is turned on, that means we are treating it as
%thin, where heat loss is off all area.

%Ratios and room temperature constants set ahead of time for less
%calculation between timesteps.
if radiation
    if extraRadiation
        area = area + 2;
    end
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    rAir = rConst .* (roomTemp + 273.15)^4;
    if extraRadiation
        area = area - 2;
        midAreaR = 2 + (xintervals == 1) + (yintervals == 1);
        rMidConst = sigma .* emissivity .* constants(2:end-1,2:end-1) .* midAreaR .* dd;
        rMidAir = rMidConst .* (roomTemp + 273.15)^4;
    end
end

if convection
    if extraConvection
        area = area + 2;
    end
    convRatio = convecc .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    convAir = convRatio .* roomTemp;
    if extraConvection
        midAreaC = 2 + (xintervals == 1) + (yintervals == 1);
        convMidRatio = convecc .* constants(2:end-1,2:end-1) .* midAreaC .* dd;
        convMidAir = convMidRatio .* roomTemp;
    end
end


%%%

%% Iterate
% This is where the program iterates through time steps. The first time
% step is considered the initial values, and iter + 1 is the last. 
for j= 2:iter + 1
    if any(any(isnan(wholeMatrix)))
        text = strcat('Error at iteration ', num2str(j));
        disp(text);
        return
    end
    %Keep an older version so we aren't counting changes in the same time
    old = wholeMatrix(:,:);
    
    %If borders are on, we want no conduction off edges so we make the
    %edges the same temperature so there is no difference and so no
    %change
    if(borders)
        old(1,:) = old(2,:);
        old(end,:) = old(end-1,:);
        old(:,1) = old(:,2);
        old(:,end) = old(:,end-1);
    end
    %Use constants, thermal conductivity, and difference in temperatures
    %between pixels on the grid to calculate conductive transfer
    wholeMatrix(2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1) + ...
        ...
        (old(2:end-1, 1:end-2)-old(2:end-1,2:end-1)).*constants .* upK + ...
        (old(2:end-1,3:end)-old(2:end-1,2:end-1)).*constants .* downK + ...
        (old(1:end-2,2:end-1)-old(2:end-1,2:end-1)).*constants .* leftK + ...
        (old(3:end,2:end-1) - old(2:end-1,2:end-1)).*constants .* rightK;
    if ~borders && extraConduction
        wholeMatrix(2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1) - ...
            2.* old(2:end-1,2:end-1) .* constants .* k;
    end
    %Changes based on radiation
    if(radiation)        
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
        if extraRadiation
            wholeMatrix(3:end-2,3:end-2) = wholeMatrix(3:end-2,3:end-2) - ...
                (rMidConst .* ((old(3:end-2,3:end-2) + 273.15).^4)) + rMidAir;
        end
    end
    %Changes based on convection
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            ((old(boundaries) .* convRatio) - convAir);
        if convection && extraConvection
            wholeMatrix(3:end-2,3:end-2) = wholeMatrix(3:end-2,3:end-2) - ...
                ((old(3:end-2,3:end-2) .*convMidRatio) - convMidAir);
        end
    end
    
    %Increments by energy (turned into temp) if between the correct time
    %interval
    if j >= iterOn && j <= iterOff
        wholeMatrix(bigReceivers) = wholeMatrix(bigReceivers) + energyRate .* constants(receivers) ./ dd .* ratios(rotation)';
    end
    %If cycle/rotations are on, this will change
    if ~isempty(cycle) && cycle ~= 1 && mod(j - 1, cycleRate) == 0
        rotation = rotation + 1;
        rotation(rotation > cycleIntervals) = 1;
    end
    
    %Will graph/ save total energy and average temps at correct framerate checking multiplicity.
    if mod(j - 1, framerate) == 0 %Could alternatively be mod(j, framerate) == 1
        list(index) = sum(sum(wholeMatrix(2:end-1,2:end-1) ... %Total Energy
            ./ constants)) .* dt .* dd;
        tempsList(index) = mean(mean(wholeMatrix(2:end-1,2:end-1)));
        try
            figure;
            surfc(X,Y,wholeMatrix(2:end-1,2:end-1));
            caxis([0 (Tm + 20)])
            colorbar('horiz')
            %alpha(0.7);
            drawnow
            F(index) = getframe(gcf);
        catch
            disp('Cannot graph');
        end
        index = index + 1;
    end
end

%% Save final settings and play movie/display final frame
%Save final data frame in finalTemps
finalTemps = wholeMatrix(2:end-1,2:end-1);

%Will wait for user to give word, and will then close all windows, play the
%movie, and then show just the last screen.
pause
close all;
try
    fig = figure;
    movie(fig,F,1)
    close all;

    surf(X,Y,wholeMatrix(2:end-1,2:end-1));
    caxis([0 (Tm + 20)])
    colorbar('horiz')
catch
    disp('Cannot graph');
end

%Used in tests where we need to check what percent of the material melts in
%a given heating simulation. Checks over all materials at the Tm passed in.
melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);

end