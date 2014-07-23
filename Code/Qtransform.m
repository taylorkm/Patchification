function B = Qtransform(k_hat, p, A)
A_hat = patchify(A,p);
T_hat = Ttransform('svd',k_hat,A_hat);
B = depatchify(T_hat, p, size(A,1), size(A,2));