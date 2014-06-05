% Consider a n-by-n image and its rank-k approximation.  Compare this with
% another image obtained by depatchifying a rank-k approximation to a
% patchified version of the n-by-n image.

n = 16; % look at n-by-n image
p = sqrt(n);

load trees;
A = X(1:n,1:n);


Atilde = patchify(A, p); % patchified version of A

[U,S,V] = svd(A);
[Utilde,Stilde,Vtilde] = svd(Atilde);

% A difference between ds and dsa implies that Atilde cannnot represent A
% for any basis, and in fact, A and Atilde are two different operators.

ds = diag(S); % singular values of the original matrix
dsa = diag(Stilde); % singular values of matrix with entries re-ordered.

% Print out first five singular values
disp( [ds(1:5), dsa(1:5)] )


k = 2;

A_k = U(:,1:k)*S(1:k,1:k)*V(:,1:k)'; % best rank-k approximation to A
Atilde_k = Utilde(:,1:k)*Stilde(1:k,1:k)*Vtilde(:,1:k)'; % best rank-k approximation to P(A)

Arecon = depatchify( Atilde_k, p, n, n);

disp(['Error in rank 2 approx: ', num2str( norm(A-A_k,'fro')) ])
disp(['Error in depatchified reconstruction: ', num2str( norm(A-Arecon,'fro')) ])

figure('position',[300   415   860   383])
subplot(1,2,1)
imagesc(A),axis square,colormap gray
title('Input Image')

subplot(1,2,2)
imagesc(A_k),axis square,colormap gray
title('Original Rank-k')

figure('position',[300   415   860   383])
subplot(1,2,1)
imagesc(Atilde),axis square,colormap gray
title('Patchified Input Image')

subplot(1,2,2)
imagesc(Arecon),axis square,colormap gray
title('Depatchified Rank-k')

