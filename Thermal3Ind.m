function Thermal3Ind

global precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff;
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
dQ = energyRate * dt / (specific_heat * density * dd * dd * dd);


iter = total_time/dt;
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

g = ones(xintervals + 2, yintervals + 2, zintervals + 2); %Will work for singular material, not confident in ability for multiple materials yet
g = g .* constant; %this will allow us to later have multiple materials in the same graphing (not yet confident at boundaries)


if(radiation)
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* dt ./ (specific_heat .*  dd .* dd .* density);
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if(convection)
    convRatio = 20 .* dt ./ (specific_heat .* density .* dd .* dd);
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
end
%%%



for j= 2:iter + 1
    if any(any(any(isnan(wholeMatrix))))
        return
    end
    old = wholeMatrix(:,:,:).*g(:,:,:);
    if borders
        old(1,:,:) = old(2,:,:);
        old(end,:,:) = old(end-1, :, :);
        old(:,1,:) = old(:,2,:);
        old(:,end,:) = old(:, end-1, :);
        old(:,:,1) = old(:,:,2);
        old(:,:,end) = old(:,:,end-1);
    end
    wholeMatrix(2:end-1, 2:end-1, 2:end-1) = old(2:end-1, 2:end-1,2:end-1)./g(2:end-1,2:end-1,2:end-1) + ...
        (old(2:end-1, 1:end-2,2:end-1) + old(2:end-1, 3:end,2:end-1) + old(1:end-2,2:end-1,2:end-1) + ...
        old(3:end,2:end-1,2:end-1) + old(2:end-1, 2:end-1, 1:end-2) + old(2:end-1, 2:end-1, 3:end) ...
        - 6.*old(2:end-1, 2:end-1,2:end-1));
    
    if(radiation)        
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - rConst .* ...
            ((old(boundaries)./g(boundaries) + 273.15).^4) + rAir;
        wholeMatrix(edges) = wholeMatrix(edges) - rConst .* ...
            ((old(edges)./g(edges) + 273.15).^4) + rAir;
        wholeMatrix(corners) = wholeMatrix(corners) - rConst .* ...
            ((old(corners)./g(corners) + 273.15).^4) + rAir;
    end
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (old(boundaries)./g(boundaries) - roomTemp) .* convRatio;
        wholeMatrix(edges) = wholeMatrix(edges) - ... %twice as much at edges
            (old(edges)./g(edges) - roomTemp) .* convRatio;
        wholeMatrix(corners) = wholeMatrix(corners) - ... %and three times as much at corners
            (old(corners)./g(corners) - roomTemp) .* convRatio;
    end
    if j >= iterOn && j <= iterOff
        switch absorption
            case 1
                wholeMatrix(midx,midy, midz) = wholeMatrix(midx,midy, midz) + dQ;
            case 2
                wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                    midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(mid/10)) = ...
                    wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                    midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(mid/10)) + dQ;
            case 3
                xfrequ = ceil(nthroot(distributionFrequency,3));
                yfrequ = floor(sqrt(distributionFrequency/xfrequ));
                zfrequ = ceil(distributionFrequency/(xfrequ * yfrequ));
                wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1,2:zfrequ:end-1) = ...
                    wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1,2:zfrequ:end-1) + dQ;
        end
    end
    if mod(j - 1, framerate) == 0
        list(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1))));
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
mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1))))
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