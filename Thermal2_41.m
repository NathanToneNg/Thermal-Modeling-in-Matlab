%2.4, but practicing using logical arrays to replace

total_distance = 10;
dx = 0.05; %meters
%will hold temperature values
size = (total_distance/dx) + 1;
array = (1:size).*0;
array(1) = 200; %first value is different

h = 1.15655 * (10^(-4));%/(dx * dx); % h = k * A / (m * c) = k / (p * dx * dx * c)
%h is in meters per second, the ratio between temperature gradient and
%temperature change rate. %this is for copper

total_time = 3600; %seconds
dt = 0.05;
iter = total_time/dt;


wholeMatrix = zeros(size, iter + 1);
wholeMatrix(:, 1) = array;
temp = array;
for j=1:iter %iterates for this time intervals
    temp(1:(size - 1)) = temp(1:(size - 1)) + (h./dx.* (array(2:size) - array(1:size-1)));
    temp(2:size) = temp(2:size) + (h./dx.* (array(1:size-1) - array(2:size)));
    
    wholeMatrix(:, j + 1) = temp(:)'; %column 0 is at time = 0, column end is at time = total_time
    array = temp;
end

%plot(1:size, wholeMatrix(:, {time iteration})) to plot the values at a
%specific time

%plot(1:(iter + 1), wholeMatrix(1,:)) to plot the values at specific point
%across all times. Change the 1 ^ there to change point 
hold on;
for k = 1:(iter/10):(iter + 1)
    figure;
    plot(1:size, wholeMatrix(:, k));
end
%ylim([0 7]);
%xlim([0 size]);