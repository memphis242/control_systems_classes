function [A,B] = linearizedCartPend(mcart, mball, L)
g = 9.8;
A = [0 0 1 0; 0 0 0 1; 0 (-mball*g/mcart) 0 0; 0 ((mcart+mball)*g/(mcart*L)) 0 0];
B = [0;0;1/mcart;-1/(mcart*L)];
end