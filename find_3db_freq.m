function [freq3db] = find_3db_freq(G)

fr = logspace(0,2,1e4);
maxVal = max(evalAtF(G,fr));

e = @(fr) abs(fvalfunc(G,fr) + 3);
freq3db = fminsearch(e,100);

end

