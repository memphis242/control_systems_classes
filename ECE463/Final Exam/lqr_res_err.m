function [err] = lqr_res_err(X)
a = X(1); b = X(2);
if a < 0 || b < 0
    err = 50;
    return;
end

sig = -2/3; wd = 0.9097;
res = lqr_res(a,b);

e1 = abs(sig - real(res));
err = e1.^2;

% e1 = abs(sig - real(res));
% e2 = abs(wd - imag(res));
% err = e1.^2 + e2.^2;

% e1 = abs(sig - real(res));
% e2 = abs(imag(res));
% err = e1.^2 + e2.^2;

end

