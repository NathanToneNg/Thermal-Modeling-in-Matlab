global specific_heat density dd emissivity

sigma = 5.67 * 10^-8;
z = 273.15;
T = 523.15;
constPart1 = ((1/(4*sqrt(2)*(z^3))) * (-log(T^2 - sqrt(2)*T*z + z^2) + log(T^2 + sqrt(2)*T*z + z^2) - 2*atan(1 - sqrt(2)*T/z)+ 2*atan(1 + sqrt(2)*T/z)))


const = constPart1 - 0;

