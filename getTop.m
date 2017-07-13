% getTop    Returns the average of top of a matrix, down to a given depth.
%
%   [averageTemp] = getTop(matrix, depth) will get the elements from the
%       top of the matrix down to depth, assuming the global constants are
%       accurate. getTop will then return the average of those elements.
%
%   Top is considered the maximum z dimension values in matrix(x, y, z).
%
function [averageTemp] = getTop(matrix, depth_) %Consider changing this so get depth from globals instead of being passed in
    global dimensions xdist ydist zdist dd;
    if nargin ~= 2
        global depth;
        depth_ = depth;
    end
    if dimensions ~= 3
        error('This function should only work and be needed in three dimensions.');
    end
    xintervals = floor(xdist / dd);
    yintervals = floor(ydist / dd);
    zintervals = floor(zdist / dd);
    
    if numel(matrix) ~= xintervals * yintervals * zintervals
        error('Matrix does not match the global parameters');
    end
    
    topDistance = round(depth_ / dd);
    lowRange = zintervals - topDistance;
    averageTemp = mean(mean(mean(matrix(:,:,lowRange+1:end))));

end