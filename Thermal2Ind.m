function Thermal2Ind

global precision xdist ydist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity;




digits(precision);
index = 1;


xintervals = xdist / dd + 1;
yintervals = ydist / dd + 1;
Tempgrid = zeros(yintervals, xintervals) + roomTemp;
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
dQ = energyRate * dt / (specific_heat * density);


iter = total_time/dt;


g = ones(yintervals + 2, xintervals + 2); %Will work for singular material, not confident in ability for multiple materials yet
g = g .* constant; %this will allow us to later have multiple materials in the same graphing (not yet confident at boundaries)

if(radiation)
    sigma = 5.67 * 10^-8;
    rAir = sigma .* dt ./ (specific_heat .*  dd .* dd .* density);
    outer = zeros(yintervals + 2, xintervals + 2);
    outer(1,:) = 1;
    outer(end,:) = 1;
    outer(:,1) = 1;
    outer(:,end) = 1;
    outer = logical(outer); 
end
if(convection)
    convRatio = 20 .* dt ./ (specific_heat .* density .* dd .* dd);
end


wholeMatrix = zeros(yintervals + 2, xintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff


F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);
[X,Y] = meshgrid(0:dd:xdist, 0:dd:ydist);

if(radiation || convection)
    boundaries = zeros(yintervals + 2, xintervals + 2);
    corners = boundaries;
    corners([2,end-1],[2,end-1]) = 1;
    corners = logical(corners);
    boundaries([2,end-1],2:end-1) = 1;
    boundaries(2:end-1,[2,end-1]) = 1;
    boundaries = logical(boundaries);
end


%%%



for j= 2:iter + 1
    if any(any(isnan(wholeMatrix)))
        return
    end
    old = wholeMatrix(:,:).*g(:,:);
    if(borders)
        old(1,:) = old(2,:);
        old(end,:) = old(end-1,:);
        old(:,1) = old(:,2);
        old(:,end) = old(:,end-1);
    end
    wholeMatrix(2:end-1, 2:end-1) = old(2:end-1, 2:end-1)./g(2:end-1,2:end-1) + ...
        (old(2:end-1, 1:end-2) + old(2:end-1, 3:end) + old(1:end-2,2:end-1) + ...
        old(3:end,2:end-1) - 4.*old(2:end-1, 2:end-1));
    if(radiation)
        rOld = ((wholeMatrix(:)+273.15).^4).*rAir;
        
        %At the very borders there is air, so complete 1 emissivity
        rOld(outer) = rOld(outer)./emissivity;
        
        wholeMatrix(2:end-1, 2:end-1) = wholeMatrix(2:end-1,2:end-1) + ...
            emissivity.*(rOld(2:end-1, 1:end-2) + rOld(2:end-1, 3:end) + rOld(1:end-2,2:end-1) + ...
            rOld(3:end,2:end-1) - 4.*rOld(2:end-1, 2:end-1));
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (1-emissivity) .* rOld(boundaries);
        wholeMatrix(corners) = wholeMatrix(corners) - ... %twice as much at corners
            (1-emissivity) .* rOld(boundaries);
    end
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (wholeMatrix(boundaries) - roomTemp) .* convRatio;
        wholeMatrix(corners) = wholeMatrix(corners) - ... %twice as much at corners
            (wholeMatrix(corners) - roomTemp) .* convRatio;
    end
   switch absorption
        case 1
            wholeMatrix(midx,midy) = wholeMatrix(midx,midy) + dQ;
        case 2
            wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                midy + ceil(midy/10)) = wholeMatrix(midx - ceil(midx/10): midx + ...
                ceil(midx/10), midy - ceil(midy/10): midy + ceil(midy/10)) + dQ;
        case 3
            xfrequ = ceil(sqrt(distributionFrequency));
            yfrequ = floor(distributionFrequency/xfrequ);
            wholeMatrix(2:xfrequ:end,2:yfrequ:end) = wholeMatrix(2:xfrequ:end,2:yfrequ:end) ...
                + dQ;
    end
    
    if mod(j - 1, framerate) == 0
        figure;
        surfc(X,Y,wholeMatrix(2:end-1,2:end-1));
        caxis([0 (Tm + 20)])
        colorbar('horiz')
        %alpha(0.7);
        drawnow
        F(index) = getframe(gcf);
        index = index + 1;
        mean(mean(wholeMatrix(2:end-1,2:end-1)))
    end
end

%After creating all the slides, will pause and let you analyze
%variables. Then press a key and it will play the movie twice and end on
%the last frame.
mean(mean(wholeMatrix(2:end-1,2:end-1)))

pause
close all;
fig = figure;
movie(fig,F,2)
close all;

surf(X,Y,wholeMatrix(2:end-1,2:end-1));
caxis([0 (Tm + 20)])
colorbar('horiz')

melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);

end