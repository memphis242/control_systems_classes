m1 = 1; m2 = 4; R = 1;
[A,B] = linearizedCartPend(m1,m2,R)

% A = [0 0 1 0; 0 0 0 1; 0 -39.2 0 0; 0 49 0 0];
% B = [0; 0; 1; -1];
C1 = [1 0 0 0]; % Position of cart
C2 = [0 1 0 0]; % Angle of bar
C = C1;
olPoles = flip(eig(A));
des_poles = [-0.5+0.5244j,-0.5-0.5244j,-2.5,-3.5];

[Kx,Kr] = placePoles(A,B,C,des_poles)

G1 = ss(A-B*Kx, B*Kr, C1, 0);
G2 = ss(A-B*Kx, B*Kr, C2, 0);
G = G1;
U = ss(A-B*Kx, B*Kr, -Kx, Kr);

step(G);
hold on;
step(G2);
step(U);
legend('x(t)','\theta(t)','F(t)');  