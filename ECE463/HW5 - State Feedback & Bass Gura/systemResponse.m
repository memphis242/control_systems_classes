A = [-10.5 5 0 0 0; 5 -10.5 5 0 0; 0 5 -10.5 5 0; 0 0 5 -10.5 5; 0 0 0 5 -5.5];
B = [30;0;0;0;0];
C = [0 0 0 0 1];
olPoles = flip(eig(A));
des_poles = [-2+2.0972j,-2-2.0972j,-10,-11,-12];

[Kx,Kr] = placePoles(A,B,C,des_poles)

G = ss(A-B*Kx, B*Kr, C, 0);
U = ss(A-B*Kx, B*Kr, -Kx, Kr);

step(G);
hold on;
step(U);
legend('y(t)','u(t)');