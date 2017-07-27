% depthGradientPlot Plots the average temperature of each each layer sphere
% from the center of the matrix. 
% Use as depthGradientPlot(matrix, bins, [R G B]) (each optional; must have previous 
%   to have latter options)
%
% Meant mainly as what is to be used by the complete program.
%
function depthGradientPlotBins(matrix, bins, color, iteration)
if nargin > 2 && ~all(size(color) == [1 3])
    error('Color input must be in form [0.5 0.9 0], with three elements between 0 and 1.');
end

global dd xdist ydist zdist dimensions recordGradient gradientData
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

if numel(matrix) ~= xintervals * yintervals * zintervals
    error('Incorrect number of elements in matrix compared to global parameters');
end  

midx = ceil(xintervals/2);
midy = ceil(yintervals/2);
midz = ceil(zintervals/2);

if nargin <= 1
    numberEl = 10; %Defualt
else
    numberEl = bins;
end


maxDist = sqrt(midx^2 + midy^2 + midz^2);
diff = maxDist / numberEl;

sums = zeros(numberEl, 1);
amount = zeros(numberEl, 1);

for i = 1:xintervals
    for j = 1:yintervals
        for k = 1:zintervals
            dist = floor(sqrt((midx - i)^2 + (midy - j)^2 + (midz - k)^2)/maxDist * numberEl) + 1;
            if dist == numberEl + 1 %If it is the very furthest distance, just put it in the last bin
                dist = numberEl;
            end
            sums(dist) = sums(dist) + matrix(i, j, k);
            amount(dist) = amount(dist) + 1;
        end
    end
end
averages = sums ./ amount;
if recordGradient && nargin == 4
    gradientData(:,iteration) = averages;
end
if nargin > 2
    plot(diff/2:diff:maxDist, averages, '-o','Color', color);
else
    plot(diff/2:diff:maxDist, averages, '-o');
end

end