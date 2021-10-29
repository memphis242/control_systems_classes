A = [0 0 1 0; 0 0 0 1; 0 -39.2 0 0; 0 49 0 0]; B = [0;0;1;-1];
C = [1 0 0 0];

[X,fval] = fminsearch(@(X) lqr_res_err(X),[1,1])
a = X(1); b = X(2);

% Q = a*C'*C + b*(C*A)'*(C*A); R = 1;
% Q = a*C'*C + b*(C*A)'*(C*A); R = b;
Q = a*eye(4), R = b

[K,S,CLP] = lqr(A,B,Q,R)