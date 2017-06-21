%% Initialize globals
%Globals allow this to carry over from set-up functions. They are used
%instead of persistent so that they can be used in the command frame if
%necessary.
global precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2 cycle cycleIntervals cycleSpeed isotherm convecc saveMovie melting Tm2 graph;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rng('default'); %This can be used to make the randomized distributions
%consistent for repeatability
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
Tempgrid = zeros(xintervals, yintervals, zintervals) + roomTemp;
% switch elevLocation 
%     case 1
%         Tempgrid(midx, midy, midz) = elevatedTemp;
%     case 2
%         Tempgrid(midx - ceil(midx/10): midx + ceil(midx/10),...
%             midy - ceil(midy/10):midy + ceil(midy/10), ...
%             midz - ceil(midz/10):midz + ceil(midz/10)) = elevatedTemp;
%     case 3
%         xfreq = ceil(nthroot(elevFrequency,3));
%         yfreq = floor(sqrt(elevFrequency/xfreq));
%         zfreq = ceil(elevFrequency/(xfreq * yfreq));
%         
%         Tempgrid(1:xfreq:end,1:yfreq:end,1:zfreq:end) = elevatedTemp;
% end

%%%% Declare materialMatrix here

materialMatrix = int8(zeros(xintervals, yintervals, zintervals));


%First fiber
materialMatrix(midx-1:midx+1,1:yintervals,2:10) = 1;
materialMatrix([midx - 2, midx + 2], 1:yintervals, 3:9) = 1;
materialMatrix([midx - 3, midx + 3], 1:yintervals, 4:8) = 1;
materialMatrix([midx - 4, midx + 4], 1:yintervals, 5:7) = 1;

materialMatrix(midx, 1:yintervals, 5:7) = 3;
materialMatrix([midx + 1, midx - 1], 1:yintervals, 6) = 3;

%Second fiber
materialMatrix(1:xintervals, midy-1:midy+1,10:18) = 1;
materialMatrix(1:xintervals, [midy - 2, midy + 2], 11:17) = 1;
materialMatrix(1:xintervals, [midy - 3, midy + 3], 12:16) = 1;
materialMatrix(1:xintervals, [midy - 4, midy + 4], 13:15) = 1;

materialMatrix(1:xintervals, midy, 13:15) = 3;
materialMatrix(1:xintervals, [midy + 1, midy - 1], 14) = 3;
boundsSum = (materialMatrix(1:end-2,2:end-1,2:end-1) + ...
    materialMatrix(3:end,2:end-1,2:end-1) + materialMatrix(2:end-1,1:end-2,2:end-1) + ...
    materialMatrix(2:end-1,3:end,2:end-1) + materialMatrix(2:end-1,2:end-1,1:end-2) + ...
    materialMatrix(2:end-1,2:end-1,3:end) );
bounds = boundsSum > 1 & boundsSum < 5; %Right now it can replace air or can replace the very edge PE.
bigBounds = zeros(xintervals, yintervals, zintervals);
bigBounds(2:end-1,2:end-1,2:end-1) = bounds;
bigBounds = logical(bigBounds);
receptorLocation = materialMatrix(bigBounds);
i = 1;
%Fills until the ratio is fulfilled.
while i <= ceil(size(receptorLocation,1)/frequency2)
    potentialRand = randi(size(receptorLocation,1));
    if(receptorLocation(potentialRand) ~= 7)
        receptorLocation(potentialRand) = 7;
        i = i + 1;
    end
end
materialMatrix(bigBounds) = receptorLocation;


specific_heat = 1900;
density = 960;
thermal_Conductivity = 0.51;
specific_heat2 = 4130;
density2  = 2600;
thermal_Conductivity2 = 2.5;
specific_heat3 = 1800;
density3 = 920;
thermal_Conductivity3 = 120;
interfaceK13 = 60;
interfaceK12 = 1;
interfaceK23 = 60;




leftK = ones(xintervals, yintervals,zintervals);
rightK = ones(xintervals, yintervals,zintervals);
upK = ones(xintervals, yintervals,zintervals);
downK = ones(xintervals, yintervals,zintervals);
inK = ones(xintervals, yintervals,zintervals);
outK = ones(xintervals, yintervals,zintervals);


constantArray = zeros(8,1);
constantArray(2) = dt ./ (specific_heat .* dd .* dd .* density); %PP
constantArray(4) = dt ./ (specific_heat3 .* dd .* dd .* density3); %PE
constantArray(8) = dt ./ (specific_heat2 .* dd .* dd .* density2); % Receptor
constants = constantArray(materialMatrix(:,:,:) + 1);
kArray = zeros(15,1);
kArray(3) = thermal_Conductivity;
kArray(5) = interfaceK12;
kArray(7) = thermal_Conductivity2;
kArray(9) = interfaceK13;
kArray(11) = interfaceK23;
kArray(15) = thermal_Conductivity3;
k = kArray(materialMatrix(:,:,:) + 1);


k = k .* 10;


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



%%%
% Material 0: Air, Material 1: HDPE, Material 3: PP, Material 7: Receptor,
%
% Combinations: 0: Air-Air, 1: HDPE- Air, 2: HDPE-HDPE, 3: PP-Air, 4:
% PP-HDPE, 6: PP-PP, 7: Receptor-Air, 8: Receptor-HDPE, 11: Receptor-PP,
% 14: Receptor-Receptor
%
%
%
%
%%%

second = logical(materialMatrix(:,:,:) == 7);
bigSecond = zeros(xintervals + 2, yintervals + 2,zintervals + 2);
bigSecond = logical(bigSecond);
bigSecond(2:end-1, 2:end-1,2:end-1) = second;
constants(second) = dt / (specific_heat2 * dd * dd * density2);
k(second) = thermal_Conductivity2;

receivers = second;
bigReceivers = zeros(xintervals + 2, yintervals + 2,zintervals + 2);
bigReceivers = logical(bigReceivers);
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


for i = 1:xintervals
    for j = 1:yintervals
        for l = 1:zintervals
            if i ~= 1
                switch materialMatrix(i,j,l) + materialMatrix(i-1,j,l)
                    
                    case 2
                        leftK(i,j,l) = thermal_Conductivity; %PE with PE
                    case 4
                        leftK(i,j,l) = -1; %PP with PE
                    case 6
                        leftK(i,j,l) = thermal_Conductivity3; %PP with PP
                    case 8
                        leftK(i,j,l) = interfaceK; %PE with Receptor
                    case 10
                        leftK(i,j,l) = -1; %PP with receptor
                    case 14
                        leftK(i,j,l) = thermal_Conductivity2; %Receptor with Receptor
%                     otherwise
%                         leftK(i,j,l) = 0;
% Default is leave it at 0
                    
                end
            end
            if i ~= xintervals
                switch materialMatrix(i,j,l) + materialMatrix(i+1,j,l)
                    
                    case 2
                        rightK(i,j,l) = thermal_Conductivity; %PE with PE
                    case 4
                        rightK(i,j,l) = -1; %PP with PE
                    case 6
                        rightK(i,j,l) = thermal_Conductivity3; %PP with PP
                    case 8
                        rightK(i,j,l) = interfaceK; %PE with Receptor
                    case 10
                        rightK(i,j,l) = -1; %PP with receptor
                    case 14
                        rightK(i,j,l) = thermal_Conductivity2; %Receptor with Receptor
%                     otherwise
%                         rightK(i,j,l) = 0;
                    
                end
            end
            if j ~= 1
                switch materialMatrix(i,j,l) + materialMatrix(i,j-1,l)
                    
                    case 2
                        upK(i,j,l) = thermal_Conductivity; %PE with PE
                    case 4
                        upK(i,j,l) = -1; %PP with PE
                    case 6
                        upK(i,j,l) = thermal_Conductivity3; %PP with PP
                    case 8
                        upK(i,j,l) = interfaceK; %PE with Receptor
                    case 10
                        upK(i,j,l) = -1; %PP with receptor
                    case 14
                        upK(i,j,l) = thermal_Conductivity2; %Receptor with Receptor
%                     otherwise
%                         upK(i,j,l) = 0;
                    
                end
            end
            if j ~= yintervals
                switch materialMatrix(i,j,l) + materialMatrix(i,j+1,l)
                    
                    case 2
                        downK(i,j,l) = thermal_Conductivity; %PE with PE
                    case 4
                        downK(i,j,l) = -1; %PP with PE
                    case 6
                        downK(i,j,l) = thermal_Conductivity3; %PP with PP
                    case 8
                        downK(i,j,l) = interfaceK; %PE with Receptor
                    case 10
                        downK(i,j,l) = -1; %PP with receptor
                    case 14
                        downK(i,j,l) = thermal_Conductivity2; %Receptor with Receptor
%                     otherwise
%                         downK(i,j,l) = 0;
                    
                end
            end
            if l ~= 1
                switch materialMatrix(i,j,l) + materialMatrix(i,j,l-1)
                    
                    case 2
                        inK(i,j,l) = thermal_Conductivity; %PE with PE
                    case 4
                        inK(i,j,l) = -1; %PP with PE
                    case 6
                        inK(i,j,l) = thermal_Conductivity3; %PP with PP
                    case 8
                        inK(i,j,l) = interfaceK; %PE with Receptor
                    case 10
                        inK(i,j,l) = -1; %PP with receptor
                    case 14
                        inK(i,j,l) = thermal_Conductivity2; %Receptor with Receptor
%                     otherwise
%                         inK(i,j,l) = 0;
                    
                end
            end
            if l ~= zintervals
                switch materialMatrix(i,j,l) + materialMatrix(i,j,l+1)
                    
                    case 2
                        outK(i,j,l) = thermal_Conductivity; %PE with PE
                    case 4
                        outK(i,j,l) = -1; %PP with PE
                    case 6
                        outK(i,j,l) = thermal_Conductivity3; %PP with PP
                    case 8
                        outK(i,j,l) = interfaceK; %PE with Receptor
                    case 10
                        outK(i,j,l) = -1; %PP with receptor
                    case 14
                        outK(i,j,l) = thermal_Conductivity2; %Receptor with Receptor
%                     otherwise
%                         outK(i,j,l) = 0;
                    
                end
            end
        end
    end
end


%The initial temperature grid is assigned.
wholeMatrix = zeros(xintervals + 2, yintervals + 2, zintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff
F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);
[X,Y,Z] = meshgrid(dd/2:dd:ydist, dd/2:dd:xdist, dd/2:dd:zdist);

%Melting Stuff
melted = false(xintervals,yintervals, zintervals);

%% Create constants for radiation and convection
%Creates logicals that assign where the borders are. Edges have twice the
%area, and corners triple. Not meant to be accurate with single dimension
%sizes in this form.
if radiation || convection
    area = (upK == 0) + (downK == 0) + (leftK == 0) + (rightK == 0);
    pBoundaries = (area ~= 0);
    boundaries = falses(xintervals, yintervals, zintervals));
    boundaries(2:end-1,2:end-1,2:end-1) = pBoundaries;
end

%Ratios and room temperature constants set ahead of time for less
%calculation between timesteps.
if radiation
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    rAir = rConst .* (roomTemp + 273.15).^4;
end
if convection
    convRatio = convecc .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    convAir = convRatio .* roomTemp;
end

%%%

%% Iterate
% This is where the program iterates through time steps. The first time
% step is considered the initial values, and iter + 1 is the last. 
for j= 2:iter + 1
    if any(any(any(isnan(wholeMatrix))))
        text = strcat('Error at iteration ', num2str(j));
        disp(text);
        return
    end
    %Keep an older version so we aren't counting changes in the same time
    old = wholeMatrix(:,:,:);
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

    
    if radiation      
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
    end
    if convection
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            ((old(boundaries) .* convRatio) - convAir);
    end
    
    %Increments by energy (turned into temp) if between the correct time
    %interval
    if j >= iterOn && j <= iterOff
        wholeMatrix(bigReceivers) = wholeMatrix(bigReceivers) + energyRate .* constants(receivers) .* dd .* ratios(rotation)';
    end
    %If cycle/rotations are on, this will change
    if ~isempty(cycle) && cycle ~= 1 && mod(j - 1, cycleRate) == 0
        rotation = rotation + 1;
        rotation(rotation > cycleIntervals) = 1;
    end
    
    %Will graph/ save total energy/ average temps at correct framerate.
    if mod(j - 1, framerate) == 0
        list(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1) ... %Energy
            ./ constants .* dt .* dd)));
        tempsList(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1))));
        if graph
            try
                if isotherm
                    isosurfacePlot(wholeMatrix(2:end-1,2:end-1,2:end-1));
                    view(3)
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
finalTemps = wholeMatrix(2:end-1,2:end-1,2:end-1);

%Will wait for user to give word, and will then close all windows, play the
%movie, and then show just the last screen.
if graph
    pause
    close all;
    fig = figure;
    movie(fig,F,1);
    close all;

    try
        if isotherm
            isosurfacePlot(wholeMatrix(2:end-1,2:end-1,2:end-1));
            view(3);
            hold on;
            s = slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
            alpha(s, 0.3);
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
    num = numel(Tempgrid);
    ratio = sum(sum(sum(melted)))/num;

    fprintf('Ratio Melted = %d / %d = %g = %g%%\n', sum(sum(sum(melted))), num, ratio, ratio*100);
end
