function [Kx, Kr] = ObtainBeamBallFeedback()

A = [0 0 1 0; 0 0 0 1; 0 -7 0 0; -1.96 0 0 0];
B = [0;0;0;0.4];

des_poles = [-0.5+0.5244j, -0.5-0.5244j, -2.5, -3.5];

C1 = [1 0 0 0]; % Position of ball
C2 = [0 1 0 0]; % Angle of beam
C = C1;

[Kx,Kr] = placePoles(A,B,C,des_poles) %#ok<NOPRT>

G1 = ss(A-B*Kx, B*Kr, C1, 0);
G2 = ss(A-B*Kx, B*Kr, C2, 0);
G = G1;
U = ss(A-B*Kx, B*Kr, -Kx, Kr);

step(G);
hold on;
step(G2);
step(U);
legend('r(t)','\theta(t)','T(t)');
xlabel('Time (s)'); title('Linearized System Model: Step Response');
hold off;

end