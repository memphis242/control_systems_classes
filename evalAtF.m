function [magResp] = evalAtF(G,f)
% Inputs
%      G --> System
%      f --> Frequency in Hz
% Outputs
%      magResp --> Magnitude of system response over f

magResp = zeros(size(f));
for i=1:length(f)
    magResp(i) = abs(evalfr(G,1j*2*pi*f(i)));
end

end

