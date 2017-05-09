%THREE DIMENSIONAL!!

%three-dimensional
%Uses logical arrays (matrices)
digits(6);

xdist = 0.5;
ydist = 0.5;
zdist = 0.2;
dd = 0.005; %Interval of distance

xintervals = xdist / dd + 1;
yintervals = ydist / dd + 1;
zintervals = zdist / dd + 1;
Tempgrid = zeros(yintervals, xintervals, zintervals);

Tempgrid(50, 59, 24) = 200;

%thermal conductivity = k, density = p, specific heat = c, dx = thickness

%LDPE: Thermal conductivity = 0.33 at 23C, specific heat = 1900-2300, density
%= 0.92
%HDPE: Thermal conductivity = 0.44 (W/m K)
%PP: k = 0.11, 
%Carbon nanotubes: k: 2000-6000, p = 1.6g/cm^3, c = 4130ish?
%Graphite: k: 100-400 on planes, p = 2.266, c = 0.72 J/g*C

%g = k / (p * dx * c)
g = ones(yintervals + 2, xintervals + 2, zintervals + 2, iter + 1);
g = g.* 1.708; %This is the map for all polyethylene. If it's all the same we can just use h without a matrix
%also, dd cancels out
h = 1.15655 * (10^(-4))/dd; % h = k * A / (m * c) = k / (p * dx * c)
%h is in meters per second, the ratio between temperature gradient and
%temperature change rate. %this is for copper
h = h * 100;
%r = 0.97 .* 5.67 .* 10^-8 .* p ./ dd .* (temp^4) ./ c .* dt
total_time = 3600; %seconds
dt = 20;
iter = total_time/dt;

wholeMatrix = zeros(yintervals + 2, xintervals + 2, zintervals + 2, iter + 1);
wholeMatrix(2:end-1, 2:end-1, 2:end-1, 1) = Tempgrid;

for j= 2:iter + 1
    old = wholeMatrix(:,:,:, j - 1).*g(:,:,:);
    wholeMatrix(2:end-1, 2:end-1, 2:end-1, j) = old(2:end-1, 2:end-1,2:end-1)./g(:,:,:) + dt.* ...
        (old(2:end-1, 1:end-2,2:end-1) + old(2:end-1, 3:end,2:end-1) + old(1:end-2,2:end-1,2:end-1) + old(3:end,2:end-1,2:end-1) - 4.*old(2:end-1, 2:end-1,2:end-1));
    wholeMatrix(2:end-1, 2:end-1, 2:end-1, j) = wholeMatrix(2:end-1, 2:end-1,2:end-1, j) + h.*dd.*dt .* ...
        (old(2:end-1, 2:end-1, 1:end-2) + old(2:end-1, 2:end-1, 3:end));
    wholeMatrix(2:end-1, 2:end-1, 2:end-1, j) = wholeMatrix(2:end-1, 2:end-1,2:end-1, j) - (0.97 .* 5.67 .* 10^-8 .* p ./ dd .* wholeMatrix(2:end-1, 2:end-1,2:end-1, j) ./ dc .* dt);
    wholeMatrix(:,:,0) = 0;
    wholeMatrix(:,:,end) = 0;
    wholeMatrix(:,0,:) = 0;
    wholeMatrix(:,end, :) = 0;
    wholeMatrix(0,:,:) = 0;
    wholeMatrix(end, :, :) = 0;
end

figure;
hold on;
[X,Y, Z] = meshgrid(0:dd:xdist, 0:dd:ydist, 0:dd:zdist);
F(j) = struct('cdata',[],'colormap',[]);

xslice = 0.25;
yslice = 0.25;
zslice = 0.1;

for j = iter + 1: -10: 1
    figure;
    slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1,j), xslice, yslice, zslice);
    alpha(0.7);
    drawnow
    F(j) = getframe(gcf);
end

%to play the movie
%fig = figure;
%movie(fig,F,2)

