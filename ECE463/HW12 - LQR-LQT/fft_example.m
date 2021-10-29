% Sampling setup
Fs = 1e3; Ts = 1/Fs;
T_total = 1.5; L = T_total*Fs;
t = (0:L-1)*Ts;

% Example signals
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t); % Clean signal
mu = 0; sig = 1;
X = S + 2*normrnd(mu,sig,size(t)); % Noise added on

% Computing FFT
Y = fft(X);

% We usually want to see the one-sided spectrum - i.e., writing x(t) as a
% sum of discrete or continuous real cosines/sines
P2 = abs(Y/L);  % fft function output is scaled by the length of the data, so un-scale it
P1 = P2(1:L/2+1);   % Now we're gonna take half of the spectrum
P1(2:end-1) = 2*P1(2:end-1);    % And then all spectral values aside from DC are multiplied by two due to symmetry about y-axis of magnitude spectrum of real signals

% Now plot!
f = Fs*(0:(L/2))/L;
plot(f,P1);
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)'); ylabel('|P1(f)|');
