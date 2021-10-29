%% Constant zeta contours
zeta = 0:0.05:1;
wd_T = linspace(0,pi,101);  % wd_T is the same Om

pz_mag = zeros(length(zeta),length(wd_T));
zp = zeros(length(zeta), length(wd_T));

for i = 1:length(zeta)
    
    alpha = -zeta(i) / sqrt(1-zeta(i)^2);
    pz_mag(i,:) = exp(alpha*wd_T);
    zp(i,:) = pz_mag(i,:).*exp(1j*wd_T);
    
    plot(real(zp(i,:)), imag(zp(i,:)));
    xlabel('Re{z}'),ylabel('Im{z}');
    str = ['\zeta = ' num2str(zeta(i))];
    title(str);
    grid on;
    ylim([-1.2 1.2]),xlim([-1.2 1.2]);
    hold on;
    pause
    
end
