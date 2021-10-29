%% Reference model
% b = [0 0 10]; a = [1 2 10]; % num, den
% [Am,Bm,Cm,Dm] = tf2ss(b,a);
Am = [0 -10; 1 -2]; Bm = [10; 0]; Cm = [0 1];

%% System
A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1]; B = [1;0;0;0];
C = [0 0 0 1]; D = 0;

%% Augmented system /w servo-compensation
Aaug = [A, zeros(4,3); C, 0, -Cm; zeros(2,5), Am]; Baug = [B;zeros(3,1)];
Caug = [zeros(1,4), 1, zeros(1,2)];
% return

%% LQR to find Kx and Kxm
a = 1e12;
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

t = linspace(0,10,1001);
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

