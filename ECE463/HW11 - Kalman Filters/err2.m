function [err] = err2(X)
mball = 0.5;
Rball = X(1); mbeam = X(2); L = X(3);
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
Ad = [0 0 1 0; 0 0 0 1; 0 -7 0 0; -1.96 0 0 0]; Bd = [0;0;0;0.4];
err = abs(A(3,2) - Ad(3,2)) + abs(Ad(4,1) - A(4,1));
end

