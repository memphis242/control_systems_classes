function [ dX ] = GantryDynamics( X, F, mgc, ml, L )
% X = [x, q, dx, dq]

x = X(1);
q = X(2);
dx = X(3);
dq = X(4);

g = 9.8;
M = [(mgc+ml), ml*L*cos(q); ml*L*cos(q), ml*L^2];
A = [ml*L*dq*dq*sin(q); -ml*L*g*sin(q)];
B = [1;0];
d2X = inv(M) * (A + B*F);
dX = [dx; dq; d2X];

end