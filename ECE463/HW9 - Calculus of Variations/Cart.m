% Cart and Pendulum
% EC 463 Lecture 7
% main calling routine

mcart = 1;
mball = 4;
L = 1;
Ts = 6; MOS = 0.10;
% [Kx, Kr] = ObtainCartFeedback(mcart,mball,L,Ts,MOS);

X = zeros(4,1); dX = zeros(4,1);
Ref = 1;
dt = 100e-6; T_end = 20; t = 0;
N = (T_end / dt) + 1;

% Pole placement
DATA1 = zeros(N,3); i=1;
Kx = [-1.5575, -73.1629, -2.5412, -10.8746];
Kr = -1.5575;

tic
while(t < T_end)
    U = Kr*Ref - Kx*X;
    dX = CartDynamics(X, U, mcart, mball, L);
    X = X + dX * dt;
    t = t + dt;

    DATA1(i,:) = [X(1), X(2), U];
    i = i+1;
end
toc

t = [1:length(DATA1)]' * dt;
DATAds1 = downsample(DATA1,10);
tds = downsample(t,10);


% LQC
X = zeros(4,1); t = 0;

DATA2 = zeros(N,3); i=1;
% Kx = [-4.1231, -121.9602, -7.8989, -23.2831];
% Kr = -4.1231;
Kx = [-3.3559, -123.7071, -7.9011, -24.1254];
Kr = -3.3559;

tic
while(t < T_end)
    U = Kr*Ref - Kx*X;
    dX = CartDynamics(X, U, mcart, mball, L);
    X = X + dX * dt;
    t = t + dt;

    DATA2(i,:) = [X(1), X(2), U];
    i = i+1;
end
toc

t = [1:length(DATA2)]' * dt;
DATAds2 = downsample(DATA2,10);

subplot(1,2,1);
plot(tds,DATAds1(:,1), tds,DATAds2(:,1));
legend('x(t) /w Pole Placement', 'x(t) /w LQC');
grid on; title('Cart & Pendulum System: Pole Placement vs LQC'); xlabel('Time (s)'); ylabel('x (m)');

subplot(1,2,2);
plot(tds,DATAds1(:,3), tds,DATAds2(:,3));
legend('u(t) /w Pole Placement', 'u(t) /w LQC');
grid on; title('Cart & Pendulum System: Pole Placement vs LQC'); xlabel('Time (s)'); ylabel('u(t)');

