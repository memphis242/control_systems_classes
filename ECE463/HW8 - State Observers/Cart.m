% Cart and Pendulum
mcart = 1;
mball = 4;
L = 1;

% Setting system poles to be [-1,-2,-3,-4] for Ts ~ 4sec and no OS
Kx = [-2.4490  -86.4490   -5.1020  -15.1020];
Kr = -2.4490;

% Setting observer gains
% Output disturbance


X = zeros(5,1); dX = zeros(5,1);
Xe = zeros(5,1); dXe = zeros(5,1);
Ref = 1;
dt = 100e-6; Tend = 10; t = 0;
N = (Tend/dt) + 1;
U = 0;
y = [];
dim = [0.3 0.6 0.2 0.15];
an = annotation('textbox', dim, 'String', '', 'FitBoxToText', 'on');
while(t < Ts*2)
    
    U = Kr*Ref - Kx*X;
    dX = CartDynamics(X, U, mcart, mball, L);
    X = X + dX * dt;
    t = t + dt;
    
end

t = linspace(0,Ts*10,length(y));
plot(t,y);
xlabel('Time (s)'); title('Nonlinear System Model: Step Response');