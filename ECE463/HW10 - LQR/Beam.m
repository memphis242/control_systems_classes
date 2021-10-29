mball = 0.5; Rball = 1; mbeam = 4.8990; L = 2.4746;
C = [1 0 0 0];

X = zeros(4,1); dX = zeros(4,1);
Z = 0;
Ref = 1;
dt = 100e-6; T_end = 10; t = 0;
N = (T_end / dt) + 1;
DATA = zeros(N,3); i=1;

Kx = [-138.7254, 149.9580, -71.3257, 27.3822];
Kz = -82.6238;

tic
while(t < T_end)
    T = -Kz*Z - Kx*X;
    
    dX = BeamDynamics(X,T, mball,Rball,mbeam,L);
    dZ = C*X - Ref;
    
    X = X + dX * dt;
    Z = Z + dZ * dt;
    t = t + dt;

    DATA(i,:) = [X(1), X(2), T];
    i = i+1;
end
toc

t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,100);
tds = downsample(t,100);

yyaxis left;
plot(tds,DATAds(:,1));
ylabel('x (m)');
ylim([-0.2 1.2]);
yyaxis right;
plot(tds,rad2deg(DATAds(:,2)));
ylabel('\theta (deg)');
legend('x(t)','\theta(t)');
grid on; title('Ball & Beam System'); xlabel('Time (s)');


