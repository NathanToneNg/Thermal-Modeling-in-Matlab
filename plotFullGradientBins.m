% plotFullGradientBins Will plot a gradient plot from gradientData,
%   assuming all other parts of the program are initiated to the right
%   settings.
%
%
function plotFullGradientBins

global gradientData xdist ydist zdist dd dimensions recordGradient

if ~recordGradient
    disp('Warning: This data may not be the right data for this file- global recordGradient is off.');
end

times = size(gradientData,2);
numberEl = 10;
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
maxDist = sqrt(midx^2 + midy^2 + midz^2);
diff = maxDist / numberEl;

figure;
hold on;
for j = 1:times
    color = [(j / (times + 1)) (1-(j / (times + 1))) (1 - (j / (times + 1)))];
    plot(diff/2:diff:maxDist, gradientData(:,j), '-o','Color', color);
end

end