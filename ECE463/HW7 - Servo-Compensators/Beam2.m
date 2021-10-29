% Ball & Beam System
% Lecture #16
% Servo Compensators at DC

%% System
% System setup
mball = 0.5; mbeam = 3;
Rball = 10e-2; L = 2;

% Obtain matrices
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0];  % We are looking at the position of the ball
D = 0;

%% Servo-compensation
% Augmented system
Aaug = [A, 0*B; C, 0];
Baug = [B; 0];
Caug = [C, 0];
des_poles = [-1 -2 -2 -2 -2];
[Kx_aug, Kr_aug] = placePoles(Aaug,Baug,Caug, des_poles);
Kx = Kx_aug(1:4) 
Kz = Kx_aug(5) 

% Servo Compensator Gains
%Kx = [ -56.77  102.00  -38.57  18.00];
%Kz = -20.57;

% %% % Check /w approximation
% AA = [A-B*Kx, -B*Kz; C, 0]; % A matrix of servo-compensated system
% eg1 = [eig(A); 1.2345]; % eigenvalues of original system
% fprintf('[Eigenvalues of Original System, Eigenvalues of Servo-comp System]:\n');
% [eg1, eig(AA)] %#ok<*NOPTS>
% pause
% 
% % Check using step-response
% BB = [zeros(4,1);1];
% CCy = [C 0];
% CCu = [-Kx -Kz];
% ss_y = ss(AA,BB,CCy,D);
% ss_u = ss(AA,BB,CCu,D);
% 
% step(ss_y);
% hold on;
% step(ss_u);
% title('Step Response of Approx. System Servo-Comp');
% legend('y_{approx}(t)', 'u_{approx}(t)');
% grid on;
% pause
% clf

%% Simulate
% Setting ICs and simulation config
X = [0, 0, 0, 0]';  % [r q dr dq]
Z = 0;
dt = 100e-6; T_end = 15;
t = 0;
Ref = 1;
N = (T_end / dt) + 1;
DATA = zeros(N,4);

% % Change system and see if servo-comp still manages /w disturbance
mball = mball*5;
disturb = 0;

% Simulate
i=1;
tic
while(t < T_end)
    U = -Kz*Z - Kx*X + disturb;   % Here, U is torque T

    dX = BeamDynamics(X, U, mball, Rball, mbeam, L);
    dZ = X(1) - Ref;

    X = X + dX * dt;
    Z = Z + dZ * dt; 
    t = t + dt;

    DATA(i,:) = [Ref, X(1), X(2), U];
%     if(n == 0)
%         BeamDisplay(X, Ref);
%     end
    
    i = i+1;
end
toc

t = [1:length(DATA)]' * dt; %#ok<NBRAK>
DATAds = downsample(DATA,10); tds = downsample(t,10);
plot(t,DATA);
grid on;
legend('Ref','r(t)','\theta(t)','u(t)');
title('Simulated Step Response of Full Servo-Comp Ball&Beam System'); xlabel('Time (s)');
