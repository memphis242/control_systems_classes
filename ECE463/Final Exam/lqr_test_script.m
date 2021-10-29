%% Desired response
des_dom_poles = [-0.5+0.5243j, -0.5-0.5243j];
num = abs(des_dom_poles(1))^2;
den = poly(des_dom_poles);
Gd = tf(num,den);

%% Current system
mball = 0.5; Rball=1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0];
Aaug = [A, zeros(4,1); C, 0]; Baug = [B;0]; Caug = [C,0];
Cz = [0 0 0 0 1];

%% Check controllability
% OO = [Baug, Aaug*Baug, Aaug^2*Baug, Aaug^3*Baug, Aaug^4*Baug, Aaug^5*Baug];
% rankOO = rank(OO)
% return

%% Observer
Qx = Caug'*Caug;
Qz = Cz'*Cz;
a = 677.5260; b = 422.9956;
Q = a*Qx + b*Qz
R = 1;

[K,S,CLP] = lqr(Aaug,Baug,Q,R);

Kx = K(1:4)
Kz = K(5)
Acl = [A-B*Kx, -B*Kz; C, 0]; Bcl = [zeros(4,1); -1]; Ccl = Caug; Dcl = 0;


%% Test
G = ss(Acl, Bcl, Ccl, Dcl);
step(G)
hold on;
step(Gd)
legend('G','G_{desired}');
grid on;

resp_err(G,Gd,15)