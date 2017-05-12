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


iter = total_time/dt;
if(absorption)
    iterOn = floor(timeOn / dt) + 1;
    iterOff = floor(timeOff / dt) + 1;
end

g = ones(xintervals + 2, yintervals + 2, zintervals + 2); 
for i = 1:xintervals + 2
    for j = 1:yintervals + 2
        for k = 1:zintervals + 2
        g(i) = struct('const',dt./specific_heat .* dd .* dd .* density, 'material', 1, 'k', thermal_Conductivity);
        end
    end
end
g(midx, midy, midz) = struct('const',dt./specific_heat2 .* dd .* dd .* density2, 'material', 2, 'k', thermal_Conductivity2);


for i = 2:xintervals + 1
    for j = 2:yintervals + 1
        for k = 2:zintervals + 2
            if(g(i,j,k).material == 1 && g(i - 1,j,k).material == 1)    
                g(i,j,k).('leftK') = thermal_Conductivity;
            elseif g(i,j,k).material == 2 && g(i - 1,j,k).material == 2
                g(i,j,k).('leftK') = thermal_Conductivity2;
            else
                g(i,j,k).('leftK') = interfaceK;
            end
            if(g(i,j,k).material == 1 && g(i + 1,j,k).material == 1)    
                g(i,j,k).('rightK') = thermal_Conductivity;
            elseif g(i,j,k).material == 2 && g(i + 1,j,k).material == 2
                g(i,j,k).('rightK') = thermal_Conductivity2;
            else
                g(i,j,k).('rightK') = interfaceK;
            end
            if(g(i,j,k).material == 1 && g(i,j-1,k).material == 1)    
                g(i,j,k).('upK') = thermal_Conductivity;
            elseif g(i,j,k).material == 2 && g(i,j-1,k).material == 2
                g(i,j,k).('upK') = thermal_Conductivity2;
            else
                g(i,j,k).('upK') = interfaceK;
            end
            if(g(i,j,k).material == 1 && g(i,j+1,k).material == 1)    
                g(i,j,k).('downK') = thermal_Conductivity;
            elseif g(i,j,k).material == 2 && g(i,j+1,k).material == 2
                g(i,j,k).('downK') = thermal_Conductivity2;
            else
                g(i,j,k).('downK') = interfaceK;
            end
            if(g(i,j,k).material == 1 && g(i,j,k-1).material == 1)    
                g(i,j,k).('inK') = thermal_Conductivity;
            elseif g(i,j,k).material == 2 && g(i,j,k-1).material == 2
                g(i,j,k).('inK') = thermal_Conductivity2;
            else
                g(i,j,k).('inK') = interfaceK;
            end
            if(g(i,j,k).material == 1 && g(i,j,k+1).material == 1)    
                g(i,j,k).('outK') = thermal_Conductivity;
            elseif g(i,j,k).material == 2 && g(i,j,k+1).material == 2
                g(i,j,k).('outK') = thermal_Conductivity2;
            else
                g(i,j,k).('outK') = interfaceK;
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
    g(boundaries).area = 1;
    g(edges).area = 2;
    g(corners).area = 3;
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
     wholeMatrix(2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1) + ...
         ...
        (old(2:end-1, 1:end-2,2:end-1)-old(2:end-1,2:end-1,2:end-1)) ...
            .*g(2:end-1,2:end-1,2:end-1).const .* g(2:end-1,2:end-1,2:end-1).upK + ...
        (old(2:end-1,3:end,2:end-1)-old(2:end-1,2:end-1,2:end-1))...
            .*g(2:end-1,2:end-1,2:end-1).const .* g(2:end-1,2:end-1,2:end-1).downK + ...
        (old(1:end-1,2:end-1,2:end-1)-old(2:end-1,2:end-1,2:end-1))...
            .*g(2:end-1,2:end-1,2:end-1).const .* g(2:end-1,2:end-1,2:end-1).leftK + ...
        (old(3:end,2:end-1,2:end-1) - old(2:end-1,2:end-1,2:end-1))...
            .*g(2:end-1,2:end-1,2:end-1).const .* g(2:end-1,2:end-1,2:end-1).rightK + ...
        (old(2:end-1,2:end-1,1:end-3) - old(2:end-1,2:end-1,2:end-1)) ...
            .*g(2:end-1,2:end-1,2:end-1).const .* g(2:end-1,2:end-1,2:end-1).inK + ...
        (old(2:end-1,2:end-1,3:end) - old(2:end-1,2:end-1,2:end-1)) ...
            .*g(2:end-1,2:end-1,2:end-1).const .* g(2:end-1,2:end-1,2:end-1).outK;

    
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
                wholeMatrix(midx,midy, midz) = wholeMatrix(midx,midy, midz) + ...
                    energyRate .* g(midx,midy,midz).const ./ dd;
            case 2
                wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                    midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(mid/10)) = ...
                    wholeMatrix(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                    midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(mid/10)) + ...
                    energyRate .* g(midx - ceil(midx/10): midx + ceil(midx/10), midy - ceil(midy/10): ...
                    midy + ceil(midy/10), midz - ceil(midz/10):midz + ceil(mid/10)).const ./ dd;
            case 3
                xfrequ = ceil(nthroot(distributionFrequency,3));
                yfrequ = floor(sqrt(distributionFrequency/xfrequ));
                zfrequ = ceil(distributionFrequency/(xfrequ * yfrequ));
                wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1,2:zfrequ:end-1) = ...
                    wholeMatrix(2:xfrequ:end-1,2:yfrequ:end-1,2:zfrequ:end-1) + ...
                    energyRate .* g(2:xfrequ:end-1,2:yfrequ:end-1,2:zfrequ:end-1) ./ dd;
        end
    end
    if mod(j - 1, framerate) == 0
        list(index) = mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1) ...
            .* g(2:end-1,2:end-1,2:end-1).const ./ dt ./ dd)));
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
            .* g(2:end-1,2:end-1,2:end-1).const ./ dt ./ dd)));
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