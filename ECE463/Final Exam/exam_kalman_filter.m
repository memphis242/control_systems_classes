%% System description

% Ball & Beam
mball = 0.5; Rball = 1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0; 0 1 0 0]; D = [0;0];
Cz = [1 0 0 0 0]; % Servo-comp will only use x(t), not q(t)

% Disturbance
Aaug = [A, zeros(4,1); zeros(1,4), 0]; Baug = [B;0];
Caug = [C, [0;1]];
% return

%% Noise character
Bnu = [0;0;0;0.4;0];
nu_mu = 0; nu_sig = 0.02;
nr_mu = 0; nr_sig = 0.01;
nq_mu = 0; nq_sig = 0.03;


%% Observer
% Check observability
% OO = [Caug; Caug*Aaug; Caug*Aaug^2; Caug*Aaug^3; Caug*Aaug^4];
% rankOO = rank(OO)
% return

% Kalman filter
F = Bnu; V = nu_sig;
Q = F*V^2*F'; R = diag([nr_sig^2, nq_sig^2]);
Q = Q + 1e-5*eye(5);    % Because Q is too small
H = transpose(lqr(Aaug',Caug',Q,R));

% Check stability
eig(Aaug - H*Caug);

% return


%% Feedback Control Law
Kx = [-49.2998, 84.6513, -30.8701, 20.5731, 0]; % 0 for the dummy disturbance state
Kz = -20.5669;

%% Linear simulation
% Afull = [Aaug, -Baug*Kx, zeros(5,2); H*Caug, Aaug-H*Caug, zeros(5,2); zeros(2,5), Caug, zeros(2,2)];
% Bfull = [Baug, Bnu, zeros(5,4); Baug, zeros(5,1), H, zeros(5,2); zeros(2,4), diag([-1,-1])];
Afull = [Aaug, -Baug*Kx, -Baug*Kz; H*Caug, Aaug-Baug*Kx-H*Caug, -Baug*Kz; zeros(1,5), Cz 0];
Bfull = [Bnu, zeros(5,3); zeros(5,1), H, zeros(5,1); zeros(1,3), -1];
Cfull = [1, zeros(1,10); ...
         0,1,zeros(1,9); ...
         zeros(1,5),1,0,0,0,0,0; ...
         zeros(1,6),1,0,0,0,0; ...
         zeros(1,4),1,zeros(1,6); ...
         zeros(1,9),1,0];
Dfull = zeros(6,4);
% return
% Dfull(1,3) = 1; Dfull(2,4) = 1; % To see measured outputs instead...

d = 0.1;    % 0.1 rad offset for angle measurement
% X0 = zeros(11,1);
X0 = zeros(11,1); X0(5) = d;
Tend = 60; t = transpose(linspace(0,Tend,10001)); N = size(t);
% U = [zeros(N), zeros(N), zeros(N), ones(N)];
U = [normrnd(nu_mu,nu_sig,N), normrnd(nr_mu,nr_sig,N), normrnd(nq_mu,nq_sig,N), ones(N)];
Y = step3(Afull, Bfull, Cfull, Dfull, t, X0, U);

subplot(1,2,1);
plot(t,Y(:,[1:4]));
legend('x(t)','\theta(t)','x_e(t)','\theta_e(t)');
title('States');

subplot(1,2,2);
plot(t,Y(:,[5:6]));
legend('Angle Offset','Observer Estimate of Angle Offset');
title('Accounting for Angle Offset');
