function [dX] = BeamDynamics( X, T, mball, Rball, mbeam, L )
% Ball and Beam:  Sp21 Version
% m = 0.5 kg
% J = 2.0 kg m^2

r = X(1);
q = X(2);
dr = X(3);
dq = X(4);
g = 9.8;
% mball = 0.5; Rball = 10e-2;
% mbeam = 1; L = 4;

Jball = (2/5)*mball*Rball^2;
Jbeam = (1/12)*mbeam*L^2;

M = [(mball + Jball*Rball^2), 0;
    0, ((mball + Jball*Rball^2)*r^2 + Jbeam)];
B1 = (mball + Jball*Rball^2)*dq^2 - mball*g*sin(q);
B2 = T - 2*(mball + Jball*Rball^2)*dq*r*dr - mball*g*cos(q);

ddX = inv(M)*[B1; B2];
dX = [dr; dq; ddX];

end