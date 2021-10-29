% 20-stage RC Filter
% Lecture #16
% Servo Compensators at DC


%% System description
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

%% Simple Compensator
% des_poles = [-1, -2, -2.3473, -3.5321];
% [Kx, Kr] = placePoles(Aapprox, Bapprox, Capprox, des_poles);


%% Servo Compensator
Az = [0 2; -2 0]; Bz = [1;1];
Aaug = [Aapprox, zeros(4,2); Bz*Capprox, Az];
Baug = [Bapprox; 0; 0];
Caug = [Capprox, 0, 0];
des_poles = [-1 -2 -3 -4 -5 -6];
[Kx_aug, Kr_aug] = placePoles(Aaug,Baug,Caug, des_poles);
Kx = Kx_aug(1:4) %#ok<NOPTS>
Kz = Kx_aug(5:6) %#ok<NOPTS>

% %% Check /w approximation
% AA = [Aapprox - Bapprox*Kx, -Bapprox*Kz; Bz*Capprox, Az];
% eg1 = [eig(Aapprox); 1.2345; 1.2345];
% fprintf('[Eigenvalues of Aapprox, Eigenvalues of Servo-comp Approx System]:\n');
% [eg1, eig(AA)]
% 
% % Check linearized response
% Acl = [Aapprox - Bapprox*Kx, -Bapprox*Kz; Bz*Capprox, Az];
% Bcl = [zeros(4,1); -Bz];
% Ccl = Caug; Dcl = D;
% V0 = zeros(6,1); t = transpose(linspace(0,10,1001));
% R = sin(2*t);
% Vout = step3(Acl,Bcl,Ccl,Dcl,t,V0,R);
% plot(t,Vout,t,R,'LineWidth',2);
% legend('Vout(t)','Vin(t)');
% ylim([-2,2]); grid on; title('Step3 Response Check');
% clf
% pause

%% Simulate
V = zeros(20,1);
Z = zeros(2,1);
dt = 100e-6;
T_end = 15;
t = 0;
V0 = 0;
% Ref = sin(2*t);
N = (T_end / dt) + 1;
DATA = zeros(N,3);
VMAX = 2;

% % Change system and see if servo-comp still manages /w disturbance
% for i=1:19
%     A(i,i) = (-2/(R*Cap))*1.1;    % Extra losses
% end
% A(20,20) = (-1/(R*Cap))*1.1;
disturb = 0;

i=1;
tic
while(t < T_end)
% while(abs(V(20) - Ref) > 0.005*Ref)
   V0 = -Kz*Z - Kx*V([5,10,15,20]) + disturb;
   Ref = sin(2*t);
 
   dV = A*V + B*V0;
   dZ = Bz*(Capprox*V([5,10,15,20]) - Ref) + Az*Z;

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
plot(t,DATA, 'LineWidth',2);
grid on;
legend('V_{20}(t)','V_{in}(t)','Ref');
title('Simulated Step Response of Full Servo-Comp 20^{th} Order Heat System');
