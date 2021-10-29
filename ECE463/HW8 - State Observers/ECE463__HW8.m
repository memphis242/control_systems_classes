%% Problem 1
mcart=1; mball=4; L=1;
[Kx, Kr] = ObtainCartFeedback(mcart,mball,L, 6,0.1);
pause

%% Problem 2
A = [0 0 1 0; 0 0 0 1; 0 -39.2 0 0; 0 49 0 0];
B = [0;0;1;-1];
C = [1 0 0 0];  % Position x(t)
obsPoles = [-3.4,-4,-5,-6];

H = transpose(placePoles(A',C',B',obsPoles)) %#ok<NOPTS>

% Aaug = [A-B*Kx, zeros(4,4); H*C-B*Kx, A-H*C];   % Using actual state
Aaug = [A, -B*Kx; H*C, A-H*C-B*Kx]; % Using observer state
Baug = Kr*[B; B];
Caug = [C, 0*C; 0*C, C];
% Caug = eye(8);
Daug = zeros(2,1);
% Daug = zeros(8,1);

T = 10;
t = transpose(linspace(0,T,1001));
X0 = [zeros(4,1); 0.1*ones(4,1)];
% X0 = [zeros(4,1); 0*ones(4,1)];
R = 0*t + 1;
y = step3(Aaug, Baug, Caug, Daug, t, X0, R);
plot(t,y);
% xlabel('Time (s)'), title('All States using actual state in control law');
% xlabel('Time (s)'), title('All States using observer state in control law');
% xlabel('Time (s)'), title('x(t) vs x_{est}(t) using actual state');
xlabel('Time (s)'), title('x(t) vs x_{est}(t) using observer state');
% legend('x(t)', 'x_{est}(t)');

