function At = Ttransform(type, k, A)
At = 0;
if strcmp(type,'svd')
    [U,S,V] = svd(A,'econ');
    At = U(:, 1:k)*S(1:k,1:k)*V(:, 1:k)';
elseif strcmp(type,'nmf')    
    [W,H] = nnmf(A,k,'algorithm','mult');
    At = W*H;
end