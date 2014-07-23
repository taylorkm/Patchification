% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% If A is rank k, what is the rank of S(A)?
% If (experiment == 'one'), we start with nth order matrix, A, of a 
% specified rank. Then, compute S(A), and estimate its rank.
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

experiment = 'one'; 
n = 256; % image is n-by-n
k = 20; % image is rank k
p = 16; % patches are p-by-p

if strcmp(experiment,'one')
    % Starting with A\in\real^{n\times n} of rank k, what is rank of S(A)?
    X = double( imread('cameraman.tif') );
    A = X(1:n,1:n);
    [U,S,V] = svd(A);
    A = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
    
    % Patchified version of A (S(A))
    Ap = patchify(A, p);
        
    fprintf('Rank of original image: %d\n', rank(A))
    fprintf('Rank of P(A): %d\n', rank(Ap))
    fprintf('Rank of P^{-1}(P(A)): %d\n', rank(depatchify(Ap,p,n,n)))
elseif strcmp(experiment,'two')
    % Starting with A_hat in p^2-by-(n/p)^2 of rank k, what is rank of
    % S^{-1}(A)?    
    
    % A random rank-k matrix in p^2-by-(n/p)^2
    U = gramschmidt( randn( p^2,k), true );
    V = gramschmidt( randn( (n/p)^2,k), true );
    S = diag( rand(k,1) );
    Ap = U*S*V'; 
    
    % Depatchified version of \hat{A}
    A = depatchify(Ap,p,n,n);

    fprintf('Rank of A_hat: %d\n', rank(Ap))
    fprintf('Rank of P^{-1}(A_hat): %d\n', rank(A))
end

figure
hold on
plot(svd(A), 'o')
plot(svd(Ap), 'rx')
ylim([0,0.5e4])
legend('\sigma (A)','\sigma (S_p(A))')
sti(A,Ap)