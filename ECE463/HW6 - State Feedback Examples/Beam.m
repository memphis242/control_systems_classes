% Ball & Beam System
% m = 1kg
% J = 0.2 kg m^2
% ECE 463 Lecture #8

X = zeros(4,1);
dX = zeros(4,1);
Ref = 1;
dt = 0.01;
t = 0;

[Kx, Kr] = ObtainBeamBallFeedback();
pause;

n = 0;
y = [];
dim = [0.3 0.6 0.2 0.15];
an = annotation('textbox', dim, 'String', '', 'FitBoxToText', 'on');
while(t < 15)
    U = Kr*Ref - Kx*X;
    dX = BeamDynamics(X, U);

    X = X + dX * dt;
    t = t + dt;

%     y = [y ; Ref, X(1)];
    y = [y ; X(1), X(2), Ref];
    n = mod(n+1,5);
    if(n == 0)
        BeamDisplay(X, Ref);
        str = sprintf('Time = %.3f s', t);
        an.String = str;
        drawnow;
    end
end
pause;


t = linspace(0,15,length(y));
plot(t,y(:,1),'r',t,y(:,2),'b');
xlabel('Time (seconds)');
ylabel('Ball Position');