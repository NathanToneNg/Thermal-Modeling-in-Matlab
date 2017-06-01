global precision xdist ydist zdist dd total_time dt framerate  convection radiation ...
    specific_heat density Tm roomTemp elevatedTemp elevLocation thermal_Conductivity...
     absorption energyRate  emissivity timeOn timeOff...
    density2 specific_heat2 thermal_Conductivity2 interfaceK;
clear global list;
global list;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% MaterialMatrix must be custom made, but then thermal conductivities
%%% retrieved from it. 
%%% Allows for more than 2 materials, disallows conductivity off edges
%%% which shouldn't be needed anyway realistically. Calculations each time
%%% step remain the same.

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




%specific_heat = 
%density =
%thermal_Conductivity = 0.51
%specific_heat2
%density2 
%thermal_Conductivity2 = 2.5?
%specific_heat3
%density3
%thermal_Conductivity3 = 0.22
%Interface 13 = 
%Interface 12 = 
%Interface 23 = 




materialMatrix = zeros(xintervals, yintervals,zintervals);
leftK = ones(xintervals, yintervals,zintervals);
rightK = ones(xintervals, yintervals,zintervals);
upK = ones(xintervals, yintervals,zintervals);
downK = ones(xintervals, yintervals,zintervals);
inK = ones(xintervals, yintervals,zintervals);
outK = ones(xintervals, yintervals,zintervals);


constantArray = zeros(8,0);
constantArray(2) = dt ./ (specific_heat .* dd .* dd .* density); %PP
constantArray(4) = dt ./ (specific_heat3 .* dd .* dd .* density3); %PE
constantARray(8) = dt ./ (specific_heat2 .* dd .* dd .* density2); % Receptor
constants = constantArray(materialMatrix(:,:,:) + 1);
kArray = zeros(8,0);
kArray(2) = 0.51;
kArray(4) = 0.22;
kArray(8) = 25;
k = kArray(materialMatrix(:,:,:) + 1);

iter = total_time/dt;
if absorption
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end



%%%
% Material 0: Air, Material 1: HDPE, Material 3: PP, Material 7: Receptor,
% 
%
%
%
%
%%%

second = logical(MaterialMatrix(:,:) == 4);
bigSecond = zeros(xintervals + 2, yintervals + 2,zintervals + 2);
bigSecond = logical(bigSecond);
bigSecond(2:end-1, 2:end-1,2:end-1) = second;
constants(second) = dt / (specific_heat2 * dd * dd * density2);
k(second) = thermal_Conductivity2;

receivers = second;
bigReceivers = zeros(xintervals + 2, yintervals + 2,zintervals + 2);
bigReceivers = logical(bigReceivers);
bigReceivers(2:end-1,2:end-1,2:end-1) = receivers;



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
                switch materialMatrix(i,j,l) + materialMatrix(i-1,j,l)
                    
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
                switch materialMatrix(i,j,l) + materialMatrix(i-1,j,l)
                    
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
                switch materialMatrix(i,j,l) + materialMatrix(i-1,j,l)
                    
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
                switch materialMatrix(i,j,l) + materialMatrix(i-1,j,l)
                    
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
                switch materialMatrix(i,j,l) + materialMatrix(i-1,j,l)
                    
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


wholeMatrix = zeros(xintervals + 2, yintervals + 2, zintervals + 2) + roomTemp;
wholeMatrix(2:end-1, 2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff

clear F;
F(floor((iter)/80)) = struct('cdata',[],'colormap',[]);
[X,Y,Z] = meshgrid(0:dd:ydist, 0:dd:xdist, 0:dd:zdist);

if radiation || convection
    pBoundaries = (materialMatrix(:,:) == 4);
    boundaries = logical(zeros(xintervals + 2, yintervals + 2, zintervals + 2));
    boundaries(2:end-1,2:end-1,2:end-1) = pBoundaries;
    area = (upK == 0) + (downK == 0) + (leftK == 0) + (rightK == 0);

    
end

if radiation
    sigma = 5.67 * 10^-8;
    rConst = sigma .* emissivity .* constants(pBoundaries) .* area(pBoundaries) .* dd;
    rAir = rConst .* (roomTemp + 273.15)^4;
end
if convection
    convRatio = 20 .* constants(pBoundaries) .* area(pBoundaries) .* dd;
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
    
    if j >= iterOn && j <= iterOff
        wholeMatrix(bigReceivers) = wholeMatrix(bigReceivers) + energyRate .* constants(receivers) .* dd;
    end
    if mod(j - 1, framerate) == 0
        list(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1) ... %Energy
            ./ constants .* dt .* dd)));
        try
            figure;
            slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
            caxis([0 (Tm + 20)])
            colorbar('horiz')
            %alpha(0.7);
            drawnow
            F(index) = getframe(gcf);
        catch
            disp('Cannot graph');
        end
        index = index + 1;
    end
end

%After creating all the slides, will pause and let you analyze
%variables. Then press a key and it will play the movie twice and end on
%the last frame.
mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1) ...
            ./ constants .* dt ./ dd)));
pause
close all;
try
    fig = figure;
    movie(fig,F,1)
    close all;

    slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), yslice, xslice, zslice);
    caxis([0 (Tm + 20)])
    colorbar('horiz')
catch
    disp('Cannot graph');
end

melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);
