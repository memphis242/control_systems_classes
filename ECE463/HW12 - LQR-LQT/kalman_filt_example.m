%% System description

% % Heat system
% A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1]; B = [1;0;0;0];
% C = [0 0 0 1]; D = 0;

% % Cart & Pendulum
% mcart = 1; mball = 1; L = 1;
% [A,B] = linearizedCartPend(mcart,mball,L);
% C = [1 0 0 0; 0 1 0 0]; D = [0;0];

% Gantry
mgc = 1; ml = 1; L = 1;
[A,B] = linearizedGantry(mgc,ml,L);
C = [1 0 0 0; 0 1 0 0]; D = [0;0];

% % Ball & Beam
% mball = 0.5; Rball = 1; mbeam = 4.8990; L = 2.4746;
% [A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
% C = [1 0 0 0]; D = 0;

%% Noise character
% F = [1;0;0;0];
Bnu = [0;0;1;-0.5];
nu_mu = 0; nu_sig = 1;
ny_mu = 0; ny_sig = 0.1;


%% Observer
% % Not accounting for noise...
% Q = diag([1 1 1 400]); R = eye(2);
% H = transpose(lqr(A',C',Q,R));

% Kalman filter
F = Bnu; V = nu_sig; W = ny_sig;
Q = F*V^2*F'; R = diag([ny_sig^2, ny_sig^2]);
H = transpose(lqr(A',C',Q,R));

% Check stability
eig(A - H*C);

% return

%% Linear simulation
Afull = [A, zeros(4,4); H*C, A-H*C];
Bfull = [B, Bnu, zeros(4,2); B, zeros(4,1), H];
Cfull = [1,zeros(1,7); 0,1,zeros(1,6); zeros(1,4),1,0,0,0; zeros(1,5),1,0,0];
Dfull = zeros(4,4);
% Dfull(1,3) = 1; Dfull(2,4) = 1; % To see measured outputs instead...

X0 = zeros(8,1);
Tend = 10; t = transpose(linspace(0,Tend,10001)); N = size(t);
U = [zeros(size(t)), normrnd(nu_mu,nu_sig,N), normrnd(ny_mu,ny_sig,N), normrnd(ny_mu,ny_sig,N)];

Y = step3(Afull, Bfull, Cfull, Dfull, t, X0, U);
plot(t,Y);
legend('x(t)','\theta(t)','x_e(t)','\theta_e(t)');
