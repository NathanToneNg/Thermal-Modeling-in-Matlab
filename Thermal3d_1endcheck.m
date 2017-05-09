Tnorm = 0 + 273;
Tsphere = 250 + 273;
Cpe = 1900;
Csol = 1900;
%Conc = 0.001; %Of spheres in filler
ratio_by_mass = 125/(41 * 41 * 41); %of spheres in filler
Energy_total = (Tnorm * Cpe)*(1-ratio_by_mass) + (Tsphere * Csol * ratio_by_mass)%;
Tequ = Energy_total/(Cpe*(1-ratio_by_mass) + Csol*ratio_by_mass) - 273%;

