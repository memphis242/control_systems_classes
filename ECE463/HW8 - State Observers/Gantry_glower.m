% Lecture #19
% Gantry plus full-order observer

rng(1168874);

X = [-1;0;0;0];
dX = zeros(4,1);
Ref = 0;
U = 0;

%Observer
Ae = [0,0,1,0;0,0,0,1;0,4.9,0,0;0,-14.7,0,0];
Be = [0;0;0.5;-0.5];
Ce = [1,0,0,0];
Xe = X + 0.2*rand(4,1);
H =  [10, -19.7959, 20.3, -56]';

dt = 100e-6; T_end = 20; t = 0;
N = (T_end / dt) + 1;
DATA = zeros(N,9); i=1;

tic
while(t < T_end)
    U = 2*cos(t);

    dX = GantryDynamics_glower(X, U);
    dXe = Ae*Xe + Be*U + H*(X(1) - Xe(1));

    X = X + dX * dt;
    Xe = Xe + dXe * dt;

    t = t + dt;

    %  GantryDisplay3(X, Xe, Ref);
    %  plot([Ref, Ref],[-0.1,0.1],'b');

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
