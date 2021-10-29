clf

% Plant
zeta = 0.5;
Ts = 0.5; Tmax = 10*Ts;
wn = 4/(zeta*Ts); fn = wn/(2*pi);
G = tf([0.5*wn^2], [1, 2*zeta*wn, wn^2]);
% step(G,Tmax);

% PID Controller
Kp = 1000000; Ki = 0; Kd = 0;

if Kp==0 && Ki==0 && Kd==0
    F = G;
else
    Cp = Kp;
    Ci = tf([Ki],[1,0]);
    Cd = tf([Kd,0],[1]);
    C = Cp + Ci + Cd;
    F = feedback(C*G,1);
end

% Plotted System Response
ym = 1.2;
% Open Loop Response
subplot(3,1,1);
[Yol,tol] = step(G,Tmax);
plot(tol,Yol,'LineWidth',2);
grid on; title('Open-Loop Response of System');
ylim([0,ym]);
yline(1,'--');

% PID Feedback Loop Response
subplot(3,1,2);
% step(F,Tmax,'Color','#D95319');
[Y,t] = step(F,Tmax);
plot(t,Y,'Color','#D95319','LineWidth',2);
plot_2_title = ['PID Feedback Response: P = ',num2str(Kp),', I = ',num2str(Ki),', D = ',num2str(Kd)];
grid on; title(plot_2_title);
ylim([0,ym]);
yline(1,'--');

% Control Signal
subplot(3,1,3);
U = C / (1+C*G);
[Yu,tu] = step(U,Tmax);
plot(t,Yu,'Color','#7E2F8E','LineWidth',2);
grid on; title('Control Signal /w System Response Overlayed');
% hold on;
% plot(t,Y,'--','Color','#7E2F8E','LineWidth',2);
% legend('Control Signal','System Response');
% ylim([0,ym]);
% yline(1,'--');
% 
