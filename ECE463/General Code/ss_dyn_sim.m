% Animating system dynamcis. Code from Glower's notes ECE461 Electric
% Circuits & The Heat Equation

A = zeros(10,10);
for i=1:9
    A(i,i) = -21/2;
    A(i+1,i) = 5;
    A(i,i+1) = 5;
end
A(10,10) = -10/2;
B = zeros(10,1);
B(1) = 5;
C = zeros(1,10);
C(10) = 1;
D = 0;

G = ss(A,B,C,D);
zpk(G)
DC_gain = evalfr(G,0)

% Let X represent the state vector
[eig_vec, eig_val] = eig(A);
% X = 10*eig_vec(:,10); titStr = 'Slow Decay Initial Conditions'; pTime = 5e-3;    % Slowest decay
% X = 10*eig_vec(:,1); titStr = 'Fast Decay Initial Conditions'; pTime = 750e-3;    % Fastest decay
X = 10*rand(10,1); titStr = 'Random Initial Conditions'; pTime = 100e-3;     % Random ICs
% X = zeros(10,1);
dX = zeros(10,1);
U = 0;  % Step input
dt = 5e-3;
t = 0;
M = 1.2*max(abs(X));

dim = [.2 .5 .3 .3];
while (t<100)
    clf;
    
    dX = A*X + B*U;
    X = X + dX*dt;
    t = t + dt;
    
    str = ['t = ',num2str(t),' sec'];
    plot([0:10], [U;X], '.-');
    grid on; title(titStr);
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
    xticks(0:10); xticklabels({'U','V1','V2','V3','V4','V5','V6','V7','V8','V9','V10'});
    xlim([0 11]), ylim([-M M]);
    pause(pTime);
    
end
    