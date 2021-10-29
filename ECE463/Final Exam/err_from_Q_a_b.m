function [err] = err_from_Q_a_b(X)
a = X(1); b = X(2);

if a<0 || b<0
    err = 1e3;
    return
end

% mc = 1; ml = 4; L = 1;
% [A,B] = linearizedCartPend(mc,ml,L);
mball = 0.5; Rball=1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0];
Aaug = [A, zeros(4,1); C, 0]; Baug = [B;0]; Caug = [C,0];
Cz = [0 0 0 0 1];
Qx = Caug'*Caug;
Qz = Cz'*Cz;

Q = a*Qx + b*Qz;
R = 1;

[K,S,CLP] = lqr(Aaug,Baug,Q,R);

Kx = K(1:4); Kz = K(5);
Acl = [A-B*Kx, -B*Kz; C, 0]; Bcl = [zeros(4,1); -1]; Ccl = Caug; Dcl = 0;
G = ss(Acl, Bcl, Ccl, Dcl);

des_dom_poles = [-0.5+0.5243j, -0.5-0.5243j];
num = abs(des_dom_poles(1))^2;
den = poly(des_dom_poles);
Gd = tf(num,den);

Tend = 15;
err = resp_err(G,Gd,Tend);

end

