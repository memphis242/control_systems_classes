% 2% Settling Time Ts vs Bandwidth of System (-3dB Freq)
alpha = -5;
tau = -1/alpha; Ts = -(1/alpha)*4;
ip = [0, (-alpha/5)*1j, -alpha*1j, -alpha*2j, -alpha*10j];
lb1 = num2str(alpha);
lb2 = [num2str(alpha),'+-',num2str(imag(ip(2))),'j'];
lb3 = [num2str(alpha),'+-',num2str(imag(ip(3))),'j'];
lb4 = [num2str(alpha),'+-',num2str(imag(ip(4))),'j'];
lb5 = [num2str(alpha),'+-',num2str(imag(ip(5))),'j'];

G1 = zpk([],alpha+ip(1),abs(alpha));
G2 = zpk([],[alpha+ip(2),alpha-ip(2)],norm(alpha+ip(2))^2);
G3 = zpk([],[alpha+ip(3),alpha-ip(3)],norm(alpha+ip(3))^2);
G4 = zpk([],[alpha+ip(4),alpha-ip(4)],norm(alpha+ip(4))^2);
G5 = zpk([],[alpha+ip(5),alpha-ip(5)],norm(alpha+ip(5))^2);

subplot(2,1,1);
step(G1);
hold on;
step(G2);
step(G3);
step(G4);
step(G5);
legend(lb1,lb2,lb3,lb4,lb5);
title('Step Response Comparison');
grid on;
hold off;

subplot(2,1,2);
f = logspace(-1,2,1001);
mag1dB = mag2db(evalAtF(G1,f)); f3db1 = find_3db_freq(G1);
mag2dB = mag2db(evalAtF(G2,f)); f3db2 = find_3db_freq(G2);
mag3dB = mag2db(evalAtF(G3,f)); f3db3 = find_3db_freq(G3);
mag4dB = mag2db(evalAtF(G4,f)); f3db4 = find_3db_freq(G4);
mag5dB = mag2db(evalAtF(G5,f)); f3db5 = find_3db_freq(G5);
semilogx(f,mag1dB,f,mag2dB,f,mag3dB,f,mag4dB,f,mag5dB);
hold on;
xline(f3db1,'--',num2str(f3db1));
xline(f3db2,'--',num2str(f3db2));
xline(f3db3,'--',num2str(f3db3));
xline(f3db4,'--',num2str(f3db4));
xline(f3db5,'--',num2str(f3db5));
yline(-3,'--','-3dB Line');
legend(lb1,lb2,lb3,lb4,lb5,'-3dB Line');
grid on;
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); title('Bandwidth Comparison');
