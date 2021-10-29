rng(1168874);

% Gantry System ( Sp21 version)
mgc = 10.0;
ml = 5.0;
L = 3.0;

%% System model
[A,B] = linearizedGantry(mgc,ml,L);
C = [1,0,0,0];
% return

%% I checked observability through x and system is observable
% NN = rank([C; C*A; C*A^2; C*A^3])
% return

%% Now compute H using Bass-Gura
des_poles_H = [-3 -4 -5 -6];
H = transpose(placePoles(A', C', C, des_poles_H));
% return

%% Now compensate
% Kr compensation
% des_poles = [-1 -2 -3 -4];
% [Kx,Kr] = placePoles(A,B,C,des_poles);
% % return

% Servo-compensation
Aaug = [A, B*0; C, 0];
Baug = [B; 0];
Caug = [C, 0];
des_poles = [-1 -2 -3 -4 -5];
[Kx_aug, Kr_aug] = placePoles(Aaug,Baug,Caug, des_poles);
Kx = Kx_aug(1:4); %#ok<NOPTS>
Kz = Kx_aug(5); %#ok<NOPTS>
% return

%% Now check using step3
% Kr compensation
% Acl = [A, -B*Kx; H*C, A-H*C-B*Kx]; Bcl = [B;B]*Kr;
% Ccl = [C,C*0; 0*C,C]; Dcl = [0;0];
% 
% X0 = [zeros(4,1);5*rand(4,1)];
% T_end = 20; t = transpose(linspace(0,T_end,1001));
% R = 0*t + 1;    % We'll just see step response
% Y = step3(Acl, Bcl, Ccl, Dcl, t, X0, R);
% % plot(t,Y(:,[1:4]), t,Y(:,[5:8]),'--');
% plot(t,Y(:,1), t,Y(:,2),'--');
% grid on; xlabel('Time (s)'), ylabel('States'), title('Gantry System: Actual States vs State Estimates');
% legend('x(t)','x_{est}(t)');
% return

% % Servo-compensation
% Acl = [A, -B*Kx, -B*Kz; H*C, A-H*C-B*Kx, -B*Kz; C, zeros(1,4), 0];
% Bcl = [zeros(8,1); -1]; Ccl = [C, C*0, 0; C*0, C, 0]; Dcl = [0;0];
% 
% X0 = [zeros(4,1); 5*rand(4,1); 0];
% T_end = 20; t = transpose(linspace(0,T_end,1001));
% R = 0*t + 1;    % We'll just see step response
% Y = step3(Acl, Bcl, Ccl, Dcl, t, X0, R);
% plot(t,Y(:,1), t,Y(:,2),'--');
% grid on; xlabel('Time (s)'), ylabel('States'), title('Gantry System: Actual States vs State Estimates');
% legend('x(t)','x_{est}(t)');
% return

%% Nonlinear Simulation
clf
X = zeros(4,1); Xe = 5*rand(4,1); Z = 0;
dX = zeros(4,1); dXe = zeros(4,1);
dt = 100e-6; T_end = 15; t = 0;
Ref = 1;
N = (T_end / dt) + 1;
DATA = zeros(N,2); i=1;

tic
while(t < T_end)
%     U = 2*cos(t);
%     U = Kr*Ref - Kx*Xe;
    U = -Kx*X - Kz*Z;

    dX = GantryDynamics(X,U, mgc,ml,L);
    dXe = A*Xe + B*U + H*C*(X - Xe);
    dZ = C*Xe - Ref;

    X = X + dX * dt;
    Xe = Xe + dXe * dt;
    Z = Z + dZ*dt;
    t = t + dt;
    
    DATA(i,:) = [C*X, C*Xe];
    i = i+1; 
end
toc

t = [1:length(DATA)]' * dt;
DATAds = downsample(DATA,10);
tds = downsample(t,10);

plot(t,DATA(:,1),t,DATA(:,2),'--');
grid on;
xlabel('Time (s)'), title('Nonlinear Simulation: x(t) vs x_{est}(t)');
legend('x(t)', 'x_{est}(t)');

% subplot(2,2,1);
% plot(t,DATA(:,1), t,DATA(:,5),'--');
% legend('x(t)', 'x_{est}(t)');
% grid on;
% title('x(t) vs x_{est}(t)'); xlabel('Time (s)');
% 
% subplot(2,2,2);
% plot(t,DATA(:,2), t,DATA(:,6),'--');
% legend('\theta(t)', '\thetax_{est}(t)');
% grid on;
% title('\theta(t) vs \theta_{est}(t)'); xlabel('Time (s)');
% 
% subplot(2,2,3);
% plot(t,DATA(:,3), t,DATA(:,7),'--');
% legend('v(t)', 'v_{est}(t)');
% grid on;
% title('v(t) vs v_{est}(t)'); xlabel('Time (s)');
% 
% subplot(2,2,4);
% plot(t,DATA(:,4), t,DATA(:,8),'--');
% legend('\omega(t)', '\omega_{est}(t)');
% grid on;
% title('\omega(t) vs \omega_{est}(t)'); xlabel('Time (s)');
