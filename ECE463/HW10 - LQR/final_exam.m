mball = 0.5; Rball=1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
Cr = [1 0 0 0]; Cq = [0 1 0 0];

A5 = [A, zeros(4,1); C*0, 0]
B5 = [B;0]
C5 = [Cr, 0; Cq, 1]

V = 0.02; W = [0.01, 0.03];
F = B5;
Q = F*V^2*F' + 1e-5*eye(5)
R = W*W'

H = lqr(A5',C5',Q,R)'