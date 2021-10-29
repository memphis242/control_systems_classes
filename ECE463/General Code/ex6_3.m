clc;
clear all;

G = zpk([],[-0.1617,-1.04,-2.719,-5.05],1.4427);
T = 100e-3;
Gzas = c2d(G,T,'matched');

% Cz = zpk([],[],1,T);    % P
% Cz = zpk([0.8187],[1],1,T); % PI
% Cz = zpk([0.8787,0.4352],[1,0],1,T);    % PID
% Cz = 1;
Cz = zpk([0.984,0.9012],[1,0.8484],1,T);

OLTFz = Cz*Gzas;
zdes = 0.95785+0.074937j;
k = 9.8597;
L = OLTFz * k;
CLTF = feedback(L,1);
K = @(z) -1 ./ evalfr(OLTFz,z);
U = k*Cz*(1-CLTF);


% To meet Ts specs, Ts --> tau --> sigma --> exp(sigma*T)
Ts = 10;   % Desired 2% settling time
tau = Ts/4;
sigma = -1/tau;
radius = exp(sigma*T);
Om = linspace(0,2*pi,1001);
Ts_circle = radius*exp(1j*Om);

% To meet zeta spec, we need to be on the zeta contour. One way to
% find this is to draw the contour using the following:
MOS = @(z) exp(-pi * (z./sqrt(1-z.^2)));
desired_MOS = 0.20;
E = @(z) abs(MOS(z) - desired_MOS);
[zeta,err] = fminsearch(E, 0.5);
% zeta = 0.5910;
a = -zeta / sqrt(1-zeta^2);
zeta_contour = exp(a*Om).*exp(1j*Om);

% % To meet the wd=5rad/s --> Om = wd*T, and we know that corresponds to a
% % radial line at an angle of Om
% wd = 5;
% Om = wd*T;
% b = linspace(0,1,101);
% wd_contour = [b; tan(Om)*b];


% Now that we have our desired contour references, we draw the rlocus
rlocus(OLTFz);
hold on;
plot(real(Ts_circle),imag(Ts_circle), real(zeta_contour), imag(zeta_contour));
% plot(real(zeta_contour), imag(zeta_contour));
% plot(wd_contour(1,:), wd_contour(2,:));
