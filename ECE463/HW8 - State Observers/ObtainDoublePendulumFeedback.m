function [Kx, Kr] = ObtainDoublePendulumFeedback()

g = 9.8;
A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 -2*g 0 0 0 0; 0 3*g -g 0 0 0; 0 -3*g 3*g 0 0 0];
B = [0;0;0;1;-1;1];

des_poles = [-0.5+0.5244j, -0.5-0.5244j, 0,-0.75,-0.8,-0.8];

C1 = [1 0 0 0 0 0]; % Position of cart
C2 = [0 1 0 0 0 0]; % Angle of first mass
C3 = [0 0 1 0 0 0]; % Angle of second mass
C = C2;

[Kx,Kr] = placePoles(A,B,C,des_poles) %#ok<NOPRT>

G1 = ss(A-B*Kx, B*Kr, C1, 0);
G2 = ss(A-B*Kx, B*Kr, C2, 0);
G3 = ss(A-B*Kx, B*Kr, C3, 0);
G = G1;
U = ss(A-B*Kx, B*Kr, -Kx, Kr);

step(G);
hold on;
step(G2);
step(U);
legend('x(t)','\theta_1(t)','\theta_2(t)');
xlabel('Time (s)'); title('Linearized System Model: Step Response');
hold off;

end