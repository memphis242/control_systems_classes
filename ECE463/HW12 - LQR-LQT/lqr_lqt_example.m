%% Reference model
% b = [0 0 10]; a = [1 2 10]; % num, den
% [Am,Bm,Cm,Dm] = tf2ss(b,a);
Am = [0 -10; 1 -2]; Bm = [10; 0]; Cm = [0 1];

%% System
A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1]; B = [1;0;0;0];
C = [0 0 0 1]; D = 0;

%% Augmented system
Aaug = [A, zeros(4,2); zeros(2,4), Am]; Baug = [B;zeros(2,1)];
Caug = [C, -Cm];

%% LQR to find Kx and Kxm
a = 1e10;
Q = a*Caug'*Caug; R = 1;
K = lqr(Aaug,Baug,Q,R);
Kx = K([1:4])
Kxm = K([5:6])

%% Linear simulation
% Acl = [A-B*Kx, -B*Kxm; zeros(2,4), Am]; Bcl = [zeros(4,1); Bm];
% Ccl = [C 0 0; zeros(1,4), Cm]; Dcl = [0;0];
% 
% Tend = 15; t = transpose(linspace(0,Tend));
% X0 = zeros(6,1);
% R = ones(size(t));
% Y = step3(Acl,Bcl,Ccl,Dcl,t,X0,R);
% plot(t,Y);
% legend('Y','Yref');

Acl = Aaug - Baug*K; Bcl = [zeros(4,1); Bm];
Ccl = [C, 0, 0; zeros(1,4), Cm]; Dcl = [0;0];

t = linspace(0,10,1001);
G = ss(Acl,Bcl,Ccl,Dcl);
Y = step(G,t);
plot(t,Y)
grid on;
legend('Y','Yref');
xlabel('Time (s)'); title('Plant vs Reference Model /w a=1e10');

