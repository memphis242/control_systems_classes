function [E] = soapFilmCost(Z)
c1 = 6; c2 = 5;

a = Z(1); b = Z(2);

E1 = abs(a*cosh(-b/a) - c1);
E2 = abs(a*cosh((5-b)/a) - c2);

E = E1 + E2;

end

