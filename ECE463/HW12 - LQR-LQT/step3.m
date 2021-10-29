function [ y ] = step3( A, B, C, D, t, X0, U )


    T = t(2) - t(1);
    [m, n] = size(C);

    npt = length(t);

    Az = expm(A*T);
    Bz = B*T;

    X = X0;

    y = zeros(npt, m);

    y(1,:) = (C*X + D * ( U(1,:)' ) )';

    for i=2:npt
        X = Az*X + Bz*( U(i,:)' );
        Y = C*X + D * ( U(i,:)' );

        y(i,:) = Y';
    end

end
