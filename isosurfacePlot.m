%isosurfacePlot: Plots the matrix provided (or finalTemps if none is given)
%   in an isosurface plot, currently configured to plot every 10th
%   percentile from lowest = green to highest = red.
%
% Only works with 3D variables; program assumes that finalTemps, xdist,
% ydist, zdist, and dd (result temperatures and size settings) are aligned.
%
function isosurfacePlot(matrix)

% X,Y,Z iz the meshgrid and V is my function evaluated at each meshpoint
global finalTemps xdist ydist zdist dd;
if numel(finalTemps) ~= floor(xdist / dd)*floor(ydist / dd)*floor(zdist / dd)
    error('Incorrect number of elements in matrix compared to global parameters');
end
if nargin == 0
    V = reshape(finalTemps, floor(xdist / dd),floor(ydist / dd),floor(zdist / dd));
else
    V = reshape(matrix, floor(xdist / dd),floor(ydist / dd),floor(zdist / dd));
end



[X,Y,Z] = meshgrid(dd/2:dd:ydist, dd/2:dd:xdist, dd/2:dd:zdist);
Vmax = max(max(max(V)));
Vmin = min(min(min(V)));
Vrange = Vmax - Vmin;
figure;
hold on;
for i = 1:10
    %a = 1.1.^(i); % 'a' defines the isosurface limits
    p = patch(isosurface(X,Y,Z,V,Vmin + (i/10)*Vrange)); % isosurfaces at max(V)/a
    isonormals(X,Y,Z,V,p); % plot the surfaces
    
    %Red is warmest, green is coolest
    set(p,'FaceColor',[i/10,1-i/10,0.2],'EdgeColor','none'); % set colors
    %set(p,'FaceColor',[1-i/10,i/10,0.2],'EdgeColor','none'); % set colors
end
alpha(.075); % set the transparency for the isosurfaces
daspect([1 1 1]); box on; axis tight;
hold off;

%To see what the most red is, that is Vmax. Each shade green-er is a tenth
%of the range less. 

end