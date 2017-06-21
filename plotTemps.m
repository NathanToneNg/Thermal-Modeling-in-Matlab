%plotTemps: A tool used to plot primarily finalTemps, but any matrix no
%   matter whether it is 1, 2, or 3, dimensions- If that number of
%   dimensions matches the global 'dimensions' variable
%
function plotTemps(matrix)
    global xdist ydist zdist dd dimensions;
    if nargin < 1
        matrix = input('What matrix?\n ');
    end
    text = sprintf('global %s',matrix);
    eval(text);
    figure;
    switch dimensions
        case 1
            text = sprintf('plot(dd/2:dd:xdist, %s);', matrix);
            eval(text);
        case 2
            [X,Y] = meshgrid(dd/2:dd:ydist, dd/2:dd:xdist);
            text = sprintf('surf(X,Y,%s);',matrix);
            eval(text);
        case 3
            [X,Y,Z] = meshgrid(0:dd:ydist, 0:dd:xdist, 0:dd:zdist);
            xintervals = floor(xdist / dd);
            yintervals = floor(ydist / dd);
            zintervals = floor(zdist / dd);
            xslice = (ceil((xintervals-1)/2) * dd); 
            yslice = (ceil((yintervals-1)/2) * dd);
            zslice = (ceil((zintervals-1)/2) * dd);
            text = sprintf('slice(X,Y,Z, %s, yslice, xslice, zslice)',matrix);
            eval(text);
            
        
    end

end