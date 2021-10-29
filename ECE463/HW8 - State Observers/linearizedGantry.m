function [A,B] = linearizedGantry(mgc, ml, L)
g = 9.8;
A = [0 0 1 0; 0 0 0 1; 0 (ml*g/mgc) 0 0; 0 -((ml+mgc)*g/(mgc*L)) 0 0];
B = [0;0;1/mgc;-1/(mgc*L)];
end