function y = cost(z)
a = z(1);
b = z(2);

e1 = a*cosh( -b/a) - 1;
e2 = a*cosh( (1-b)/a) - 1;

y = e1^2 + e2^2;

end