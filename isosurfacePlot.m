function isosurfacePlot(matrix)

% X,Y,Z iz the meshgrid and V is my function evaluated at each meshpoint
global finalTemps xdist ydist zdist dd;

if nargin == 0
    V = reshape(finalTemps, floor(xdist / dd + 1),floor(ydist / dd + 1),floor(zdist / dd + 1));
else
    V = reshape(matrix, floor(xdist / dd + 1),floor(ydist / dd + 1),floor(zdist / dd + 1));
end



[X,Y,Z] = meshgrid(0:dd:ydist, 0:dd:xdist, 0:dd:zdist);
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
end