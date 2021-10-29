% 4th Order Heat System, Observer
A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1];
B = [1;0;0;0]; C = [0 0 0 1]; D = 0;

% Let's see if we can observe using just the last state
rank([C; C*A; C*A^2; C*A^3])
% pause

% Cool. Let's find H then.
des_poles = [-1 -2 -3 -4];
H = placePoles(A',C',C, des_poles)
% pause

% Simulate and check that plant states and observer states converge
Aaug = [A, zeros(4,4); H'*C, A-H'*C]; Baug = [B;B];
Caug = eye(8); Daug = zeros(8,1);
X0 = [0;0;0;0; 5*rand(4,1)];
T_end = 15;
t = transpose(linspace(0,T_end,1001));
R = 0*t + 1;
Y = step3(Aaug, Baug, Caug, Daug, t, X0, R);
plot(t,Y(:,[1:4]), t,Y(:,[5:8]),'--');
xlabel('Time (s)'); ylabel('States'); title('Actual States vs Observed States');
grid on;

