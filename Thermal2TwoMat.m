function Thermal2TwoMat

global precision xdist ydist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    thermal_Conductivity2 interfaceK;
global list



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

g = ones(xintervals + 2, yintervals + 2); 
for i = 1:xintervals + 2
    for j = 1:yintervals + 2
        g(i) = struct('const',dt./specific_heat .* dd .* dd .* density, 'material', 1, 'k', thermal_Conductivity);
    end
end
g(midx, midy) = struct('const',dt./specific_heat2 .* dd .* dd .* density2, 'material', 2, 'k', thermal_Conductivity2);

for i = 2:xintervals + 1
    for j = 2:yintervals + 1
        if(g(i,j).material == 1 && g(i - 1,j).material == 1)    
            g(i,j).('leftK') = thermal_Conductivity;
        elseif g(i,j).material == 2 && g(i - 1,j).material == 2
            g(i,j).('leftK') = thermal_Conductivity2;
        else
            g(i,j).('leftK') = interfaceK;
        end
        if(g(i,j).material == 1 && g(i + 1,j).material == 1)    
            g(i,j).('rightK') = thermal_Conductivity;
        elseif g(i,j).material == 2 && g(i + 1,j).material == 2
            g(i,j).('rightK') = thermal_Conductivity2;
        else
            g(i,j).('rightK') = interfaceK;
        end
        if(g(i,j).material == 1 && g(i,j - 1).material == 1)    
            g(i,j).('upK') = thermal_Conductivity;
        elseif g(i,j).material == 2 && g(i,j - 1).material == 2
            g(i,j).('upK') = thermal_Conductivity2;
        else
            g(i,j).('upK') = interfaceK;
        end
        if(g(i,j).material == 1 && g(i,j + 1).material == 1)    
            g(i,j).('downK') = thermal_Conductivity;
        elseif g(i,j).material == 2 && g(i,j + 1).material == 2
            g(i,j).('downK') = thermal_Conductivity2;
        else
            g(i,j).('downK') = interfaceK;
        end
    end
end


wholeMatrix = zeros(xintervals + 2, yintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff


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
    g(boundaries).('area') = 1;
    g(corners).('area')= 2;

end


if(radiation)
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* g(boundaries).const .* g(boundaries).area;
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if(convection)
    convRatio = 20 .* g(boundaries).const .* g(boundaries).area;
    convAir = convRatio .* roomTemp;
end


%%%



for j= 2:iter + 1
    if any(any(isnan(wholeMatrix)))
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
        (old(2:end-1, 1:end-2)-old(2:end-1,2:end-1)).*g(2:end-1,2:end-1).const .* g(2:end-1,2:end-1).upK + ...
        (old(2:end-1,3:end)-old(2:end-1,2:end-1)).*g(2:end-1,2:end-1).const .* g(2:end-1,2:end-1).downK + ...
        (old(1:end-1,2:end-1)-old(2:end-1,2:end-1)).*g(2:end-1,2:end-1).const .* g(2:end-1,2:end-1).leftK + ...
        (old(3:end,2:end-1) - old(2:end-1,2:end-1)).*g(2:end-1,2:end-1).const .* g(2:end-1,2:end-1).rightK;
    if(radiation)        
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* (old(boundaries) + 273.15).^4) + rAir;
    end
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (convRatio - convAir);
    end
    if j >= iterOn && j <= iterOff
       switch absorption
            case 1
                wholeMatrix(midx,midy) = wholeMatrix(midx,midy) + energyRate .* g(midx,midy)./ dd;
            case 2
                wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                    midy + ceil(midy/10)) = wholeMatrix(midx - ceil(midx/10): midx + ...
                    ceil(midx/10), midy - ceil(midy/10): midy + ceil(midy/10)) + ...
                    energyRate .* g(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                    midy + ceil(midy/10)).const ./ dd;
            case 3
                xfrequ = ceil(sqrt(distributionFrequency));
                yfrequ = floor(distributionFrequency/xfrequ);
                wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1) = wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1) ...
                    + energyRate .* g(2:xfrequ:end-1,2:yfrequ:end-1).const ./ dd;
       end
    end
    
    if mod(j - 1, framerate) == 0
        list(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1) ...
            .* g(2:end-1,2:end-1).const ./ dt ./ dd)));
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