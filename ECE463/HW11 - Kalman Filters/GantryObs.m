rng(1168874);

% Gantry System ( Sp21 version)
mgc = 2.0;
ml = 1.0;
L = 1.0;

%% System model
[A,B] = linearizedGantry(mgc,ml,L);
C = [1,0,0,0];

%% I checked observability through x and system is observable
% NN = rank([C; C*A; C*A^2; C*A^3])
% pause

%% Now compute H using Bass-Gura
des_poles = [-1 -2 -3 -4];
H = transpose(placePoles(A', C', C, des_poles));

%% Now check using step3
% Aaug = [A, zeros(4,4); H*C, A-H*C]; Baug = [B;B];
% Caug = eye(8); Daug = zeros(8,1);
% X0 = [zeros(4,1);5*rand(4,1)];
% T_end = 20; t = transpose(linspace(0,T_end,1001));
% R = 0*t + 1;    % We'll just see step response
% Y = step3(Aaug, Baug, Caug, Daug, t, X0, R);
% plot(t,Y(:,[1:4]), t,Y(:,[5:8]),'--');
% grid on; xlabel('Time (s)'), ylabel('States'), title('Gantry System: Actual States vs State Estimates');
% pause;
% % return

%% Nonlinear Simulation
clf
X = zeros(4,1); Xe = 5*rand(4,1);
dX = zeros(4,1); dXe = zeros(4,1);
dt = 100e-6; T_end = 20; t = 0;
N = (T_end / dt) + 1;
DATA = zeros(N,9); i=1;

tic
while(t < T_end)
    U = 2*cos(t);

    dX = GantryDynamics(X,U, mgc,ml,L);
    dXe = A*Xe + B*U + H*C*(X - Xe);

    X = X + dX * dt;
    Xe = Xe + dXe * dt;
    t = t + dt;
    
    DATA(i,:) = [X', Xe', norm(dXe)];
    i = i+1; 
end
toc

t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,10);
tds = downsample(t,10);

subplot(2,2,1);
plot(t,DATA(:,1), t,DATA(:,5),'--');
legend('x(t)', 'x_{est}(t)');
grid on;
title('x(t) vs x_{est}(t)'); xlabel('Time (s)');

subplot(2,2,2);
plot(t,DATA(:,2), t,DATA(:,6),'--');
legend('\theta(t)', '\thetax_{est}(t)');
grid on;
title('\theta(t) vs \theta_{est}(t)'); xlabel('Time (s)');

subplot(2,2,3);
plot(t,DATA(:,3), t,DATA(:,7),'--');
legend('v(t)', 'v_{est}(t)');
grid on;
title('v(t) vs v_{est}(t)'); xlabel('Time (s)');

subplot(2,2,4);
plot(t,DATA(:,4), t,DATA(:,8),'--');
legend('\omega(t)', '\omega_{est}(t)');
grid on;
title('\omega(t) vs \omega_{est}(t)'); xlabel('Time (s)');
