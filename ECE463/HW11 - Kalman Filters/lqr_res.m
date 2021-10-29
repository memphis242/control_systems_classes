function [dom_clp] = lqr_res(a,b)
A = [0 0 1 0; 0 0 0 1; 0 -39.2 0 0; 0 49 0 0];
B = [0;0;1;-1];
C = [1 0 0 0];

% R = 1; Q = a*C'*C + b*(C*A)'*C*A;
% R = b; Q = a*C'*C + b*(C*A)'*C*A;
Q = eye(4)*a; R = b;

[K,S,CLP] = lqr(A,B,Q,R);
dom_clp = CLP(1);
end

