% Gantry system

% System
mgc = 1; ml = 4; L = 1;
[A,B] = linearizedGantry(mgc,ml,L);
C = [1 0 0 0];

% Wind noise
Aw = [-5 0; 1 -5];
Bw = [1;0];
Cw = [100,-450];
Dw = 0;
mu = 0; sig = 1;

% Augmented system
Aaug = [A, B*Cw; zeros(2,4), Aw]; Baug = [B;zeros(2,1)];
Caug = [C, zeros(1,2)];
Haug = lqr(Aaug',Caug',diag([1,1,1,1,1e3,1e3]),0.01)'
% return

% Feedback gains
% Here, I used pole-placement to set des_poles = [-2,-3,-4,-5]
Kx = [12.2449   -9.7551   15.7143    1.7143];
Kr = 12.2449;

% Observer gains
% Here I used pole-placement to set the observer poles at [-5,-6,-7,-8]
des_obs_poles = [-5,-6,-7,-8,-9];
H = [26; -5.3061; 202; -209.6429];

% Initial conditions
X = zeros(4,1); Xe = zeros(4,1); Xw = zeros(2,1); Wind = 0; Xaug = zeros(6,1); Xaug_e = zeros(6,1);
dX = zeros(4,1); dXe = zeros(4,1); dXw = zeros(2,1); dXaug_e = zeros(6,1);

% Simulation setup
Ref = 0;
t = 0; dt = 100e-6; Tend = 10;
N = (Tend / dt) + 1;
% DATA = zeros(N,8); % x, th, xe, the, w, F+we
DATA = zeros(N,8); % x, th, xe, the, w, we, F, F+w-we

i=1;
tic
while(t < Tend)
%     U = Kr*Ref - Kx*X;
%     Uw = normrnd(mu,sig);
%     Wind = Cw*Xw;
%     
%     dX = GantryDynamics(X,U + Wind, mgc,ml,L);
%     dXe = A*Xe + B*U + H*C*(X - Xe);
%     dXw = Aw*Xw + Bw*Uw;

    U = Kr*Ref - Kx*X;
    Uw = normrnd(mu,sig);
    Wind = Cw*Xw;
    Wind_est = Cw*Xaug_e([5:6]);
    
    dX = GantryDynamics(X,U+Wind-Wind_est, mgc,ml,L);
    dXe = A*Xe + B*U + H*C*(X - Xe);
    dXw = Aw*Xw + Bw*Uw;
    dXaug_e = Aaug*Xaug_e + Baug*U + Haug*Caug*(Xaug - Xaug_e);

    X = X + dX * dt;
    Xe = Xe + dXe * dt;
    Xw = Xw + dXw * dt;
    Xaug = [X;Xw];
    Xaug_e = Xaug_e + dXaug_e * dt;
    t = t + dt;

%     DATA(i,:) = [X(1), X(2), Xe(1), -Xe(2), U, U+Wind];
    DATA(i,:) = [X(1), X(2), Xe(1), -Xe(2), Wind,Wind_est, U, U+Wind-Wind_est];
    i = i+1;

end
toc


kk = 1e2;
t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,kk);
tds = downsample(t,kk);

subplot(1,4,1);
plot(tds, DATAds(:,[1,3]));
grid on;
legend('x(t)','x_e(t)');
title('Simulated Response of Beam-Ball System: x(t)');
x_mu = mean(DATAds(:,1))
xstd_dev = std(DATAds(:,1))

subplot(1,4,2);
plot(tds, DATAds(:,[2,4]));
grid on;
legend('\theta(t)','\theta_e(t)');
title('Simulated Response of Beam-Ball System: \theta(t)');
th_mu = mean(DATAds(:,2))
thstd_dev = std(DATAds(:,2))

subplot(1,4,3);
plot(tds,DATAds(:,[5:6]));
grid on;
legend('Wind','Wind Estimate');
title('Wind and Wind Estimate');

subplot(1,4,4);
plot(tds,DATAds(:,[7:8]));
grid on;
legend('F(t)','F(t)+Wind-Wind_{est}');
title('\SigmaF(t)');

