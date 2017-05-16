function Thermal3TwoMat

global precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2;
global list;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



digits(precision);
index = 1;


xintervals = floor(xdist / dd + 1);
yintervals = floor(ydist / dd + 1);
zintervals = floor(zdist / dd + 1);
Tempgrid = zeros(xintervals, yintervals, zintervals) + roomTemp;

midx = ceil(xintervals/2);
midy = ceil(yintervals/2);
midz = ceil(zintervals/2);

xslice = (ceil((xintervals-1)/2) * dd); %Locations to graph
yslice = (ceil((yintervals-1)/2) * dd);
zslice = (ceil((zintervals-1)/2) * dd);

switch elevLocation 
    case 1
        Tempgrid(midx, midy, midz) = elevatedTemp;
    case 2
        Tempgrid(midx - ceil(midx/10): midx + ceil(midx/10),...
            midy - ceil(midy/10):midy + ceil(midy/10), ...
            midz - ceil(midz/10):midz + ceil(midz/10)) = elevatedTemp;
    case 3
        xfreq = ceil(nthroot(elevFrequency,3));
        yfreq = floor(sqrt(elevFrequency/xfreq));
        zfreq = ceil(elevFrequency/(xfreq * yfreq));
        
        Tempgrid(1:xfreq:end,1:yfreq:end,1:zfreq:end) = elevatedTemp;
end
constants = ones(xintervals, yintervals,zintervals) .* dt ./ (specific_heat .* dd .* dd .* density);
materialMatrix = ones(xintervals, yintervals,zintervals);
k = ones(xintervals, yintervals,zintervals) * thermal_Conductivity;
leftK = ones(xintervals, yintervals,zintervals);
rightK = ones(xintervals, yintervals,zintervals);
upK = ones(xintervals, yintervals,zintervals);
downK = ones(xintervals, yintervals,zintervals);
inK = ones(xintervals, yintervals,zintervals);
outK = ones(xintervals, yintervals,zintervals);
second = zeros(xintervals,yintervals,zintervals);


iter = total_time/dt;
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

switch distribution
    case 1
        second(midx, midy, midz) = 1;
    case 2
        second(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(midz/10)) = 1;
    case 3
        freq2x = ceil(frequency2^(1/3));
        freq2y = floor(sqrt(frequency2/freq2x));
        freq2z = ceil(frequency2/(freq2x*freq2y));
        second(1:freq2x:end,1:freq2y:end,1:freq2z:end) = 1;
    case 4
        if frequency2 <= 1.1
            second(:,:,:) = 1;
        else
            i = 1;
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
        if frequency2 <= 1.1
            second(:) = 1;
        else
            i = 0;
            num = ceil(xintervals * yintervals * zintervals/frequency2);
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
second = logical(second);
bigSecond = zeros(xintervals + 2, yintervals + 2,zintervals + 2);
bigSecond = logical(bigSecond);
bigSecond(2:end-1, 2:end-1,2:end-1) = second;
constants(second) = dt / (specific_heat2 * dd * dd * density2);
materialMatrix(second) = 2;
k(second) = thermal_Conductivity2;


for i = 1:xintervals
    for j = 1:yintervals
        for l = 1:zintervals
            if i == 1
                if(materialMatrix(i,j,l) == 1)
                    leftK(i,j,l) = thermal_Conductivity;
                else
                    leftK(i,j,l) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j,l) == 1 && materialMatrix(i-1,j,l) == 1)
                    leftK(i,j,l) = thermal_Conductivity;
                elseif materialMatrix(i,j,l) == 2 && materialMatrix(i-1,j,l) == 2
                    leftK(i,j,l) = thermal_Conductivity2;
                else
                    leftK(i,j,l) = interfaceK;
                end
            end
            if i == xintervals
                if(materialMatrix(i,j,l) == 1)
                    leftK(i,j,l) = thermal_Conductivity;
                else
                    leftK(i,j,l) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j,l) == 1 && materialMatrix(i+1,j,l) == 1)    
                    rightK(i,j,l) = thermal_Conductivity;
                elseif materialMatrix(i,j,l) == 2 && materialMatrix(i+1,j,l) == 2
                    rightK(i,j,l) = thermal_Conductivity2;
                else
                    rightK(i,j,l) = interfaceK;
                end
            end
            if j == 1
                if(materialMatrix(i,j,l) == 1)
                    upK(i,j,l) = thermal_Conductivity;
                else
                    upK(i,j,l) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j,l) == 1 && materialMatrix(i,j-1,l) == 1)    
                    upK(i,j,l) = thermal_Conductivity;
                elseif materialMatrix(i,j,l) == 2 && materialMatrix(i,j-1,l) == 2
                    upK(i,j,l) = thermal_Conductivity2;
                else
                    upK(i,j,l) = interfaceK;
                end
            end
            if j == yintervals
                if(materialMatrix(i,j,l) == 1)
                    downK(i,j,l) = thermal_Conductivity;
                else
                    downK(i,j,l) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j,l) == 1 && materialMatrix(i,j+1,l) == 1)    
                    downK(i,j,l) = thermal_Conductivity;
                elseif materialMatrix(i,j,l) == 2 && materialMatrix(i,j+1,l) == 2
                    downK(i,j,l) = thermal_Conductivity2;
                else
                    downK(i,j,l) = interfaceK;
                end
            end
            if l == 1
                if(materialMatrix(i,j,l) == 1)
                    inK(i,j,l) = thermal_Conductivity;
                else
                    inK(i,j,l) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j,l) == 1 && materialMatrix(i,j,l-1) == 1)    
                    inK(i,j,l) = thermal_Conductivity;
                elseif materialMatrix(i,j,l) == 2 && materialMatrix(i,j,l-1) == 2
                    inK(i,j,l) = thermal_Conductivity2;
                else
                    inK(i,j,l) = interfaceK;
                end
            end
            if l == zintervals
                if(materialMatrix(i,j,l) == 1)
                    outK(i,j,l) = thermal_Conductivity;
                else
                    outK(i,j,l) = thermal_Conductivity2;
                end
            else
                if(materialMatrix(i,j,l) == 1 && materialMatrix(i,j,l+1) == 1)    
                    outK(i,j,l) = thermal_Conductivity;
                elseif materialMatrix(i,j,l) == 2 && materialMatrix(i,j,l+1) == 2
                    outK(i,j,l) = thermal_Conductivity2;
                else
                    outK(i,j,l) = interfaceK;
                end
            end
        end
    end
end


wholeMatrix = zeros(xintervals + 2, yintervals + 2, zintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff


F(floor((iter)/80)) = struct('cdata',[],'colormap',[]);
[X,Y,Z] = meshgrid(0:dd:ydist, 0:dd:xdist, 0:dd:zdist);

if(radiation || convection)
    boundaries = zeros(xintervals + 2, yintervals + 2, zintervals + 2);
    corners = boundaries;
    corners([2,end-1],[2,end-1],[2,end-1]) = 1;
    corners = logical(corners);
    edges = boundaries;
    edges(2:end-1,[2,end-1],[2,end-1]) = 1;
    edges([2,end-1],[2,end-1],2:end-1) = 1;
    edges([2,end-1],2:end-1,[2,end-1]) = 1;
    edges = logical(edges);
    boundaries(2:end-1,2:end-1,[2,end-1]) = 1;
    boundaries(2:end-1,[2,end-1],2:end-1) = 1;
    boundaries([2,end-1],2:end-1,2:end-1) = 1;
    boundaries = logical(boundaries);
    area = zeros(xintervals, yintervals, zintervals);
    %g(boundaries).area = 1;
    %g(edges).area = 2;
    %g(corners).area = 3;
    pBoundaries = boundaries(2:end-1,2:end-1,2:end-1);
    pEdges = edges(2:end-1,2:end-1,2:end-1);
    pCorners = corners(2:end-1,2:end-1,2:end-1);
    area(pBoundaries) = 1;
    area(pEdges) = 2;
    area(pCorners) = 3;
    
end

if(radiation)
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(pBoundaries) .* area(pBoundaries);
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if(convection)
    convRatio = 20 .* constants(pBoundaries) .* area(pBoundaries);
    convAir = convRatio .* roomTemp;
end

%%%



for j= 2:iter + 1
    if any(any(any(isnan(wholeMatrix))))
        text = strcat('Error at iteration ', num2str(j));
        disp(text);
        return
    end
    old = wholeMatrix(:,:,:);
    if borders
        old(1,:,:) = old(2,:,:);
        old(end,:,:) = old(end-1, :, :);
        old(:,1,:) = old(:,2,:);
        old(:,end,:) = old(:, end-1, :);
        old(:,:,1) = old(:,:,2);
        old(:,:,end) = old(:,:,end-1);
    end
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

    
    if(radiation)        
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* ((old(boundaries) + 273.15).^4)) + rAir;
    end
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            ((old .* convRatio) - convAir);
    end
    if j >= iterOn && j <= iterOff
        if materials == 3
            wholeMatrix(bigSecond) = wholeMatrix(bigSecond) + energyRate .* constants(second) ./ dd;
        else
            switch absorption
                case 1
                    wholeMatrix(midx,midy, midz) = wholeMatrix(midx,midy, midz) + ...
                        energyRate .* constants(midx,midy,midz) ./ dd;
                case 2
                    wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(midz/10)) = ...
                        wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(midz/10)) + ...
                        energyRate .* constants(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                        midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(midz/10)) ./ dd;
                case 3
                    xfrequ = ceil(nthroot(distributionFrequency,3));
                    yfrequ = floor(sqrt(distributionFrequency/xfrequ));
                    zfrequ = ceil(distributionFrequency/(xfrequ * yfrequ));
                    wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1,2:zfrequ:end-1) = ...
                        wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1,2:zfrequ:end-1) + ...
                        energyRate .* constants(1:xfrequ:end,1:yfrequ:end,1:zfrequ:end) ...
                         ./ dd;
            end
        end
    end
    if mod(j - 1, framerate) == 0
        list(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1) ...
            ./ constants .* dt .* dd)));
        figure;
        slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
        caxis([0 (Tm + 20)])
        colorbar('horiz')
        %alpha(0.7);
        drawnow
        F(index) = getframe(gcf);
        index = index + 1;
    end
end

%After creating all the slides, will pause and let you analyze
%variables. Then press a key and it will play the movie twice and end on
%the last frame.
mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1) ...
            ./ constants .* dt .* dd)));
pause
close all;
fig = figure;
movie(fig,F,2)
close all;

slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
caxis([0 (Tm + 20)])
colorbar('horiz')

melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);



end