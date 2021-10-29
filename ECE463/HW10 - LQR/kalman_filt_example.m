A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1]; B = [1;0;0;0];
C = [0 0 0 1]; D = 0;
W = 0.01; V = 1;
F = [1;0;0;0];

Q = F*V^2*F'; R = W^2;
H = lqr(A',C',Q,R)';

Aaug = [A, zeros(4,4); H*C, A-H*C];
Baug = [B, F, zeros(4,1); B, zeros(4,1), H];
Caug = eye(8); Daug = zeros(8,3);

t = linspace(0,10,1001)'; N = size(t);
U = [ones(N), randn(N)*V, randn(N)*W];
X0 = zeros(8,1);

Y = step3(Aaug, Baug, Caug, Daug, t, X0, U);

plot(t,Y);
legend('X_1','X_2','X_3','X_4');

