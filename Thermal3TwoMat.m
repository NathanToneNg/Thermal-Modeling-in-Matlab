function Thermal3TwoMat
%% Initialize globals
%Globals allow this to carry over from set-up functions. They are used
%instead of persistent so that they can be used in the command frame if
%necessary.
global precision xdist ydist zdist dd total_time dt framerate convection radiation ...
    specific_heat density Tm roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2 cycle cycleIntervals cycleSpeed isotherm convecc saveMovie melting Tm2 graph ...
    bottomLoss initialGrid topCheck depth heating roomTempFunc finalGrid consistent gradientPlot;
clear global list;
clear global tempsList;
clear global materialMatrix;
global list tempsList materialMatrix; %Results
if topCheck
    clear global topTemps
    global topTemps
end
if isempty(cycle)
    cycle = 1;
end
if isempty(convecc)
    convecc = 20;
end
if isempty(isotherm)
    isotherm = false;
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
if isempty(bottomLoss)
    bottomLoss = true;
end
if isempty(initialGrid)
    initialGrid = false;
end
if isempty(heating)
    heating = false;
end
if isempty(gradientPlot)
    gradientPlot = 0;
end
global histogramPlot
if ~isempty(histogramPlot)
    if histogramPlot
        gradientPlot = 1;
    else
        gradientPlot = 2;
    end
    clear global histogramPlot
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(consistent) && consistent
    rng('default'); %This can be used to make the randomized distributions consistent
end

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
zintervals = floor(zdist / dd);


midx = ceil(xintervals/2);
midy = ceil(yintervals/2);
midz = ceil(zintervals/2);

xslice = (ceil((xintervals-1)/2) * dd); %Locations to graph
yslice = (ceil((yintervals-1)/2) * dd);
zslice = (ceil((zintervals-1)/2) * dd);

%% Create initial temperatures
%This creates a temporary grid of which pixels start at higher temperature
if heating
    Tempgrid = zeros(xintervals, yintervals, zintervals) + roomTempFunc(0);
else
    Tempgrid = zeros(xintervals, yintervals, zintervals) + roomTemp;
end
switch elevLocation 
    case 1
        %Center ixel
        Tempgrid(midx, midy, midz) = elevatedTemp;
    case 2
        %Center block, 1/5 in each direction
        Tempgrid(midx - ceil(midx/10): midx + ceil(midx/10),...
            midy - ceil(midy/10):midy + ceil(midy/10), ...
            midz - ceil(midz/10):midz + ceil(midz/10)) = elevatedTemp;
    case 3
        %Uniform distribution
        if elevFrequency <= 1.05
            Tempgrid(:,:,:) = elevatedTemp;
        else
            Tempgrid(round(1:elevFrequency:xintervals * yintervals * zintervals)) = elevatedTemp;
        end
%         xfreq = ceil(nthroot(elevFrequency,3));
%         yfreq = floor(sqrt(elevFrequency/xfreq));
%         zfreq = ceil(elevFrequency/(xfreq * yfreq));
%         
%         Tempgrid(1:xfreq:end,1:yfreq:end,1:zfreq:end) = elevatedTemp;
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
if absorption
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

%% Create relevant constants
%Holds a grid of constants so that less calculations need to be repeated.
constants = ones(xintervals, yintervals,zintervals) .* dt ./ (specific_heat .* dd .* dd .* density);
insertion = ones(xintervals, yintervals, zintervals) .* dt ./ specific_heat;
materialMatrix = int8(ones(xintervals, yintervals,zintervals));

%Holds the thermal conductivities at each pixel in each direction.
leftK = zeros(xintervals, yintervals,zintervals);
rightK = zeros(xintervals, yintervals,zintervals);
upK = zeros(xintervals, yintervals,zintervals);
downK = zeros(xintervals, yintervals,zintervals);
inK = zeros(xintervals, yintervals,zintervals);
outK = zeros(xintervals, yintervals,zintervals);
kArray = zeros(7,1);
kArray(3) = thermal_Conductivity; %Mat 1 with Mat 1
kArray(5) = interfaceK; %Mat 1 with Mat 2
kArray(7) = thermal_Conductivity2; %Mat 2 with Mat 2


%% Create materials grid
%Declare where the second material is based on parameter "distribution" and
%the frequencies
second = false(xintervals,yintervals,zintervals);
switch distribution
    case 1
        %Center pixel
        second(midx, midy, midz) = true;
    case 2
        %Center block (5th of size in each direction)
        second(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(midz/10)) = true;
    case 3
        %Uniform distribution
        if frequency2 <= 1.05
            second(:,:,:) = true;
        else
            second(round(1:frequency2:xintervals * yintervals * zintervals)) = true;
        end
%         freq = nthroot(frequency2, 3);
%         second(ceil(1:freq:xintervals),ceil(1:freq:yintervals),ceil(1:freq:zintervals)) = true;
    case 4
        %Random distribution
        if frequency2 <= 1.05
            second(:,:,:) = true;
        else
            i = 1;
            %Fills until the ratio is fulfilled.
            while i <= ceil(xintervals*yintervals*zintervals/frequency2)
                potentialRand = randi(xintervals);
                potentialRand2 = randi(yintervals);
                potentialRand3 = randi(zintervals);
                if(~second(potentialRand,potentialRand2,potentialRand3))
                    second(potentialRand,potentialRand2,potentialRand3) = true;
                    i = i + 1;
                end
            end
        end
     case 5
         %Random spheres
        if frequency2 <= 1.05
            second(:) = true;
        else
            i = 0;
            num = ceil(xintervals * yintervals * zintervals/frequency2);
            %Fills until the ratio is fulfilled
            while i <= num
                potentialRand = randi(xintervals);
                potentialRand2 = randi(yintervals);
                potentialRand3 = randi(zintervals);
                %Picks a random radius, and then random center after
                randRadius = randi(floor(nthroot(num,3)/(4*3.14/3)));
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
                    for k = potentialRand2 - floor(sqrt(((randRadius^2) - ((potentialRand - j)^2)))) : ...
                            potentialRand2 + floor(sqrt(((randRadius^2) - ((potentialRand - j)^2))))
                        if k > 0 && k < yintervals
                            for l = potentialRand3 - ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2) - ((potentialRand2 - k)^2)))) : ...
                            potentialRand3 + ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2) - ((potentialRand2 - k)^2))))
                                if l > 0 && l < zintervals
                                    if(~second(j,k,l))
                                        second(j,k,l) = true;
                                        i = i + 1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
end

%essentially gives the heat capacity constant used for most calculations
constants(second) = dt / (specific_heat2 * dd * dd * density2);
insertion(second) = dt / specific_heat2;
materialMatrix(second) = 3;
Tms = ones(xintervals, yintervals, zintervals) .* Tm;
Tms(second) = Tm2;

%Determine where the receiver materials are. Same possibilities as for
%second material.
if materials == 3
    receivers = second;
else
    receivers = false(xintervals, yintervals, zintervals);
    switch absorption
        case 1
            receivers(midx, midy, midz) = true;
        case 2
            receivers(midx - ceil(midx/10): midx + ceil(midx/10), midy - ...
                ceil(midy/10): midy + ceil(midy/10), midz - ceil(midz/10): midz + ceil(midz/10)) = true;
        case 3
            if distributionFrequency <= 1.05
                receivers(:,:,:) = true;
            else
                receivers(round(1:distributionFrequency:xintervals * yintervals * zintervals)) = true;
            end
%             frequ = nthroot(distributionFrequency,3);
%             receivers(ceil(1:frequ:xintervals),ceil(1:frequ:yintervals), ceil(1:frequ:zintervals)) = true;
        case 4
            if distributionFrequency <= 1.05
                receivers(:,:,:) = true;
            else
                i = 1;
                while i <= ceil(xintervals*yintervals*zintervals/distributionFrequency)
                    potentialRand = randi(xintervals);
                    potentialRand2 = randi(yintervals);
                    potentialRand3 = randi(zintervals);
                    if(~receivers(potentialRand,potentialRand2,potentialRand3))
                        receivers(potentialRand,potentialRand2,potentialRand3) = true;
                        i = i + 1;
                    end
                end
            end
         case 5
            if distributionFrequency <= 1.05
                receivers(:) = true;
            else
                i = 0;
                num = ceil(xintervals * yintervals * zintervals/distributionFrequency);
                while i <= num
                    potentialRand = randi(xintervals);
                    potentialRand2 = randi(yintervals);
                    potentialRand3 = randi(zintervals);
                    randRadius = randi(floor(nthroot(num,3)/(4*3.14/3)));
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
                        for k = potentialRand2 - floor(sqrt(((randRadius^2) - ((potentialRand - j)^2)))) : ...
                                potentialRand2 + floor(sqrt(((randRadius^2) - ((potentialRand - j)^2))))
                            if k > 0 && k < yintervals
                                for l = potentialRand3 - ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2) - ((potentialRand2 - k)^2)))) : ...
                                potentialRand3 + ceil(sqrt(((randRadius^2) - ((potentialRand - j)^2) - ((potentialRand2 - k)^2))))
                                    if l > 0 && l < zintervals
                                        if(~receivers(j,k,l))
                                            receivers(j,k,l) = true;
                                            i = i + 1;
                                        end
                                    end
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
bigReceivers = false(xintervals + 2, yintervals + 2,zintervals + 2);
bigReceivers(2:end-1,2:end-1,2:end-1) = receivers;

%% Create cycle if relevant
%Cycle setup. In try catch so older tests still work
rotation = ones(sum(sum(sum(receivers))), 1);
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
            rotation(1+floor(sum(sum(sum(receivers)))/cycleIntervals*(i-1)):floor(sum(sum(sum(receivers)))/cycleIntervals*i)) = i;
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
        for l = 1:zintervals
            if i ~= 1
                leftK(i,j,l) = kArray(materialMatrix(i,j,l) + materialMatrix(i-1,j,l)+1);
%           else
%               leftK(i,j,l) = 0;
            end
            if i ~= xintervals
                rightK(i,j,l) = kArray(materialMatrix(i,j,l) + materialMatrix(i+1,j,l) + 1);
            end
            if j ~= 1
                upK(i,j,l) = kArray(materialMatrix(i,j,l) + materialMatrix(i,j-1,l) + 1);
            end
            if j ~= yintervals
                downK(i,j,l) = kArray(materialMatrix(i,j,l) + materialMatrix(i,j+1,l) + 1);
            end
            if l ~= 1
                inK(i,j,l) = kArray(materialMatrix(i,j,l) + materialMatrix(i,j,l-1) + 1);
            end
            if l ~= zintervals
                outK(i,j,l) = kArray(materialMatrix(i,j,l) + materialMatrix(i,j,l+1) + 1);
            end
        end
    end
end


%The initial temperature grid is assigned.
wholeMatrix = zeros(xintervals + 2, yintervals + 2, zintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff
F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);
[X,Y,Z] = meshgrid(dd/2:dd:xdist, dd/2:dd:ydist, dd/2:dd:zdist);
X = X(1:xintervals, 1:yintervals, 1:zintervals);
Y = Y(1:xintervals, 1:yintervals, 1:zintervals);
Z = Z(1:xintervals, 1:yintervals, 1:zintervals);

%Melting Stuff
melted = false(xintervals,yintervals, zintervals);

%% Create constants for radiation and convection
%Creates logicals that assign where the borders are. Edges have twice the
%area, and corners triple. Not meant to be accurate with single dimension
%sizes in this form.

if radiation || convection
    area = (upK == 0) + (inK == 0) + (downK == 0) + (outK == 0) + (leftK == 0) + (rightK == 0);
    pBoundaries = (area ~= 0);
    boundaries = false(xintervals + 2, yintervals + 2, zintervals + 2);
    boundaries(2:end-1,2:end-1,2:end-1) = pBoundaries;
    if ~bottomLoss
        area(:,:,1) = area(:,:,1) - (area(:,:,1) > 0);
    end
end

%Ratios and room temperature constants set ahead of time for less
%calculation between timesteps.
if radiation
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    if ~heating
        rAir = rConst .* (roomTemp + 273.15).^4;
    end
end
if convection
    convRatio = convecc .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    if ~heating
        convAir = convRatio .* roomTemp;
    end
end


%%%

%% Iterate
% This is where the program iterates through time steps. The first time
% step is considered the initial values, and iter + 1 is the last. 
for j= 2:iter + 1
    if any(any(any(isnan(wholeMatrix))))
        error('Error at iteration %d', j);
    end
    %Keep an older version so we aren't counting changes in the same time
    old = wholeMatrix;
    
    %Use constants, thermal conductivity, and difference in temperatures
    %between pixels on the grid to calculate conductive transfer
    wholeMatrix(2:end-1, 2:end-1,2:end-1) = wholeMatrix(2:end-1, 2:end-1,2:end-1) + ...
        ...
        (old(2:end-1, 1:end-2,2:end-1)-old(2:end-1,2:end-1,2:end-1)) ...
            .*constants .* upK + ...
        (old(2:end-1,3:end,2:end-1)-old(2:end-1,2:end-1,2:end-1))...
            .*constants .* downK + ...
        (old(1:end-2,2:end-1,2:end-1)-old(2:end-1,2:end-1,2:end-1))...
            .*constants .* leftK + ...
        (old(3:end,2:end-1,2:end-1) - old(2:end-1,2:end-1,2:end-1))...
            .*constants .* rightK + ...
        (old(2:end-1,2:end-1,1:end-2) - old(2:end-1,2:end-1,2:end-1)) ...
            .*constants .* inK + ...
        (old(2:end-1,2:end-1,3:end) - old(2:end-1,2:end-1,2:end-1)) ...
            .*constants .* outK;
    %Changes based on radiation
    if radiation
        if heating
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                (rConst .* (((old(boundaries) + 273.15).^4) - ...
                (roomTempFunc(j * dt) + 273.15).^4));
        else
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
        end
    end
    %Changes based on convection
    if convection
        if heating
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                ((old(boundaries) - roomTempFunc(j * dt)) .* convRatio);
        else
            wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
                ((old(boundaries) .* convRatio) - convAir);
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
        list(index) = sum(sum(sum(wholeMatrix(2:end-1,2:end-1,2:end-1) ... %Total Energy
            ./ constants))) .* dt .* dd;
        tempsList(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1))));
        if ~isempty(topCheck) && topCheck
            topTemps(index) = getTop(wholeMatrix(2:end-1,2:end-1,2:end-1),depth);
        end
        if graph
            try
                if gradientPlot == 1
                    if j == 2
                        figure;
                    end
                    hold on;
                    eval(sprintf('h%d = histogram(wholeMatrix(2:end-1,2:end-1,2:end-1));',j));
                    alpha(0.5);
                    eval(sprintf('h%d.FaceColor = [(j / (iter + 1)) (j / (iter + 1)) (1-(j / (iter + 1)))];',j));
                    [sizes, ~] = histcounts(wholeMatrix(2:end-1,2:end-1,2:end-1));
                    ylim([0 max(sizes)*1.05 ]);
                elseif gradientPlot == 2
                    if j == 2
                        figure;
                    end
                    hold on;
                    if j ~= iter + 1
                        color = [(j / (iter + 1)) (1-(j / (iter + 1))) (1 - (j / (iter + 1)))];
                    else
                        color = [1 0 0];
                    end
                    depthGradientPlot(wholeMatrix(2:end-1,2:end-1,2:end-1), color);
                elseif isotherm
                    isosurfacePlot(wholeMatrix(2:end-1,2:end-1,2:end-1));
                else
                    figure;
                    slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
                    caxis([0 (Tm + 20)])
                    colorbar('horiz')
                end
                drawnow
                F(index) = getframe(gcf);
            catch
                disp('Cannot graph');
            end
        end
        index = index + 1;
        if melting
            melted = anyMeltingIter(wholeMatrix(2:end-1,2:end-1,2:end-1),melted,Tms);
        end
    end
end

%% Save final settings and play movie/display final frame
%Save final data frame in finalTemps
if ~isempty(finalGrid) && finalGrid
    clear global finalTemps
    global finalTemps
    finalTemps = wholeMatrix(2:end-1,2:end-1,2:end-1);
end
%Will wait for user to give word, and will then close all windows, play the
%movie, and then show just the last screen.
if graph
    pause
    close all;
    try
        fig = figure;
        movie(fig,F,1);
    catch
        disp('Cannot create movie');
    end
    close all;

    try
        if gradientPlot == 1
            if j == 2
                figure;
            end
            hold on;
            eval(sprintf('h%d = histogram(wholeMatrix(2:end-1,2:end-1,2:end-1));',j));
            alpha(0.5);
            eval(sprintf('h%d.FaceColor = [(j / (iter + 1)) (j / (iter + 1)) (1-(j / (iter + 1)))];',j));
            [sizes, ~] = histcounts(wholeMatrix(2:end-1,2:end-1,2:end-1));
            ylim([0 max(sizes)*1.05 ]);
        elseif gradientPlot == 2
            if j == 2
                figure;
            end
            hold on;
            color = [1 0 0];
            depthGradientPlot(wholeMatrix(2:end-1,2:end-1,2:end-1), color);
        elseif isotherm
            isosurfacePlot(wholeMatrix(2:end-1,2:end-1,2:end-1));
            view(3);
            hold on;
            s = slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
            alpha(s, 0.3);
            caxis([0 (Tm + 20)])
            colorbar('horiz')
        else
            slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
            caxis([0 (Tm + 20)])
            colorbar('horiz')
        end
    catch
        disp('Cannot graph');
    end
    if saveMovie
        v = VideoWriter('recentTestMovie');
        v.open;
        v.writeVideo(F)
        v.close;
    end
end
%Used in tests where we need to check what percent of the material melts in
%a given heating simulation. Checks over all materials at the Tm passed in.
if melting
    num = xintervals * yintervals * zintervals;
    ratio = sum(sum(sum(melted)))/num;

    fprintf('Ratio Melted = %d / %d = %g = %g%%\n', sum(sum(sum(melted))), num, ratio, ratio*100);
end

end