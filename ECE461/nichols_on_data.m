Gdb = [4.63,-0.21,-4.45,-8.17,-11.51,-14.55];
P = deg2rad([-67.7,-107,-133.67,-154.08,-170.63,184.51]);
Gw = 10.^(Gdb/20) .* exp(1j*P);

Nichols2(Gw,1.5);