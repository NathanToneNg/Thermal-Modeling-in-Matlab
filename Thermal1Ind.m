function Thermal1Ind

global precision xdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff;
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
dQ = energyRate * dt / (specific_heat * density * dd * dd * dd);


iter = total_time/dt;
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

g = ones(xintervals + 2, 1); %Will work for singular material, not confident in ability for multiple materials yet
g = g .* constant; %this will allow us to later have multiple materials in the same graphing (not yet confident at boundaries)

if(radiation)
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* dt ./ (specific_heat .*  dd .* dd .* density);
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if(convection)
    convRatio = 20 .* dt ./ (specific_heat .* density .* dd .* dd);
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
%%%



for j= 2:iter + 1
    if any(isnan(wholeMatrix))
        return
    end
    old = wholeMatrix(:).*g(:);
    
    if borders
        old(1) = old(2);
        old(end) = old(end-1);
    end
    wholeMatrix(2:end-1) = old(2:end-1)./g(2:end-1) + ...
        (old(1:end-2) + old(3:end) - 2.*old(2:end-1));
    if(radiation)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - rConst .* ...
            ((old(boundaries)./g(boundaries) + 273.15).^4) + rAir;
    end
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (old(boundaries)./g(boundaries) - roomTemp) .* convRatio;
    end
    if j >= iterOn && j <= iterOff
        switch absorption
            case 1
                wholeMatrix(mid) = wholeMatrix(mid) + dQ;
            case 2
                wholeMatrix(mid - ceil(mid/10): mid + ceil(mid/10)) = ...
                    wholeMatrix(mid - ceil(mid/10): mid + ceil(mid/10)) + dQ;
            case 3
                wholeMatrix(2:distributionFrequency:end-1) = wholeMatrix(2:distributionFrequency:end-1) ...
                    + dQ;
        end
    end
    
    if mod(j - 1, framerate) == 0
        list(index) = mean(wholeMatrix(2:end-1));
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