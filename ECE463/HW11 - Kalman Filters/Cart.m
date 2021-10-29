% Cart and Pendulum
% EC 463 Lecture 7
% main calling routine

% System
mcart = 1; mball = 4; L = 1;
[A,B] = linearizedCartPend(mcart,mball,L);
C = [1 0 0 0];

% Noise
F = B;
nu_mu = 0; nu_sig = 0.02;
ny_mu = 0; ny_sig = 0.01;

% Feedback gains
Kx = [-1218, -2267.9, -666, -711.8];
Kz = -743.3707;

% Observer gains
% H = [18; -31.2245; 168; -219.1837];
H = [14.9088; -19.9151; 111.1360; -139.4200];

% Initial conditions
% % Trial 1
% X = zeros(4,1); Z = 0;
% dX = zeros(4,1);

% Trial 2
X = zeros(4,1); Xe = zeros(4,1); Z = 0;
dX = zeros(4,1); dXe = zeros(4,1);

% Simulation setup
Ref = 1;
t = 0; dt = 100e-6; Tend = 20;
N = (Tend / dt) + 1;

% % Trial 1
% DATA = zeros(N,3); % x, th, T
% Trial 2
DATA = zeros(N,4); % x,th,xe,the,T

i=1;
tic
while(t < Tend)
    
%     % Trial 1
% %     U = -Kz*Z - Kx*X;
%     U = -Kz*Z - Kx*X + normrnd(nu_mu,nu_sig);
%     
%     dX = CartDynamics(X,U,mcart,mball,L);
%     dZ = C*X + normrnd(ny_mu,ny_sig) - Ref;
%     
%     X = X + dX*dt;
%     Z = Z + dZ*dt;
%     t = t + dt;
    
%     Trial 2
    U = -Kz*Z - Kx*Xe + normrnd(nu_mu,nu_sig);
    
    dX = CartDynamics(X, U, mcart, mball, L);
    dXe = A*Xe + B*U + H*C*(X - Xe);
    dZ = C*X + normrnd(ny_mu,ny_sig) - Ref;

    X = X + dX*dt;
    Xe = Xe + dXe*dt;
    Z = Z + dZ*dt;
    t = t + dt;

%     DATA(i,:) = [X(1), X(2), U];
    DATA(i,:) = [X(1), X(2), Xe(1), Xe(2)];
    i = i+1;

end
toc

kk = 10;
t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,kk);
tds = downsample(t,kk);

% plot(tds,DATAds(:,1), tds,DATAds(:,2), tds,DATAds(:,3));
% legend('x(t)','\theta(t)','T(t)');
plot(tds,DATAds);
legend('x(t)','\theta(t)','x_e(t)','\theta_e(t)');
grid on;
title('Simulated Step Response of Cart-Pendulum System');

