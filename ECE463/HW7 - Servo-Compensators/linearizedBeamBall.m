function [A,B] = linearizedBeamBall(mball, Rball, mbeam, L)
% mball=0.5kg, Rball=10e-2, mbeam=8/3kg, L=3m
g = 9.8;
Jball = (2/5)*mball*Rball^2;
Jbeam = (1/12)*mbeam*L^2;
A = [0 0 1 0; 0 0 0 1; 0 (-mball*g/(mball+Jball*Rball^2)) 0 0; (-mball*g/Jbeam) 0 0 0];
B = [0;0;0;1/Jbeam];
end