MOS = @(z) exp(-pi * (z./sqrt(1-z.^2)));
desired_OS = 0.05;
E = @(z) abs(MOS(z) - desired_OS);
[zeta,err] = fminsearch(E, 0.5)

% tp = 1;
% wn = pi / (tp*sqrt(1-zeta^2))
% 
% J = 1; B = 1;
% K = J*wn^2
% Kh = (2*zeta*sqrt(K*J) - B) / K
% 
% wd = wn*sqrt(1-zeta^2)
% sigma = wn*zeta
% B = atan(wd / sigma)
% tr = (pi - B)/wd
% ts = [3/sigma 4/sigma]