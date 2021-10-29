function [Vmin, V, Vmax] = vol_estimate_cup(d1, d2, h1, h2, acc)

r1 = d1/2; r2 = d2/2;

r1min = r1-acc/2; r1max = r1+acc/2;
r2min = r2-acc/2; r2max = r2+acc/2;
h1min = h1-acc; h1max = h1+acc;
h2min = h2-acc; h2max = h2+acc;

m = (r2 - r1) / (h2 - h1);
m_min = (r2min - r1min) / (h2min - h1min);
m_max = (r2max - r1max) / (h2max - h1max);

fun = @(h) pi*(r1 + m*h).^2;
fun_min = @(h) pi*(r1min + m_min*h).^2;
fun_max = @(h) pi*(r1max + m_max*h).^2;

V = integral(fun, h1, h2);
Vmin = integral(fun_min, h1min, h2min);
Vmax = integral(fun_max, h1max, h2max);


end

