%going back and making a better 1d

clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
precision = 10;

%%%Distance
    xdist = 0.2;
    dd = 0.005; %Interval of distance

%%%Time
    total_time = 20000; %seconds
    dt = 0.05;
    framerate = 20000; %after how many timesteps (dt) will it make a new figure/frame

%%%Material Properties
    %LDPE
    Tm = 110; %Melting point
    specific_heat = 1900;
    density = 910; %kg/m^3
    thermal_Conductivity = 0.33;
    constant = thermal_Conductivity * dt / (density * specific_heat * dd * dd)
    
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
Tempgrid = zeros(xintervals,1);
Tempgrid(20:22) = 250;


iter = total_time/dt;


g = ones(xintervals + 2, 1); %Will work for singular material, not confident in ability for multiple materials yet
g = g .* constant; %this will allow us to later have multiple materials in the same graphing (not yet confident at boundaries)


%r = 0.97 .* 5.67 .* 10^-8 .* p ./ dd .* (temp^4) ./ c .* dt later; for
%radiation


wholeMatrix = zeros(xintervals + 2, 1);
wholeMatrix(2:end-1) = Tempgrid;

%%% movie stuff


F(floor((iter)/80)) = struct('cdata',[],'colormap',[]);



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
    %wholeMatrix(2:end-1, 2:end-1, 2:end-1) = wholeMatrix(2:end-1, 2:end-1,2:end-1) - (0.97 .* 5.67 .* 10^-8 .* p ./ dd .* wholeMatrix(2:end-1, 2:end-1,2:end-1, j) ./ dc .* dt);
    
    if mod(j - 1, framerate) == 0
        figure;
        plot(0:dd:xdist, wholeMatrix(2:end-1));
        ylim([0 50]);
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
ylim([0 50]);

% melted = anyMelting(wholeMatrix(2:end-1,2:end-1,2:end-1), Tm);
% num = numel(Tempgrid);
% ratio = melted/num;
% 
% fprintf('Ratio Melted = %d / %d = %g = %g%%\n', melted, num, ratio, ratio*100);

