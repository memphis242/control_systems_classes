% 20-stage RC Filter
% Lecture #16
% Servo Compensators at DC


% System description
R = 0.2; Cap = 0.2;
A = zeros(20,20);
for i=1:19
    A(i,i) = -2/(R*Cap);
    A(i,i+1) = 1/(R*Cap);
    A(i+1,i) = 1/(R*Cap);
end
A(20,20) = -1/(R*Cap);
B = zeros(20,1);
B(1) = 1/(R*Cap);
C = zeros(1,20);
C(20) = 1;
D = 0;

% 4th Order Approximation
Rapprox = 5*R; Capprox = 5*Cap;
aa = 1/(Rapprox*Capprox);
Aapprox = zeros(4,4);
for i=1:3
    Aapprox(i,i) = -2*aa;
    Aapprox(i,i+1) = aa;
    Aapprox(i+1,i) = aa;
end
Aapprox(4,4) = -aa;
Bapprox = zeros(4,1);
Bapprox(1) = aa;
Capprox = zeros(1,4);
Capprox(4) = 1;
Dapprox = D;

% Simple Compensator
% des_poles = [-1, -2, -2.3473, -3.5321];
% [Kx, Kr] = placePoles(Aapprox, Bapprox, Capprox, des_poles);

% Servo Compensator
Aaug = [Aapprox, Bapprox*0; Capprox, 0];
Baug = [Bapprox; 0];
Caug = [Capprox, 0];
des_poles = [-1 -2 -2 -2 -2];
[Kx_aug, Kr_aug] = placePoles(Aaug,Baug,Caug, des_poles);
Kx = Kx_aug(1:4) %#ok<NOPTS>
Kz = Kx_aug(5) %#ok<NOPTS>

% % Check /w approximation
AA = [Aapprox - Bapprox*Kx, -Bapprox*Kz; Capprox, 0];
% eg1 = [eig(Aapprox); 1.2345];
% fprintf('[Eigenvalues of Aapprox, Eigenvalues of Servo-comp Approx System]:\n');
% [eg1, eig(AA)]
% pause
% 
% % Check /w full system
Kx_full = zeros(1,20); Kx_full([5,10,15,20]) = Kx;
AAA = [A-B*Kx_full, -B*Kz; C, 0];
% eg2 = [eig(A); 1.2345];
% fprintf('[Eigenvalues of Original System, Eigenvalues of Servo-comp System]:\n');
% [eg2, eig(AAA)]
% pause

% Check using step-response
BB = [zeros(4,1);1];
BBB = [zeros(20,1);1];
CCy = [Capprox 0];
CCu = [-Kx -Kz];
CCCy = [C 0];
CCCu = [-Kx_full -Kz];
ss_approx_y = ss(AA,BB,CCy,D);
ss_approx_u = ss(AA,BB,CCu,D);
ss_orig_y = ss(AAA,BBB,CCCy,D);
ss_orig_u = ss(AAA,BBB,CCCu,D);
% subplot(1,2,1);
% step(ss_approx_y);
% hold on;
% step(ss_approx_u);
% title('Step Response of Approx. System Servo-Comp');
% legend('y_{approx}(t)', 'u_{approx}(t)');
% grid on;
% subplot(1,2,2);
% step(ss_orig_y);
% hold on;
% step(ss_orig_u);
% title('Step Response of Original System Servo-Comp');
% legend('y(t)', 'u(t)');
% grid on;
% pause
% hold off;
% clf;

% Simulate
V = zeros(20,1);
Z = 0;
dt = 100e-6;
T_end = 1500;
t = 0;
V0 = 0;
Ref = 1;
N = (T_end / dt) + 1;
DATA = zeros(N,3);
VMAX = 2;

% Change system and see if servo-comp still manages /w disturbance
for i=1:19
    A(i,i) = (-2/(R*Cap))*1.1;    % Extra losses
end
A(20,20) = (-1/(R*Cap))*1.1;

i=1;
tic
while(t < T_end)
% while(abs(V(20) - Ref) > 0.005*Ref)
   V0 = -Kz*Z - Kx*V([5,10,15,20]);
 
   dV = A*V + B*V0;
   dZ = V(20) - Ref;
   
   V = V + dV * dt;
   Z = Z + dZ * dt;
   
   t = t + dt;
   
   DATA(i,:) = [V(20), V0, Ref];
   i = i+1;
   
%    plot([0:20], [V0;V], 'b.-', t, 0, 'b+',20,Ref,'b+');
%    ylim([0,3*VMAX]);
%    xlim([0,20]);
%    grid on;
%    pause(100e-6);
%    DATA = [DATA ; V(20), V0, Ref];

end
toc

t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,10);
tds = downsample(t,10);
plot(t,DATA);
grid on;
legend('V_{20}(t)','V_{in}(t)','Ref');
title('Simulated Step Response of Full Servo-Comp System');

% subplot(1,2,1);
% plot(t,DATA);
% grid on;
% legend('V_{20}(t)','V_{in}(t)','Ref');
% title('Simulated Step Response of Full Servo-Comp System');
% subplot(1,2,2);
% step(ss_orig_y);
% hold on;
% step(ss_orig_u);
% grid on;
% title('Step Response of Original System Servo-Comp');
% legend('y(t)', 'u(t)');
% % ylim([0, VMAX*1.3]);