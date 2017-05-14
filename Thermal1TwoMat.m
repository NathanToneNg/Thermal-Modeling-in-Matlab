function Thermal1TwoMat

global precision xdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm thermal_Conductivity roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    density2 specific_heat2 thermal_Conductivity2 interfaceK materials distribution ...
    frequency2;
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
constants = ones(xintervals, 1) .* dt ./ (specific_heat .* dd .* dd .* density);
materialMatrix = ones(xintervals, 1);
k = ones(xintervals, 1) * thermal_Conductivity;
leftK = ones(xintervals, 1);
rightK = ones(xintervals, 1);
% %g = repmat(struct('const',dt./specific_heat .* dd .* dd .* density, 'material', 1, 'k', thermal_Conductivity), xintervals + 2, 1);
% %g = ones(xintervals + 2, 1);
% for i = 1:xintervals + 2
%     g(i) = struct('const',dt./specific_heat .* dd .* dd .* density, 'material', 1, 'k', thermal_Conductivity);
% end
%g(mid) = struct('const',dt./specific_heat2 .* dd .* dd .* density2, 'material', 2, 'k', thermal_Conductivity2);
second = zeros(xintervals,1);
switch distribution
    case 1
        second(mid) = 1;
    case 3
        second(1:ceil(frequency2):end) = 1;
    case 4
        if frequency2 <= 1.1
            second(:) = 1;
        else
            i = 1;
            while i <= ceil(xintervals/frequency2)
                potentialRand = randi(xintervals);
                if(~second(potentialRand))
                    second(potentialRand) = true;
                    i = i + 1;
                end
            end
        end
end
second = logical(second);
bigSecond = zeros(xintervals + 2, 1);
bigSecond = logical(bigSecond);
bigSecond(2:end-1) = second;
constants(second) = dt / (specific_heat2 * dd * dd * density2);
materialMatrix(second) = 2;
k(second) = thermal_Conductivity2;
        
for i = 1:xintervals
    if i == 1
        leftK(i) = 0.33;
    else
        if(materialMatrix(i) == 1 && materialMatrix(i-1) == 1)    
            leftK(i) = thermal_Conductivity;
        elseif materialMatrix(i) == 2 && materialMatrix(i-1) == 2
            leftK(i) = thermal_Conductivity2;
        else
            leftK(i) = interfaceK;
        end
    end
    if i == xintervals
        rightK(i) = 0.33;
    else
        if(materialMatrix(i) == 1 && materialMatrix(i+1) == 1)    
            rightK(i) = thermal_Conductivity;
        elseif materialMatrix(i) == 2 && materialMatrix(i+1) == 2
            rightK(i) = thermal_Conductivity2;
        else
            rightK(i) = interfaceK;
        end
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
    parameterBounds = boundaries(2:end-1);
end

if(radiation)
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(parameterBounds);
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if(convection)
    convRatio = 20 .* constants(parameterBounds);
    convAir = convRatio .* roomTemp;
end

%%%



for j= 2:iter + 1
    if any(isnan(wholeMatrix))
        text = strcat('Error at iteration ', num2str(j));
        disp(text);
        return
    end
    old = wholeMatrix(:);
    
    if borders
        old(1) = old(2);
        old(end) = old(end-1);
    end
    wholeMatrix(2:end-1) = wholeMatrix(2:end-1) + ...
        (old(1:end-2) - old(2:end-1)).*constants .* leftK + ...
        (old(3:end) - old(2:end-1)).*constants .* rightK;
    if(radiation)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (rConst .* (old(boundaries) + 273.15).^4) + rAir;
    end
    if(convection)
        wholeMatrix(boundaries) = wholeMatrix(boundaries) - ...
            (convRatio - convAir);
    end
    if j >= iterOn && j <= iterOff
        if materials == 3
            wholeMatrix(bigSecond) = wholeMatrix(bigSecond) + energyRate .* constants(second) .* dd;
        else
            switch absorption
                case 1
                    wholeMatrix(mid) = wholeMatrix(mid) + energyRate .*constants(mid) .* dd;
                case 2
                    wholeMatrix(mid - ceil(mid/10): mid + ceil(mid/10)) = ...
                        wholeMatrix(mid - ceil(mid/10): mid + ceil(mid/10)) + ...
                        energyRate .* constants(mid - ceil(mid/10): mid + ceil(mid/10)) .* dd;
                case 3
                    wholeMatrix(2:distributionFrequency:end-1) = wholeMatrix(2:distributionFrequency:end-1) ...
                        + energyRate .* constants(1:distributionFrequency:end) .* dd;
            end
        end
    end
    
    if mod(j - 1, framerate) == 0
        list(index) = mean(wholeMatrix(2:end-1)./constants.* dt .* dd); %Energy per meter squared in infinite dimensions
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