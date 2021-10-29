% Cart and Pendulum
% EC 463 Lecture 7
% main calling routine

mcart = 1;
mball = 4;
L = 1;
Ts = 6; MOS = 0.05;
C = [1 0 0 0];

% Input disturbance noise and sensor noise
F = [0;0;1;-1];
nu_mu = 0; nu_sig = 0.02;
ny_mu = 0; ny_sig = 0.01;

Ref = 1;
dt = 100e-6; T_end = 10; t = 0;
N = (T_end / dt) + 1;


%% Without any observer
X = zeros(4,1); dX = zeros(4,1);
Z = 0; dZ = 0;
DATA1 = zeros(N,3); i=1;
Kx = [-1218, -2267.9, -666, -711.8];
Kz = -743.3707;

tic
while(t < T_end)
%     F = -Kz*Z - Kx*X;
    U = -Kz*Z - Kx*(X + F*normrnd(nu_mu,nu_sig));
    
    dX = CartDynamics(X, U, mcart, mball, L);
%     dZ = C*X - Ref;
    dZ = (C*X + normrnd(ny_mu,ny_sig)) - Ref;
    
    X = X + dX * dt;
    Z = Z + dZ * dt;
    t = t + dt;

    DATA1(i,:) = [X(1), X(2), U];
    i = i+1;
end
toc

t = [1:length(DATA1)]' * dt;
DATAds1 = downsample(DATA1,10);
tds = downsample(t,10);

plot(tds,DATAds1(:,1));


%% LQR
% X = zeros(4,1); t = 0;
% Z = 0;
% % Ref = [1;0];
% Ref = 1;
% 
% DATA2 = zeros(N,3); i=1;
% Kx = 1.0e+03 * [-1.2180   -2.2679   -0.6660   -0.7118];
% Kz = -743.3707;
% 
% tic
% while(t < T_end)
% %     F = Kr(1)*Ref(1) - K(1,:)*X;
% %     T = Kr(2)*Ref(2) - K(2,:)*X;
%     
% %     dX = CartDynamics2(X, F, T, mcart, mball, L);
% 
%     F = -Kx*X - Kz*Z;
%     
%     dX = CartDynamics(X,F,mcart,mball,L);
%     dZ = C*X - Ref;
%     
%     X = X + dX * dt;
%     Z = Z + dZ * dt;
%     t = t + dt;
% 
%     DATA2(i,:) = [X(1), X(2), F];
%     i = i+1;
% end
% toc
% 
% t = [1:length(DATA2)]' * dt;
% tds = downsample(t,100);
% DATAds2 = downsample(DATA2,100);


%% Plot
% subplot(1,2,1);
% plot(tds,DATAds1(:,1), tds,DATAds2(:,1));
% legend('x(t) /w Pole Placement', 'x(t) /w LQC');
% grid on; title('Cart & Pendulum System: Pole Placement vs LQC'); xlabel('Time (s)'); ylabel('x (m)');
% 
% subplot(1,2,2);
% plot(tds,DATAds1(:,3), tds,DATAds2(:,3));
% legend('u(t) /w Pole Placement', 'u(t) /w LQC');
% grid on; title('Cart & Pendulum System: Pole Placement vs LQC'); xlabel('Time (s)'); ylabel('u(t)');







% yyaxis left;
% plot(tds,DATAds2(:,1));
% ylim([-1,1.5]);
% yyaxis right;
% plot(tds,rad2deg(DATAds2(:,2)));
% legend('x(t)','\theta(t)');
% grid on; title('Cart & Pendulum System: Servo-comp /w LQR using F input'); xlabel('Time (s)');

