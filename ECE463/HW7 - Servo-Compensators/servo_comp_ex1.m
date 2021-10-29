% Step 1: Input system
A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1];   % This was the approximated 20th order heat system /w R=0.2, C=0.2
B = [1;0;0;0];
C = [0 0 0 1];

% Step 2: Create augmented system
Aaug = [A, B*0; C, 0];
Baug = [B; 0];

% Step 3: Use Bass-Gura to place poles
des_poles = [-1 -2 -2 -2 -2];
[Kx_aug, Kr_aug] = placePoles(Aaug,Baug,[C 0], des_poles);

% Step 4: Obtain Kx and Kz
Kx = Kx_aug(1:4)
Kz = Kx_aug(5)

% Step 5: Plot the step-response
Asc = [A-B*Kx, -B*Kz; C 0];
Bsc = [0;0;0;0;-1];
Csc = [C 0; -Kx -Kz];
Dsc = [0;0];
GscY = ss(Asc, Bsc, Csc(1,:), Dsc(1));
GscU = ss(Asc, Bsc, Csc(2,:), Dsc(2));
step(GscY);
hold on;
step(GscU);
legend('y(t)', 'u(t)');

