function [ dX ] = GantryDynamics( X, F )
% gantryu dynamics  (Sp21 version)
% cart = 1kg
% ball = 4kg
% length = 1m
% X = [x, q, dx, dq]
x = X(1);
q = X(2);
dx = X(3);
dq = X(4);
g = -9.8;
M = [5 4*cos(q); 4*cos(q), 4];
A = [4*dq*dq*sin(q); 4*g*sin(q)];
B = [1;0];
d2X = inv(M) * (A + B*F);
dX = [dx; dq; d2X];
end