%% Reference model
Am = [0 1; -0.5 -1]; Bm = [0; 1]; Cm = [0.5 0];

%% System
mball = 0.5; Rball = 1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0]; D = 0;

%% Augmented system /w servo-compensation
Aaug = [A, zeros(4,3); C, 0, -Cm; zeros(2,5), Am]; Baug = [B;zeros(3,1)];
Caug = [zeros(1,4), 1, zeros(1,2)];
% return

%% LQR to find Kx and Kxm
a = 1e4;
Q = a*Caug'*Caug; R = 1;
K = lqr(Aaug,Baug,Q,R);
Kx = K([1:4])
Kz = K(5)
Kxm = K([6:7])

% % Check eigen-values of plant vs reference model
eig(Aaug - Baug*K)
% return

%% Linear simulation
Acl = Aaug - Baug*K; Bcl = [zeros(4,1); 0; Bm];
Ccl = [C,0,0,0; zeros(1,4),0,Cm]; Dcl = [0;0];

Tend = 20;
t = linspace(0,Tend,10001);
G = ss(Acl,Bcl,Ccl,Dcl);
Gu = ss(Acl,Bcl,K,0);
Y = step(G,t);
U = step(Gu,t);

subplot(1,2,1);
plot(t,Y);
grid on;
legend('Y','Yref');
title_txt = ['Plant vs Reference Model /w a = ',num2str(a)];
xlabel('Time (s)'); title(title_txt);

subplot(1,2,2);
plot(t,U);
grid on;
title_txt = ['Control Signal /w a = ',num2str(a)];
xlabel('Time (s)'); title(title_txt);

