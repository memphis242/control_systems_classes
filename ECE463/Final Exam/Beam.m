% Ball & Beam System

% System
mball = 0.5; Rball = 1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0; 0 1 0 0];
Aaug = [A, zeros(4,1); zeros(1,4), 0]; Baug = [B;0];
Caug = [C, zeros(2,1)];

% Feedback gains
Kx = [-49.2998   84.6513  -30.8701   20.5731];
Kz = -20.5669;

% Observer gains
H = [4.2513,-0.2425; -2.3155,0.2082; 9.2513,-0.6711; -3.9025,0.2997; 0.1328,0.0957];

% Noise
nu_mu = 0; nu_sig = 0.02;
nr_mu = 0; nr_sig = 0.01;
nq_mu = 0; nq_sig = 0.03;

% Initial conditions
X = zeros(5,1); Xe = zeros(5,1); Z = 0;
d = 0.1;
dX = zeros(5,1); dXe = zeros(5,1);
X(5) = d; % Disturbance

% Simulation setup
Ref = 1;
t = 0; dt = 100e-6; Tend = 60;
N = (Tend / dt) + 1;
DATA = zeros(N,7); % x, th, xe, the, T, d, de

i=1;
tic
while(t < Tend)
    if t < 55
%         U = -Kz*Z - Kx*X([1:4]);
        U = -Kz*Z - Kx*X([1:4]) + normrnd(nu_mu,nu_sig);
        dZ = X(1) + normrnd(nr_mu,nr_sig) - Ref;
    else
%         U = -Kz*Z - Kx*Xe([1:4]);
        U = -Kz*Z - Kx*Xe([1:4]) + normrnd(nu_mu,nu_sig);
%         dZ = Xe(1) - Ref;
        dZ = Xe(1) + normrnd(nr_mu,nr_sig) - Ref;
    end
    
    dX([1:4]) = BeamDynamics(X([1:4]), U, mball, Rball, mbeam, L);
    dXe = Aaug*Xe + Baug*U + H*Caug*(X + [normrnd(nr_mu,nr_sig);normrnd(nq_mu,nq_sig);0;0;0] - Xe);

    X = X + dX * dt;
    Xe = Xe + dXe * dt;
    Z = Z + dZ * dt;
    t = t + dt;

    DATA(i,:) = [X(1), X(2), Xe(1), Xe(2), U, X(5), Xe(5)];
    i = i+1;

end
toc

kk = 1e3;
t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,kk);
tds = downsample(t,kk);

subplot(1,2,1);
plot(tds,DATAds(:,[1:4]));
grid on;
legend('r(t)','\theta(t)','r_e(t)','\theta_e(t)');
title('Simulated Step Response of Beam-Ball System');

subplot(1,2,2);
plot(tds,DATAds(:,5), tds,DATAds(:,6));
grid on;
legend('d_{est}','d');
title('Disturbance vs Disturbance Estimate');

