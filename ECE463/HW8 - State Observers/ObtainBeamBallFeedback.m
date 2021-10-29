function [Kx, Kr] = ObtainBeamBallFeedback(mball,Rball,mbeam,L,Ts,MOS)

% mball=1kg, Rball=3cm, mbeam=10kg, L=4m;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L) %#ok<NOPRT>
sig = getSigForTs(Ts);
[zeta, th, w] = getForOS(MOS,sig); %#ok<ASGLU>
dom_poles = [sig+1j*w, sig-1j*w];
des_poles = [dom_poles, 5*sig, 5*sig-1] %#ok<NOPRT>

C1 = [1 0 0 0]; % Position of ball
C2 = [0 1 0 0]; % Angle of beam
C = C1;

[Kx,Kr] = placePoles(A,B,C,des_poles) %#ok<NOPRT>

% G1 = ss(A-B*Kx, B*Kr, C1, 0);
% G2 = ss(A-B*Kx, B*Kr, C2, 0);
% Y = G1;
% U = ss(A-B*Kx, B*Kr, -Kx, Kr);
% 
% step(Y);
% hold on;
% step(G2);
% step(U);
% legend('r(t)','\theta(t)','T(t)');
% xlabel('Time (s)'); title('Linearized System Model: Step Response');
% hold off;

end