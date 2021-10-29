function [A,B] = linearizedCartPend(m1, m2, R)
g = 9.8;
A = [0 0 1 0; 0 0 0 1; 0 (-m2*g/m1) 0 0; 0 ((m1+m2)*g/m1) 0 0];
B = [0;0;1/m1;-1/(m1*R)];
end