% %% Problem 6
% mc = 1; mb = 4; L = 1;
% % Linearized System model
% [A,B] = linearizedCartPend(mc,mb,L);
% C = [1, 0, 0, 0]; D = 0;
% 
% % Pole-placement
% des_poles = [-2/3 + 0.9097j, -2/3 - 0.9097j, -3, -4];
% [Kx1,Kr1] = placePoles(A,B,C,des_poles);
% % Check
% poles1 = eig(A-B*Kx1);
% 
% % LQC
% R = 1;
% a = 17; b = 1;
% Q = a*(C'*C) + b*A'*(C'*C)*A;
% Kx2 = lqr(A,B,Q,R)
% Kr2 = -1 / (C*inv(A-B*Kx2)*B)
% poles2 = eig(A-B*Kx2)
% th2 = 180 - rad2deg(angle(poles2(3)))



%% Problem 7
% Linearized System model
A = [0 0 1 0; 0 0 0 1; 0 -7 0 0; -1.96 0 0 0];
B = [0;0;0;0.4];
C = [1, 0, 0, 0]; D = 0;

% Pole-placement
des_poles = [-2/3 + 0.9097j, -2/3 - 0.9097j, -3, -4];
[Kx1,Kr1] = placePoles(A,B,C,des_poles);
% Check
poles1 = eig(A-B*Kx1);
% return

% LQC
MOS = @(z) exp(-pi * (z./sqrt(1-z.^2)));
R = 1;
a = 30; b = 10;
Q = a*(C'*C) + b*A'*(C'*C)*A;
Kx2 = lqr(A,B,Q,R)
Kr2 = -1 / (C*inv(A-B*Kx2)*B)
poles2 = eig(A-B*Kx2)
% th2 = 180 - rad2deg(angle(poles2(1)))
% zeta = cosd(th2)
% OS = MOS(zeta)

