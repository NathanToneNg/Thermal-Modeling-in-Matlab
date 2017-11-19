% graphSlice plots a 2d plot at a specific x- interval in the matrix provided.
%   graphSlice( matrix, interval) will plot at the x-interval into the
%   matrix. The defaults for each variable not provided are finalTemps and
%   the middle interval of said matrix respectively. 
%
%   Program will assume that if only argument is a 1x1s, it is the
%   interval provided.
%
function graphSlice(matrix, interval)
global finalTemps
    switch nargin
        case 0
            matrix = finalTemps;
            interval = floor(size(matrix,1)/2);
        case 1
            if size(matrix, 1) == 1 && size(matrix, 2) == 1
                interval = matrix;
                matrix = finalTemps;
            else
                interval = floor(size(matrix,1)/2);
            end
        case 2
        otherwise
            error('Use as graphSlice(matrix, interval to graph at)');
    end
    if size(matrix,1) < interval || interval < 1
        error('interval not within matrix');
    end
    surfc(permute(matrix(interval, :,:),[2 3 1]));
    xlabel('y direction');
    ylabel('z direction (up/down)');
    zlabel('Temperature');
    titleString = sprintf('Cross Section at interval %d',interval);
    title(titleString);
    colorbar
end