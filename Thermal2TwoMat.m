function Thermal2TwoMat

global precision xdist ydist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2 extraConduction extraConvection extraRadiation;
clear global list;
global list;


digits(precision);
index = 1;


xintervals = floor(xdist / dd + 1);
yintervals = floor(ydist / dd + 1);
Tempgrid = zeros(xintervals, yintervals) + roomTemp;
midx = ceil(xintervals/2);
midy = ceil(yintervals/2);
switch elevLocation 
    case 1
        Tempgrid(midx, midy) = elevatedTemp;
    case 2
        Tempgrid(midx - ceil(midx/10): midx + ceil(midx/10),...
            midy - ceil(midy/10):midy + ceil(midy/10)) = elevatedTemp;
    case 3
        xfreq = ceil(sqrt(elevFrequency));
        yfreq = floor(elevFrequency/xfreq);
        Tempgrid(1:xfreq:end,1:yfreq:end) = elevatedTemp;
end


iter = total_time/dt;
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end
constants = ones(xintervals, yintervals) .* dt ./ (specific_heat .* dd .* dd .* density);
materialMatrix = ones(xintervals, yintervals);
k = ones(xintervals, yintervals) * thermal_Conductivity;
leftK = ones(xintervals, yintervals);
rightK = ones(xintervals, yintervals);
upK = ones(xintervals, yintervals);
downK = ones(xintervals, yintervals);
second = zeros(xintervals,yintervals);

switch distribution
    case 1
        second(midx, midy) = 1;
    case 2
        second(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10)) = 1;
    case 3
        freq = sqrt(frequency2);
        second(ceil(1:freq:end),ceil(1:freq:end)) = 1;
    case 4
        if frequency2 <= 1.1
            second(:,:) = 1;
        else
            i = 1;
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
        if frequency2 <= 1.1
            second(:) = 1;
        else
            i = 0;
            num = ceil(xintervals * yintervals/frequency2);
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
second = logical(second);
bigSecond = zeros(xintervals + 2, yintervals + 2);
bigSecond = logical(bigSecond);
bigSecond(2:end-1, 2:end-1) = second;
constants(second) = dt / (specific_heat2 * dd * dd * density2);
materialMatrix(second) = 2;
k(second) = thermal_Conductivity2;

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
                    leftK(i,j) = thermal_Conductivity;
                else
                    leftK(i,j) = thermal_Conductivity2;
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

wholeMatrix = zeros(xintervals + 2, yintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff

clear F;
F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);
[X,Y] = meshgrid(0:dd:ydist, 0:dd:xdist);

if(radiation || convection)
    boundaries = zeros(xintervals + 2, yintervals + 2);
    corners = boundaries;
    boundaries([2,end-1],2:end-1) = 1;
    boundaries(2:end-1,[2,end-1]) = 1;
    boundaries = logical(boundaries);
    corners([2,end-1],[2,end-1]) = 1;
    corners = logical(corners);
    area = zeros(xintervals, yintervals);
    %g(boundaries).('area') = 1;
    %g(corners).('area')= 2;
    pBoundaries = boundaries(2:end-1,2:end-1);
    pCorners = corners(2:end-1,2:end-1);
    area(pBoundaries) = 1;
    area(pCorners) = 2;
end

if extraRadiation
    area = area + 2;
end
if(radiation)
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if extraRadiation
    area = area - 2;
end
if extraConvection
    area = area + 2;
end
if(convection)
    convRatio = 20 .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    convAir = convRatio .* roomTemp;
end


%%%



for j= 2:iter + 1
    if any(any(isnan(wholeMatrix)))
        text = strcat('Error at iteration ', num2str(j));
        disp(text);
        return
    end
    old = wholeMatrix(:,:);
    if(borders)
        old(1,:) = old(2,:);
        old(end,:) = old(end-1,:);
        old(:,1) = old(:,2);
        old(:,end) = old(:,end-1);
    end
    
    wholeMatrix(2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1) + ...
        ...
        (old(2:end-1, 1:end-2)-old(2:end-1,2:end-1)).*constants .* upK + ...
        (old(2:end-1,3:end)-old(2:end-1,2:end-1)).*constants .* downK + ...
        (old(1:end-2,2:end-1)-old(2:end-1,2:end-1)).*constants .* leftK + ...
        (old(3:end,2:end-1) - old(2:end-1,2:end-1)).*constants .* rightK;
    if extraConduction
        wholeMatrix(2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1) + ...
            old(2:end-1,2:end-1) .* constants .* k;
    end
    if(radiation)        
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
    end
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            ((old(boundaries) .* convRatio) - convAir);
    end
    if j >= iterOn && j <= iterOff
        if materials == 3
            wholeMatrix(bigSecond) = wholeMatrix(bigSecond) + energyRate .* constants(second);
        else
           switch absorption
                case 1
                    wholeMatrix(midx,midy) = wholeMatrix(midx,midy) + energyRate .* constants(midx,midy);
                case 2
                    wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10)) = wholeMatrix(midx - ceil(midx/10): midx + ...
                        ceil(midx/10), midy - ceil(midy/10): midy + ceil(midy/10)) + ...
                        energyRate .* constants(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10));
                case 3
                    frequ = sqrt(distributionFrequency);
                    wholeMatrix(ceil(2:frequ:end-1),ceil(2:frequ:end-1)) = wholeMatrix(ceil(2:frequ:end-1),ceil(2:frequ:end-1)) ...
                        + energyRate .* constants(ceil(2:frequ:end-1),ceil(2:frequ:end-1));
                    
           end
        end
    end
    
    if mod(j - 1, framerate) == 0
        list(index) = mean(mean(wholeMatrix(2:end-1,2:end-1) ... %Energy per meter
            ./ constants .* dt));
        figure;
        surfc(X,Y,wholeMatrix(2:end-1,2:end-1));
        caxis([0 (Tm + 20)])
        colorbar('horiz')
        %alpha(0.7);
        drawnow
        F(index) = getframe(gcf);
        index = index + 1;
        %mean(mean(wholeMatrix(2:end-1,2:end-1)))
    end
end

%After creating all the slides, will pause and let you analyze
%variables. Then press a key and it will play the movie twice and end on
%the last frame.
mean(mean(wholeMatrix(2:end-1,2:end-1) ...
            ./ constants .* dt)); %Energy per meter 
pause
close all;
fig = figure;
movie(fig,F,1)
close all;

surf(X,Y,wholeMatrix(2:end-1,2:end-1));
caxis([0 (Tm + 20)])
colorbar('horiz')

melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);
list
end