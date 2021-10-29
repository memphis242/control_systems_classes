function [zeta, th, w] = getForOS(desired_OS, sig)

MOS = @(z) exp(-pi * (z./sqrt(1-z.^2)));
E = @(z) abs(MOS(z) - desired_OS);
[zeta,err] = fminsearch(E, 0.5);
th = acosd(zeta);
w = abs(sig)*tand(th);

end