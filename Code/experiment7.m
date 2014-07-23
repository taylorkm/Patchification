% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% What is the rank of P(A) when starting with a rank-k matrix A?
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

n = 300; % image is n-by-n
k = 150; % rank
type = 'image';

% make sure it is rank k
if strcmp(type,'random')
    Q = gramschmidt( rand(n,k), true );
    S = diag(rand(k,1));
    A = Q*S*Q';
elseif strcmp(type, 'image')    
    load mandrill;
    A = X(1:n,1:n);
    [U,S,V] = svd(A);
    A = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
end

% For various patch sizes, estimate the rank of P(A).
ps = [2, 3, 4, 5, 6, 10, 12, 15, 20, 25, 30, 50, 60, 75, 100, 150];
for i = 1:length(ps)
    p = ps(i);
    Ahat = patchify( A, p );    
    r(i) = rank(Ahat);
end

disp('The differenbe between the rank of P(A) and estimate is:')
disp( r - min(ps.^2,n^2./(ps.^2)) )