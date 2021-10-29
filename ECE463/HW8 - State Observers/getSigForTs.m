function [sig] = getSigForTs(Ts)
tau = Ts/4;
sig = -1/tau;
end