function [A,B] = linearizedCartPend2(mc, ml, L)
g = 9.8;
A = [0 0 1 0; 0 0 0 1; 0 (-ml*g/mc) 0 0; 0 ((mc+ml)*g/(mc*L)) 0 0];
Bf = [0;0;1/mc;-1/(mc*L)];
Bt = [0;0;-1/mc;(mc+ml)/(mc*ml*L^2)];
B = [Bf,Bt];
end