fmax = 5;   %Hz
w = linspace(0,2*pi*fmax);
T = 0.1;
Om = linspace(0,pi);

Hc = @(s) 1 ./ (0.1*s + 1);
H = @(z) (1/3)*(z+1) ./ (z-(1/3));
H2 = @(z) 0.3533*(z+1) ./ (z-0.2934);

Hc_mag = abs(Hc(1j*w));
Hc_mag_dB = mag2db(Hc_mag);
H_mag = abs(H(exp(1j*Om)));
H_mag_dB = mag2db(H_mag);
H2_mag = abs(H2(exp(1j*Om)));
H2_mag_dB = mag2db(H2_mag);

f = w/(2*pi);
subplot(2,1,1);
plot(f, Hc_mag, 'LineWidth', 2);
xlabel('Frequency (Hz)'), ylabel('Magnitude'), title('Linear Axes Comparison');
grid on;
hold on;
plot( (Om/T)/(2*pi), H_mag, 'LineWidth', 2);
legend('CT', 'DT');

subplot(2,1,2);
plot(f, Hc_mag_dB, 'LineWidth', 2);
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)'), title('dB Comparison');
grid on;
hold on;
plot( (Om/T)/(2*pi), H_mag_dB, 'LineWidth', 2);
legend('CT', 'DT');