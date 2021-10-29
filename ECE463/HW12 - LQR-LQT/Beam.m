% Ball & Beam System

% System
mball = 0.5; Rball = 1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0];
Ad = 0; Cd = 1;
Aaug = [A, B*0; C*0, Ad]; Baug = [B;0];
Caug = [C, 1];

% Feedback gains
Kx = [-13.4714   87.4992  -17.8570   24.9998];
Kr = -8.5714;

% Observer gains
des_obs_poles = [-5,-6,-7,-8,-9];
H = transpose(placePoles2(Aaug',Caug',des_obs_poles));
% H = 1e3*[1.1370; -0.4750; 0.4850; -1.6125; -1.1020];

% Initial conditions
X = zeros(5,1); Xe = zeros(5,1); d = 1;
dX = zeros(5,1); dXe = zeros(5,1);
X(5) = d; % Disturbance

% Simulation setup
Ref = 1;
t = 0; dt = 100e-6; Tend = 30;
N = (Tend / dt) + 1;
DATA = zeros(N,7); % x, th, xe, the, T

i=1;
tic
while(t < Tend)
    if t < 10
        U = Kr*Ref - Kx*X([1:4]);
    else
        U = Kr*Ref - Kx*Xe([1:4]);
    end
    
    dX([1:4]) = BeamDynamics(X([1:4]), U, mball, Rball, mbeam, L);
    dXe = Aaug*Xe + Baug*U + H*Caug*(X - Xe);

    X = X + dX * dt;
    Xe = Xe + dXe * dt;
    t = t + dt;

    DATA(i,:) = [X(1), X(2), Xe(1), Xe(2), X(5), Xe(5), U];
    i = i+1;

end
toc

% max_torque_Nm = max(DATA(:,5))
% max_torque_lbft = max_torque_Nm * 0.73756214927727
% max_torque_ozin = max_torque_Nm * 141.61193227806
% 
% max_power_W = max(DATA(:,4))
% max_power_hp = max_power_W * 0.00134102

kk = 1e3;
t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,kk);
tds = downsample(t,kk);

subplot(1,2,1);
plot(tds,DATAds(:,1), tds,DATAds(:,2), tds,DATAds(:,3), tds,DATAds(:,4), tds,DATAds(:,7));
grid on;
legend('r(t)','\theta(t)','r_e(t)','\theta_e(t)','u(t)');
title('Simulated Step Response of Beam-Ball System');

subplot(1,2,2);
plot(tds,DATAds(:,5), tds,DATAds(:,6));
grid on;
legend('d','d_{est}');
title('Disturbance vs Disturbance Estimate');

