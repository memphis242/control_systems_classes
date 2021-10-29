function [] = Nichols2(Gw,Mm)
Gwp = unwrap(angle(Gw))*180/pi;
Gwm = 20*log10(abs(Gw));

% M-circle
phase = linspace(0,2*pi,101);
Mcl = Mm * exp(1j*phase);
Mol = Mcl ./ (1-Mcl);
Mp = unwrap(angle(Mol))*180/pi - 360;
Mm = 20*log10(abs(Mol));
plot(Gwp,Gwm,'b',Mp,Mm,'r');
xlabel('Phase (degrees)');
ylabel('Gain (dB)');
grid on;
% xlim([-220 -120]); ylim([03,201]);
end

