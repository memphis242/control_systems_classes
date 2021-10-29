X = zeros(4,1); dX = zeros(4,1);
Ref = 1;
dt = 100e-6; T_end = 20; t = 0;
N = (T_end / dt) + 1;

% Pole placement
DATA1 = zeros(N,3); i=1;
Kx = [-10.3513, 56.5133, -8.8943, 20.8333];
Kr = -5.4514;

tic
while(t < T_end)
    U = Kr*Ref - Kx*X;
    dX = BeamDynamics_glower(X, U);
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
Kx = [-12.2491, 36.4808, -9.3060, 13.5057];
Kr = -7.3491;

tic
while(t < T_end)
    U = Kr*Ref - Kx*X;
    dX = BeamDynamics_glower(X, U);
    X = X + dX * dt;
    t = t + dt;

    DATA2(i,:) = [X(1), X(2), U];
    i = i+1;
end
toc

t = [1:length(DATA2)]' * dt;
DATAds2 = downsample(DATA2,10);

plot(tds,DATAds1(:,1), tds,DATAds2(:,1));
legend('x(t) /w Pole Placement', 'x(t) /w LQC');
grid on; title('Ball & Beam System: Pole Placement vs LQC'); xlabel('Time (s)'); ylabel('x (m)');


