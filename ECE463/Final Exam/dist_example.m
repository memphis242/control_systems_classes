%% System description

% % Heat system
% A = [-2 1 0 0; 1 -2 1 0; 0 1 -2 1; 0 0 1 -1]; B = [1;0;0;0];
% C = [0 0 0 1]; D = 0;

% % Cart & Pendulum
% mcart = 1; mball = 4; L = 1;
% [A,B] = linearizedCartPend(mcart,mball,L);
% C = [1 0 0 0]; D = 0;

% Ball & Beam
mball = 0.5; Rball = 1; mbeam = 4.8990; L = 2.4746;
[A,B] = linearizedBeamBall(mball,Rball,mbeam,L);
C = [1 0 0 0]; D = 0;


%% Augmented system accounting for disturbance state
Ad = 0; Cd = 1;

% % Input disturbance
% Aaug = [A, B*Cd; zeros(1,4), Ad]; Baug = [B;0];
% Caug = [C, 0]; Daug = 0;

% Output disturbance
Aaug = [A, B*0; C*0, Ad]; Baug = [B;0];
Caug = [C, 1]; Daug = 0;


%% Check observability
% OO = [Caug; Caug*Aaug; Caug*Aaug^2; Caug*Aaug^3; Caug*Aaug^4];
% rankOO = rank(OO)
% return

%% Now making an observer for this augmented system, assuming it is all
% observable
des_obs_poles = [-5,-6,-7,-8,-9];
H = transpose(placePoles2(Aaug', Caug', des_obs_poles))

% Check stability
eig(Aaug - H*Caug);


%% Linear simulaiton
Afull = [Aaug, zeros(5,5); H*Caug, Aaug-H*Caug]; Bfull = [Baug; Baug];
Cfull = eye(10); Dfull = zeros(10,1);
X0 = [zeros(4,1);2;zeros(5,1)];
Tend = 5; t = transpose(linspace(0,Tend,10001));
U = ones(size(t));

Y = step3(Afull, Bfull, Cfull, Dfull, t, X0, U);
plot(t,Y);
