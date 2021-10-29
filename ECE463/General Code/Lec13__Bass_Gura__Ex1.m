% Step 1: Input system
A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1];
B = [1;0;0;0];
C = [0 0 0 1];

% Step 2: Find similarity transform to make system controller canonical
T1 = [A^0*B, A^1*B, A^2*B, A^3*B];
P = poly(eig(A));
T2 = [P(1:4); 0,P(1:3); 0,0,P(1:2); 0,0,0,P(1)];
T3 = [0 0 0 1; 0 0 1 0; 0 1 0 0; 1 0 0 0];
T = T1*T2*T3;

% Step 3: Obtain Az and Bz
% Az = inv(T)*A*T;
Az = T\A*T;
% Bz = inv(T)*B;
Bz = T\B;

% Step 4: Find feedback gains for new system Kz
Pd = poly([-1,-2,-3,-4]);
P = poly(eig(Az));
dP = Pd - P;
Kz = dP([5,4,3,2]);

% Step 5: Check that new system has poles were you want 'em
eig(Az - Bz*Kz);

% Step 6: Get back to X
% Kx = Kz*inv(T)
Kx = Kz/T

% Step 7: Check again
eig(A - B*Kx);

% Step 8: Obtain Kr for DC gain of 1
Kr = -1 / (C*inv(A-B*Kx)*B)
