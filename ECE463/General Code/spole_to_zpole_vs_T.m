T1=1; T2=T1/10; T3=T2/10;
T1str = num2str(T1); T2str = num2str(T2); T3str = num2str(T3);

G = zpk([],10*[-1+2j,-1-2j,-3,-7+10j,-7-10j],1);
Gzas1 = c2d(G,T1,'zoh');
Gzas2 = c2d(G,T2,'zoh');
Gzas3 = c2d(G,T3,'zoh');

plant_roots = eig(G);
roots1 = eig(Gzas1);
roots2 = eig(Gzas2);
roots3 = eig(Gzas3);

Om = linspace(0,2*pi,1001);
unit_circle = exp(1j*Om);

subplot(2,3,2);
plot(real(plant_roots),imag(plant_roots),'kx','MarkerSize',10); title('Analog Plant Roots');
xlim([-1.5*max(abs(plant_roots)), 1]); xline(0); yline(0);
subplot(2,3,4); plot(real(roots1),imag(roots1),'kx','MarkerSize',10); title(['Gzas T = ',T1str,'s']);
hold on; plot(real(unit_circle),imag(unit_circle),'LineWidth',2);
subplot(2,3,5); plot(real(roots2),imag(roots2),'kx','MarkerSize',10); title(['Gzas T = ',T2str,'s']);
hold on; plot(real(unit_circle),imag(unit_circle),'LineWidth',2);
subplot(2,3,6); plot(real(roots3),imag(roots3),'kx','MarkerSize',10); title(['Gzas T = ',T3str,'s']);
hold on; plot(real(unit_circle),imag(unit_circle),'LineWidth',2);

