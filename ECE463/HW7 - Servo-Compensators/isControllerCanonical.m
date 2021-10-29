function [val] = isControllerCanonical(A)

sz = size(A);
N = sz(1);

if sz(1)~= sz(2)
    error('Matrix is not square!');
end

% Check first column to see if it's all zeros until last entry or not
col1 = A(:,1);
col1_excluding_bottom = col1([1:N-1]);
zero_vec = zeros(N-1,1);

if ~isequal(col1_excluding_bottom,zero_vec)
    val = false;
    return;
end

% Now check whether matrix formed by excluding first col and last row is
% identity
B = A(1:N-1,2:N);

if isequal(B,eye(N-1))
    val = true;
    return;
else
    val = false;
    return;
end

end

