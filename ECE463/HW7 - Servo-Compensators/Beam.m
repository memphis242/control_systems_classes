% Ball & Beam System
% ECE 463 Lecture #8

mball = 1; Rball = 3e-2;
mbeam = 10; L = 4;
Ts = 4; OS = 0.2;

% % Simple compensator
% [Kx, Kr] = ObtainBeamBallFeedback(mball, Rball, mbeam, L, Ts, OS);

% Servo Comp
% Servo Compensator
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0]; D = 0;
Aaug = [A, B*0; C, 0];
Baug = [B; 0];
Caug = [C, 0];
des_poles = [-1+1.9519j, -1-1.9519j, -5 -5 -5];
[Kx_aug, Kr_aug] = placePoles(Aaug,Baug,Caug, des_poles);
Kx = Kx_aug(1:4) %#ok<NOPTS>
Kz = Kx_aug(5) %#ok<NOPTS>

% % Check /w system
% AAA = [A-B*Kx, -B*Kz; C, 0];
% eg2 = [eig(A); 1.2345];
% fprintf('[Eigenvalues of Original System, Eigenvalues of Servo-comp System]:\n');
% [eg2, eig(AAA)] %#ok<NOPTS>
% pause
% 
% % Check using step-response
% BBB = [zeros(4,1);1];
% CCCy = [C 0];
% CCCu = [-Kx -Kz];
% ss_orig_y = ss(AAA,BBB,CCCy,D);
% ss_orig_u = ss(AAA,BBB,CCCu,D);
% 
% step(ss_orig_y);
% hold on;
% step(ss_orig_u);
% title('Step Response of System Servo-Comp');
% legend('r(t)', 'u(t)');
% grid on;
% pause
% hold off;
% clf;

%% Plot
X = zeros(4,1); Z = 0;
dX = zeros(4,1);
Ref = 1;
t = 0; dt = 1000e-6;
n = 0;
T_end = 15;
N = (T_end / dt) + 1;
DATA = zeros(N,6);

% dim = [0.3 0.6 0.2 0.15];
% an = annotation('textbox', dim, 'String', '', 'FitBoxToText', 'on');

i=1;
tic
while(t < T_end)
%     U = Kr*Ref - Kx*X;
    dq = X(4);
    U = -Kx*X - Kz*Z;
    P = dq*U;
    
    dX = BeamDynamics(X, U, mball, Rball, mbeam, L);
    dZ = C*X - Ref;

    X = X + dX * dt;
    Z = Z + dZ * dt;
    t = t + dt;

    DATA(i,:) = [X(1), X(2), X(4), P, U, Ref];
    i = i+1;
%     n = mod(n+1,30);
%     if(n == 0)
%         BeamDisplay(X, Ref);
%         str = sprintf('Time = %.3f s', t);
%         an.String = str;
%         drawnow;
%     end
end
toc
% pause;

max_torque_Nm = max(DATA(:,5))
max_torque_lbft = max_torque_Nm * 0.73756214927727
max_torque_ozin = max_torque_Nm * 141.61193227806

max_power_W = max(DATA(:,4))
max_power_hp = max_power_W * 0.00134102

t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,10);
tds = downsample(t,10);
plot(t,DATA);
grid on;
legend('r(t)','\theta(t)','\omega(t)','P(t)','u(t)','Ref');
title('Simulated Step Response of Beam-Ball System');
