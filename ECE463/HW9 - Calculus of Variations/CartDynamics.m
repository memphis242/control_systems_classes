function [ dX ] = CartDynamics( X, F, m1, m2, R )

%cart dynamics  (Sp21 version)
% X = [x, q, dx, dq]
g = 9.8;

x = X(1); %#ok<NASGU>
q = X(2);
dx = X(3);
dq = X(4);

M = [(m1+m2) (m2*R*cos(q)); (m2*R*cos(q)) (m2*R^2)];
A = [m2*R*dq*dq*sin(q); m2*R*g*sin(q)];
B = [1;0];
d2X = inv(M) * (A + B*F); %#ok<MINV>
dX = [dx; dq; d2X];

end