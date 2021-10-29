function [ dX ] = CartDynamics( X, F, mcart, mball, L )

%cart dynamics  (Sp21 version)
% X = [x, q, dx, dq]
g = 9.8;

x = X(1); %#ok<NASGU>
q = X(2);
dx = X(3);
dq = X(4);

M = [(mcart+mball) (mball*L*cos(q)); (mball*L*cos(q)) (mball*L^2)];
A = [mball*L*dq*dq*sin(q); mball*L*g*sin(q)];
B = [1;0];
d2X = inv(M) * (A + B*F); %#ok<MINV>
dX = [dx; dq; d2X];

end