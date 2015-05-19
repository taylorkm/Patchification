function B = Qtransform(type, k_hat, p, A)
A_hat = patchify(A,p);
if strcmp(type,'svd')
    T_hat = Ttransform('svd',k_hat,A_hat);
elseif strcmp(type,'nmf')
    T_hat = Ttransform('nmf',k_hat,A_hat);
end
B = depatchify(T_hat, p, size(A,1), size(A,2));
