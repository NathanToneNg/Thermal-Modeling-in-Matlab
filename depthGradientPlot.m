% depthGradientPlot Plots the average temperature of each each layer sphere
% from the center of the matrix. 
%
%
%
%
function depthGradientPlot(matrix, color)

if nargin == 2 && ~all(size(color) == [1 3])
    error('Color input must be in form [0.5 0.9 0], with three elements between 0 and 1.');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
freq = 8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%

global dd xdist ydist zdist dimensions
if nargin < 1
    global finalTemps;
    matrix = finalTemps;
end

xintervals = floor(xdist / dd);
if dimensions > 1
    yintervals = floor(ydist / dd);
else
    yintervals = 1;
end
if dimensions > 2
    zintervals = floor(zdist / dd);
else
    zintervals = 1;
end

midx = ceil(xintervals/2);
midy = ceil(yintervals/2);
midz = ceil(zintervals/2);

maxSize = round(freq*sqrt(midx^2 + midy^2 + midz^2)) + 1;

sums = zeros(maxSize, 1);
amount = zeros(maxSize, 1);

for i = 1:xintervals
    for j = 1:yintervals
        for k = 1:zintervals
            dist = round(freq*sqrt((midx - i)^2 + (midy - j)^2 + (midz - k)^2)) + 1;
            sums(dist) = sums(dist) + matrix(i, j, k);
            amount(dist) = amount(dist) + 1;
        end
    end
end
averages = sums ./ amount;
if nargin == 2
    plot(0:dd/freq:maxSize*dd/freq - dd/freq, averages, 'Color', color);
else
    plot(0:dd/freq:maxSize*dd/freq - dd/freq, averages);
end

end