function [fval] = fvalfunc(G,fr)

if fr < 0
    fval = 1e6;
else
    fval = mag2db(evalAtF(G,fr));
end

end

