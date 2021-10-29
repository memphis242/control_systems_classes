% Sampling setup
Tend = 10;
Fs = 10e3; Ts = 1/Fs;
T_total = Tend; L = T_total*Fs;
t = (0:L-1)*Ts;

% Noise
t = [0:Ts:Tend]';
mu = 0; sig = 1;
n = normrnd(mu,sig,size(t));

% Filter
G = tf([0 100 10],[1 10 25]);
% bode(G)
% grid on;
% pause
[A,B,C,D] = tf2ss([0 100 10],[1 10 25]);
X0 = zeros(2,1);

% System response
clf
Y1 = n;
Y2 = step3(A,B,C,D,t,X0,n);

%% FFT

% Computing FFT
X1 = fft(Y1);
X2 = fft(Y2);

% Produce single-sided spectral result
Xf1 = abs(X1/L);
Xf1 = Xf1(1:L/2+1);
Xf1(2:end-1) = 2*Xf1(2:end-1);

Xf2 = abs(X2/L);
Xf2 = Xf2(1:L/2+1);
Xf2(2:end-1) = 2*Xf2(2:end-1);

% Frequency axis
f = Fs*(0:(L/2))/L;

%% Plot
subplot(1,2,1);
plot(t,Y1,t,Y2);
legend('Y1 (white noise)', 'Y2 (pink noise');
grid on;
xlabel('Time (s');

subplot(1,2,2);
plot(f,Xf1,f,Xf2);
title_txt = ['Single-Sided Amplitude Spectrum @ Fs = ',num2str(Fs/1e3),' kHz for ',num2str(Tend),' sec and \sigma = ',num2str(sig)];
title(title_txt);
xlabel('f (Hz)');
legend('Y1 (white noise)','Y2 (pink noise)');
grid on;
ymax = max(Xf2)*1.2;
incr = ymax/12;
yticks([0:incr:ymax]);
