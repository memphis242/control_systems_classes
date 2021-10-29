clear all;

num = [100];
den = poly([-1 -3 -6 -9]);
% den = [1 2 3];
plant = tf(num,den);
% Klead = tf([1 1.04], [1 10.4]);   % Lead Compensation
% KI = tf([0 1], [1 0]);
% KPI = tf([1 0.1617],[1 0]);
K = zpk([-1], [0 -10], 1)
OLTF = zpk(plant * K)
% OLTF = series(plant, Klead);
% OLTF = series(plant, KI);
% OLTF = zpk(series(plant, KPI))
% OLTF = plant;
z = 0.5912;
z_ang = acosd(z)

Kmax = 100;

% G = tf(num, den)
k = 0:1e-1:Kmax;
% subplot(1,2,1);
% rlocus(G,k);
rlocus(OLTF,k);
hold on;

s = 0:-1e-3:-10;
y = -tand(z_ang)*s;
plot(s, y);

% for i = [10:20:K]
%     
% %     subplot(1,2,1);
% %     rlocus(G,k);
%     rlocus(OLTF,k);
%     hold on;
% %     char_eq = den + num*i;
% %     char_roots = roots(char_eq);
% %     Klead = tf(i*[1 1.04], [1 10.4]);
%     KI = tf(i*[0 1], [1 0]);
%     OLTF = series(plant, Klead);
%     CLTF = feedback(OLTF, 1);
%     char_roots = eig(CLTF);
%     plot(real(char_roots), imag(char_roots), 'kx', 'MarkerSize', 10);
%     str = ['K = ', num2str(i)];
%     title(str);
%     
% %     subplot(1,2,2);
% %     GH = tf(num*i, poly(char_roots));
% %     step(GH);
%     
%     pause;
%     
% end