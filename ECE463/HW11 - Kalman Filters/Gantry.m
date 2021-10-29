% Gantry System ( Sp21 version)
% m1 = 1.0kg
% m2 = 4.0kg
% L = 1.0m

% Test #2
% Pant + Observer + disturbance + tracking a sine wave

X = [-1;0;0;0];

dt = 0.01;
U = 0;
t = 0;

% Full State Feedback
Kx = [2.4490   16.4490    5.1020   -4.8980];
Kr = 2.4490;

% Full-Order Observer
A = [0,0,1,0;0,0,0,1;0,39.2,0,0;0,-49,0,0];
B = [0;0;1;-1];
C = [1,0,0,0];
H = ppl(A', C', [-3, -3.2, -3.4, -3.6])';
Xe = X;

y = [];

while(t < 11.9)
    Ref = sin(1.5*t);
    d = 10;

   if(t < 2)
        U = Kr*Ref - Kx*X(1:4);
   else
        U = Kr*Ref - Kx*Xe(1:4);
   end

   dX = GantryDynamics(X, U + d);
   dXe = A*Xe + B*U + H*(X(1) - Xe(1));

   X = X + dX * dt;
   Xe = Xe + dXe*dt;

   t = t + dt;
 
   GantryDisplay(X, Xe, Ref);
   plot([Ref, Ref],[-0.1,0.1],'b');
 
   y = [y ; X(1), Xe(1), Ref ];
 
   end

hold off
t = [1:length(y)]' * dt;
plot(t,y(:,1),'b',t,y(:,2),'g', t, y(:,3), 'r');