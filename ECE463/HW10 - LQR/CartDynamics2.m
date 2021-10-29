function [ dX ] = CartDynamics2( X, F, T, mc, ml, L )

%cart dynamics  (Sp21 version)
% X = [x, q, dx, dq]
g = 9.8;

x = X(1); %#ok<NASGU>
q = X(2);
dx = X(3);
dq = X(4);

M = [(mc+ml) (ml*L*cos(q)); (ml*L*cos(q)) (ml*L^2)];
A = [ml*L*dq*dq*sin(q); ml*L*g*sin(q)];
Bf = [1;0]; Bt = [0;1];
d2X = inv(M) * (A + Bf*F + Bt*T); %#ok<MINV>
dX = [dx; dq; d2X];

end