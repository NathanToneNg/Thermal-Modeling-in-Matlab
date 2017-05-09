%THREE DIMENSIONAL!!

%three-dimensional
%Uses logical arrays (matrices)
digits(10);
index = 1;
xdist = 0.2;
ydist = 0.2;
zdist = 0.2;
dd = 0.005; %Interval of distance

xintervals = xdist / dd + 1;
yintervals = ydist / dd + 1;
zintervals = zdist / dd + 1;
Tempgrid = zeros(yintervals, xintervals, zintervals);

%Tempgrid(23:25, 18:22, 18:22) = 400;

total_time = 3600; %seconds
dt = 1;
iter = total_time/dt;

%thermal conductivity = k, density = p, specific heat = c, dx = thickness

%LDPE: Thermal conductivity = 0.33 at 23C, specific heat = 1900-2300, density
%= 0.92
%HDPE: Thermal conductivity = 0.44 (W/m K)
%PP: k = 0.11, 
%Carbon nanotubes: k: 2000-6000, p = 1.6g/cm^3, c = 4130ish?
%Graphite: k: 100-400 on planes, p = 2.266, c = 0.72 J/g*C

%g = k / (p * dx * c)
g = ones(yintervals + 2, xintervals + 2, zintervals + 2);
%g = g.* 1.708.*10^-2; %This is the map for all polyethylene. If it's all the same we can just use h without a matrix
g = g .* 1.4767 * 10^-7;
g = g .* dt ./dd ./dd;
%g(20:22,10:17,23:30) = 0.0001;
%also, dd cancels out
%h = 1.15655 * (10^(-4))/dd; % h = k * A * dt / dd* (m * c) = k * dt / (p * dd * dd*
%c) = k/(p * c) * dt/ dd / dd
%k
%h is in meters per second, the ratio between temperature gradient and
%temperature change rate. %this is for copper
%h = h * 100;
%r = 0.97 .* 5.67 .* 10^-8 .* p ./ dd .* (temp^4) ./ c .* dt


wholeMatrix = zeros(yintervals + 2, xintervals + 2, zintervals + 2);
wholeMatrix(2:end-1, 2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff


%F(iter) = struct('cdata',[],'colormap',[]);
[X,Y, Z] = meshgrid(0:dd:xdist, 0:dd:ydist, 0:dd:zdist);

xslice = 0.1;
yslice = 0.1;
zslice = 0.1;

%%%



for j= 2:iter + 1
    if any(any(any(isnan(wholeMatrix))))
        return
    end
    old = wholeMatrix(:,:,:).*g(:,:,:);
    wholeMatrix(2:end-1, 2:end-1, 2:end-1) = old(2:end-1, 2:end-1,2:end-1)./g(2:end-1,2:end-1,2:end-1) + ...
        (old(2:end-1, 1:end-2,2:end-1) + old(2:end-1, 3:end,2:end-1) + old(1:end-2,2:end-1,2:end-1) + ...
        old(3:end,2:end-1,2:end-1) - 6.*old(2:end-1, 2:end-1,2:end-1) + ...
        old(2:end-1, 2:end-1, 1:end-2) + old(2:end-1, 2:end-1, 3:end));
    %wholeMatrix(2:end-1, 2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1,2:end-1) - (0.97 .* 5.67 .* 10^-8 .* p ./ dd .* wholeMatrix(2:end-1, 2:end-1,2:end-1, j) ./ dc .* dt);
    wholeMatrix(5:10:end, 5:10:end, 15:15:30) = wholeMatrix(5:10:end, 5:10:end, 15:15:30) + 25;
    if mod(j - 1, 80) == 0
        figure;
        slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), xslice, yslice, zslice);
        caxis([0 300])
        colorbar('horiz')
        %alpha(0.7);
        drawnow
        F(index) = getframe(gcf);
        index = index + 1;
    end
end



pause
close all;
fig = figure;
movie(fig,F,2)
close all;

slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), xslice, yslice, zslice);
caxis([0 500])
colorbar('horiz')