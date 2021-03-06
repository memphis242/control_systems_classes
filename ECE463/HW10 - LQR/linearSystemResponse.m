A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1];
B = [1;0;0;0];
C = [0 0 0 1];
D = 0;

Kx = [3, 5, 7, 8];
Kr = 24;

Y = ss(A-B*Kx, B*Kr, C, 0);
U = ss(A-B*Kx, B*Kr, -Kx, Kr);

step(Y);
hold on;
step(U);
legend('y(t)','u(t)');  