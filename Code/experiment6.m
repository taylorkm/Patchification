% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% How can we represent a P(A)?  It is not a unitary transformation, because
% the spectrum changes. This experiment shows how to represent the
% submatrix, and from there, it seems it is not possible to represent the
% vectorization operation via matrix multiplication.
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

n = 2; % test image is n-by-n

A = reshape(1:n^2, n, n);
e = @(j) [zeros(j-1,1);1;zeros(n-j,1)];

% The matrices B1 and B2 are isometric.
p1 = [1,2];
B1 = [];
for i = p1
    B1 = [B1, e(i)];
end

p2 = [1,2];
B2 = [];
for i = p2
    B2 = [B2, e(i)];
end

B1'*A*B2 % extracts submatrix with rows p1 and columns p2

