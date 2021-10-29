% Cart and Pendulum
% EC 463 Lecture 7
% main calling routine

X = zeros(4,1);
dX = zeros(4,1);
Ref = 1;
dt = 0.01;
t = 0;

mcart = 1;
mball = 4;
L = 1;
Ts = 6; MOS = 0.10;
[Kx, Kr] = ObtainCartFeedback(mcart,mball,L,Ts,MOS);
% Kx = [-1.0714, -78.5964, -2.5230, -12.5230];
% Kr = -1.0714;

pause;
U = 0;
y = [];
dim = [0.3 0.6 0.2 0.15];
an = annotation('textbox', dim, 'String', '', 'FitBoxToText', 'on');
while(t < Ts*2)
    U = Kr*Ref - Kx*X;
    dX = CartDynamics(X, U, mcart, mball, L);
    X = X + dX * dt;
    t = t + dt;

    CartDisplay(X, Ref);
    y = [y ; X(1), X(2), Ref];

    str = sprintf('Time = %.2f s', t);
    an.String = str;
    drawnow;
end

t = linspace(0,Ts*10,length(y));
plot(t,y);
xlabel('Time (s)'); title('Nonlinear System Model: Step Response');