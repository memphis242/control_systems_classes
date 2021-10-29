function [c,ceq] = const2(X)
mbeam = X(1); L = X(2);
Jbeam = (1/12)*mbeam*L^2;
Jbeam_d = 2;
c = [];
ceq = Jbeam - Jbeam_d;
end

