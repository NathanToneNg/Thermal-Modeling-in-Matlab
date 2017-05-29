cycle_time = 20; %Iterations
cycle = 0:pi/20:pi-pi/20;
ratios = sin(cycle);
rotation = 0 .* constants(receivers) + 1;

rotation_size = size(rotation,1);
%Set however spread you want rotation to be, and where in the cycle each
%starts
for i = 1:20
    %Right now this makes it into 20 groups (by matlab ordering, which
    %is in x first, then y then z).
    rotation(1+floor(rotation_size/20*(i-1)):floor(rotation_size/20*i)) = i;
end

% if j >= iterOn && j <= iterOff
%     wholeMatrix(bigReceivers) = wholeMatrix(bigReceivers) + energyRate .* constants(receivers) .* dd .* ratios(rotation)';
% end
% rotation(:,:,:) = rotation(:,:,:) + 1;
% rotation(rotation > 20) = 1;
% 
