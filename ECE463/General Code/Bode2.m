function [Gw] = Bode2(G,w)
Gw = zeros(size(w));
for i=1:length(w)
    Gw(i) = evalfr(G,1j*w(i));
end
GdB = 20*log10(abs(Gw));
semilogx(w,GdB);
xlabel('Frequency \omega (rad/s)'); ylabel('Magnitude (dB)'); title('Bode Plot - Magnitude Response');
grid on;
end

