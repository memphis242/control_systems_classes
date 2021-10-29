% Ball & Beam System
% Lecture #16
% Servo Compensators at DC

X = [0, 0, 0, 0]';
Z = 0;
dt = 0.01;
t = 0;
% Full-State Feedback Gains
Kx = [-13.9152   42.0017   -8.5718   12.0005];
Kr = -4.1145;

% Servo Compensator Gains
%Kx = [ -56.77  102.00  -38.57  18.00];
%Kz = -20.57;
n = 0;
y = [];

while(t < 9.9)
   Ref = 1;
%  U = -Kz*Z - Kx*X;
   U = Kr*Ref - Kx*X;
 
   dX = BeamDynamics(X, U);
   dZ = X(1) - Ref;
 
   X = X + dX * dt;
   Z = Z + dZ * dt; 
   t = t + dt;
 
   y = [y ; Ref, X(1)];
   n = mod(n+1,5);
   if(n == 0)
      BeamDisplay(X, Ref);
      end
   end
 
t = [1:length(y)]' * dt;


plot(t,y(:,1),'r',t,y(:,2),'b');
xlabel('Time (seconds)');
ylabel('Ball Position');