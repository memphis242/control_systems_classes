G = zpk([],[-0.1617,-1.04,-2.719,-5.05],1.4427, 'InputDelay', 0.5);
w = logspace(-1,1,1001);
Gw = Bode2(G,w);
Nichols2(Gw,1.5);
hold on;
xline(-180); yline(0);