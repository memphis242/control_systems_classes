function [ dX ] = GantryDynamics_glower( X, F )
% [dX] = GantryDynamics(X, F)
% ECE 463 Lecture #7
% cart = 2kg
% ball = 1kg
% length = 1m
% X = [x, q, dx, dq]

x = X(1);
q = X(2);
dx = X(3);
dq = X(4);

g = -9.8;

M = [3, cos(q); cos(q), 1];
A = [dq*dq*sin(q); g*sin(q)];
B = [1;0];
d2X = inv(M) * (A + B*F);
dX = [dx; dq; d2X];
end