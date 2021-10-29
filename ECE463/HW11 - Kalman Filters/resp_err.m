function [err] = resp_err(G,Gd,Tend)
t = linspace(0,Tend,1001);
y = step(G,t);
yd = step(Gd,t);
err = norm(y-yd)^2;
end

