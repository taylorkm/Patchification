% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% What happens if we start with a nth-order matrix, A, then run it through
% the Q_{\hat k, p} operator?  We will find that Q_{\hat k, p} is
% idempotent.
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

n = 256; % image is n-by-n
k_hat = 7; % image is rank k
p = 16; % patches are p-by-p
A = double( imread('cameraman.tif') );% n-by-n image

A1 = Qtransform(k_hat, p, A ); % running original A through cycle
A2 = Qtransform(k_hat, p, A1); % running output through cycle one more time

% Demonstrate that S(A) is typically equal to min( p^2, (n/p)^2 )
fprintf('Rank of A: %d\n', rank(A))
fprintf('Rank of S(A): %d\n', rank(patchify(A,p)))

fprintf('Rank of Q(A): %d\n', rank(A1))
fprintf('Rank of S(Q(A)): %d\n', rank(patchify(A1,p)))

