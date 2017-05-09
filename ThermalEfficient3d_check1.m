clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
precision = 10;

%%%Distance
    xdist = 0.2;
    ydist = 0.2;
    zdist = 0.2;
    dd = 0.005; %Interval of distance
   
    xslice = 0.1; %Locations to graph
    yslice = 0.1;
    zslice = 0.1;

%%%Time
    total_time = 500; %seconds % 1 minute
    dt = 0.05;
    framerate = 500; %after how many timesteps (dt) will it make a new figure/frame

%%%Material Properties
    %LDPE
    Tm = 110; %Melting point
    specific_heat = 1900;
    density = 910; %kg/m^3
    thermal_Conductivity = 0.33;
    constant = thermal_Conductivity * dt / (density * specific_heat * dd * dd);
    
%%%Absorption
%     dQ = 30 * 1900 * 910;
%     dT_dt = dQ*dt/(specific_heat * density);
%     xfrequency = 3;
%     yfrequency = 3;
%     zfrequency = 2;
%     overalldensity = 1/(xfrequency * yfrequency * zfrequency);
%     fprintf('density of receptors is %g\n', overalldensity);

%%%Edges lose energy? true = boundaries so no energy loss, false =
%%%conduction to air
borders = true;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



digits(precision);
index = 1;


xintervals = xdist / dd + 1;
yintervals = ydist / dd + 1;
zintervals = zdist / dd + 1;
Tempgrid = zeros(xintervals, yintervals, zintervals);
Tempgrid(19:23,19:23,19:23) = 250;


iter = total_time/dt;


g = ones(xintervals + 2, yintervals + 2, zintervals + 2); %Will work for singular material, not confident in ability for multiple materials yet
g = g .* constant; %this will allow us to later have multiple materials in the same graphing (not yet confident at boundaries)


%r = 0.1 .* 5.67 .* 10^-8 ./ p ./ dd .* (temp^4) ./ c .* dt later; for
%radiation

r = epsilon .* sigma .* dt .* ((temp^4) - (roomTemp^4)) ./ (c .* density .* dd)


wholeMatrix = zeros(xintervals + 2, yintervals + 2, zintervals + 2);
wholeMatrix(2:end-1, 2:end-1, 2:end-1) = Tempgrid;

%%% movie stuff


F(floor((iter)/80)) = struct('cdata',[],'colormap',[]);
[X,Y,Z] = meshgrid(0:dd:xdist, 0:dd:ydist, 0:dd:zdist);



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
    wholeMatrix(2:end-1, 2:end-1, 2:end-1) = old(2:end-1, 2:end-1,2:end-1)./g(2:end-1,2:end-1,2:end-1) + ...
        (old(2:end-1, 1:end-2,2:end-1) + old(2:end-1, 3:end,2:end-1) + old(1:end-2,2:end-1,2:end-1) + ...
        old(3:end,2:end-1,2:end-1) - 6.*old(2:end-1, 2:end-1,2:end-1) + ...
        old(2:end-1, 2:end-1, 1:end-2) + old(2:end-1, 2:end-1, 3:end));
    %wholeMatrix(2:end-1, 2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1,2:end-1) - (0.97 .* 5.67 .* 10^-8 .* p ./ dd .* wholeMatrix(2:end-1, 2:end-1,2:end-1, j) ./ dc .* dt);
    
    
    if mod(j - 1, framerate) == 0
        mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1))))
        figure;
        slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), xslice, yslice, zslice);
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
mean(mean(mean(wholeMatrix(2:end-1,2:end-1,2:end-1))))
pause
close all;
fig = figure;
movie(fig,F,2)
close all;

slice(X,Y,Z, wholeMatrix(2:end-1,2:end-1,2:end-1), xslice, yslice, zslice);
caxis([0 (Tm + 20)])
colorbar('horiz')

melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
num = numel(Tempgrid);
ratio = melted/num;

fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);
