% 20-stage RC Filter
% Lecture #16
% Servo Compensators at DC


% System description
R = 0.2; Cap = 0.2;
A = zeros(20,20);
for i=1:19
    A(i,i) = -2/(R*Cap);
    A(i,i+1) = 1/(R*Cap);
    A(i+1,i) = 1/(R*Cap);
end
A(20,20) = -1/(R*Cap);
B = zeros(20,1);
B(1) = 1/(R*Cap);
C = zeros(1,20);
C(20) = 1;
D = 0;

% 4th Order Approximation
Rapprox = 5*R; Capprox = 5*Cap;
aa = 1/(Rapprox*Capprox);
Aapprox = zeros(4,4);
for i=1:3
    Aapprox(i,i) = -2*aa;
    Aapprox(i,i+1) = aa;
    Aapprox(i+1,i) = aa;
end
Aapprox(4,4) = -aa;
Bapprox = zeros(4,1);
Bapprox(1) = aa;
Capprox = zeros(1,4);
Capprox(4) = 1;
Dapprox = D;

% Simple Compensator
des_poles = [-1, -2, -3, -4];
[Kx, Kr] = placePoles(Aapprox, Bapprox, Capprox, des_poles) %#ok<NOPTS>

% % Servo Compensator
% Z = 0;
% Kx = [2 7 13 25];
% Kz = 16;

% Simulate
V = zeros(20,1);
dt = 0.01;
t = 0;
V0 = 0;
Ref = 1;
n=0;
DATA = [];
T_end = 8;
VMAX = 2;

tic
while(t < T_end)
%    Ref = 1 + 0.25*sign(sin(0.314*t));
   V0 = Kr*Ref - Kx*V([5,10,15,20]);
%    V0 = min(V0, VMAX);
%    V0 = -Kz*Z - Kx*V([5,10,15,20]);
 
   dV = A*V + B*V0;
%    dZ = V(20) - Ref;
   
   V = V + dV * dt;
%    Z = Z + dZ * dt;
   
   t = t + dt;
   
%    plot([0:20], [V0;V], 'b.-', t, 0, 'b+',20,Ref,'b+');
%    ylim([0,2]);
%    xlim([0,20]);
%    pause(0.01);
   DATA = [DATA ; V(20), V0, Ref];

%    n = mod(n+1, 5);
%    if(n == 0)
%       plot([0:20], [V0;V], 'b.-', t, 0, 'b+',20,Ref,'b+');
%       ylim([0,2]);
%       xlim([0,20]);
%       pause(0.01);
%       DATA = [DATA ; V(20), V0, Ref];
%    end
end
toc

t = [1:length(DATA)]' * dt;
plot(t,DATA);
grid on;
legend('V_{20}(t)','V_{in}(t)','Ref');
ylim([0, VMAX*1.3]);