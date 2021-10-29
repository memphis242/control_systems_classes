function [dX] = BeamDynamics_glower( X, T )
% Ball and Beam:  Sp21 Version
% m = 0.5 kg
% J = 2.0 kg m^2

r = X(1);
q = X(2);
dr = X(3);
dq = X(4);
g = 9.8;
m = 0.5;
J = 2.0;


M = [1.4*m, 0; 0, J + m*r*r];
B1 = m*r*dq*dq - m*g*sin(q);
B2 = T - 2*m*r*dr*dq - m*g*r*cos(q);

ddX = inv(M)*[B1; B2];
dX = [dr; dq; ddX];

end