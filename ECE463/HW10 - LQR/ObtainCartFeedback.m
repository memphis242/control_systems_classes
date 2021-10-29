function [Kx, Kr] = ObtainCartFeedback(mcart,mball,L, Ts, MOS)

% m1 = 1; m2 = 4; R = 1;
[A,B] = linearizedCartPend(mcart,mball,L) %#ok<NOPRT>
sig = getSigForTs(Ts);
[zeta, th, w] = getForOS(MOS,sig); %#ok<ASGLU>
dom_poles = [sig+1j*w, sig-1j*w];
des_poles = [dom_poles, 5*sig, 5*sig-1] %#ok<NOPRT>

C1 = [1 0 0 0]; % Position of cart
C2 = [0 1 0 0]; % Angle of bar
C = C1;
% olPoles = flip(eig(A));

[Kx,Kr] = placePoles(A,B,C,des_poles) %#ok<NOPRT>

G1 = ss(A-B*Kx, B*Kr, C1, 0);
G2 = ss(A-B*Kx, B*Kr, C2, 0);
G = G1;
U = ss(A-B*Kx, B*Kr, -Kx, Kr);

step(G);
hold on;
step(G2);
step(U);
legend('x(t)','\theta(t)','F(t)');
xlabel('Time (s)'); title('Linearized System Model: Step Response');
hold off;

end