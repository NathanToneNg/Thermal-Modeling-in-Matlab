%movie?

%two-dimensional
%Uses logical arrays (matrices)
digits(10);

xdist = 1;
ydist = 0.5;
dd = 0.005; %Interval of distance

xintervals = xdist / dd + 1;
yintervals = ydist / dd + 1;
Tempgrid = zeros(yintervals, xintervals);

Tempgrid(5, 5) = 200;
Tempgrid(10, 15) = 200;

h = 1.15655 * (10^(-4))/dd; % h = k * A / (m * c) = k / (p * dx * c)
%h is in meters per second, the ratio between temperature gradient and
%temperature change rate. %this is for copper
h = h * 100

total_time = 36000; %seconds
dt = 1;
iter = total_time/dt;

wholeMatrix = zeros(yintervals + 2, xintervals + 2, iter + 1);
wholeMatrix(2:end-1, 2:end-1, 1) = Tempgrid;

for j= 2:iter + 1
    old = wholeMatrix(:,:,j - 1);
    wholeMatrix(2:end-1, 2:end-1, j) = old(2:end-1, 2:end-1) + h.*dd.* ...
        (old(2:end-1, 1:end-2) + old(2:end-1, 3:end) + old(1:end-2,2:end-1) + old(3:end,2:end-1) - 4.*old(2:end-1, 2:end-1));
%     wholeMatrix(1:end-1, 1:end-1,j) = wholeMatrix(1:end-1, 1:end-1,j) + h.*dd.* ...
%         (old(2:end, 1:end-1) + old(1:end-1, 2:end) - (2.*old(1:end-1, 1:end-1)));
%     wholeMatrix(2:end,2:end,j) = wholeMatrix(2:end,2:end,j) + h.*dd.* ...
%         (old(1:end-1, 2:end) + old(2:end, 1:end-1) - (2.*old(2:end,2:end)));

end

figure;
hold on;
[X,Y] = meshgrid(0:dd:xdist, 0:dd:ydist);
F(361) = struct('cdata',[],'colormap',[]);
for j = 1:100:iter + 1
    surf(X,Y,wholeMatrix(2:end-1,2:end-1,j));
    drawnow
    F(j) = getframe(gcf);
end

%to play the movie
%fig = figure;
%movie(fig,F,2)

