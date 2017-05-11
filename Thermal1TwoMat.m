function Thermal1TwoMat

global precision xdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm thermal_Conductivity constant roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    thermal_Conductivity2 interfaceK;
global list

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



digits(precision);
index = 1;


xintervals = floor(xdist / dd + 1);
Tempgrid = zeros(xintervals,1) + roomTemp;
mid = ceil(xintervals/2);
switch elevLocation 
    case 1
        Tempgrid(mid) = elevatedTemp;
    case 2
        Tempgrid(mid - ceil(mid/10): mid + ceil(mid/10)) = elevatedTemp;
    case 3
        Tempgrid(1:elevFrequency:end) = elevatedTemp;
end

iter = total_time/dt;
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

g = ones(xintervals + 2, 1);
for i = 1:xintervals + 2
    g(i) = struct('const',dt./specific_heat .* dd .* dd .* density, 'material', 1, 'k', thermal_Conductivity);
end
g(mid) = struct('const',dt./specific_heat2 .* dd .* dd .* density2, 'material', 2, 'k', thermal_Conductivity2);


for i = 2:xintervals + 1
    if(g(i).material == 1 && g(i - 1).material == 1)    
        g(i).('leftK') = thermal_Conductivity;
    elseif g(i).material == 2 && g(i - 1).material == 2
        g(i).('leftK') = thermal_Conductivity2;
    else
        g(i).('leftK') = interfaceK;
    end
    if(g(i).material == 1 && g(i + 1).material == 1)    
        g(i).('rightK') = thermal_Conductivity;
    elseif g(i).material == 2 && g(i + 1).material == 2
        g(i).('rightK') = thermal_Conductivity2;
    else
        g(i).('rightK') = interfaceK;
    end
end

wholeMatrix = zeros(xintervals + 2, 1) + roomTemp;
wholeMatrix(2:end-1) = Tempgrid;

%%% movie stuff


F(floor((iter)/framerate)) = struct('cdata',[],'colormap',[]);

if(radiation || convection)
    boundaries = zeros(xintervals + 2,1);
    boundaries([2,end-1]) = 1;
    boundaries = logical(boundaries);
end

if(radiation)
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* g(boundaries).const;
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if(convection)
    convRatio = 20 .* g(boundaries).const;
    convAir = convRatio .* roomTemp;
end

%%%



for j= 2:iter + 1
    if any(isnan(wholeMatrix))
        text = strcat('Error at iteration ', j);
        disp(text);
        return
    end
    old = wholeMatrix(:);
    
    if borders
        old(1) = old(2);
        old(end) = old(end-1);
    end
    wholeMatrix(2:end-1) = wholeMatrix(2:end-1) + ...
        (old(1:end-2) - old(2:end-1)).*g(2:end-1).const .* g(2:end-1).leftK - ...
        (old(3:end) - old(2:end-10)).*g(2:end-1).const .* g(2:end-1).rightK;
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
                wholeMatrix(mid) = wholeMatrix(mid) + energyRate .*g(mid).const ./ dd;
            case 2
                wholeMatrix(mid - ceil(mid/10): mid + ceil(mid/10)) = ...
                    wholeMatrix(mid - ceil(mid/10): mid + ceil(mid/10)) + ...
                    energyRate .* g(mid - ceil(mid/10): mid + ceil(mid/10)).const ./ dd;
            case 3
                wholeMatrix(2:distributionFrequency:end-1) = wholeMatrix(2:distributionFrequency:end-1) ...
                    + energyRate .* g(2:distributionFrequency:end-1).const ./ dd;
        end
    end
    
    if mod(j - 1, framerate) == 0
        list(index) = mean(wholeMatrix(2:end-1).*g(2:end-1).const ./ dt ./ dd);
        figure;
        plot(0:dd:xdist, wholeMatrix(2:end-1));
        %ylim([0 50]);
        %alpha(0.7);
        drawnow
        F(index) = getframe(gcf);
        index = index + 1;
    end
end

%After creating all the slides, will pause and let you analyze
%variables. Then press a key and it will play the movie twice and end on
%the last frame.

pause
close all;
fig = figure;
movie(fig,F,2)
close all;

plot(0:dd:xdist, wholeMatrix(2:end-1));
%ylim([0 50]);

melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);

end