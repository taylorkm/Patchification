% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% Compare the quality of reconstructing an image matrix using SVD and NMF
% on full-sized and shuffled version of the input image.
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

n = 256; % look at n-by-n image NO SUPPORT FOR CHANGING N
% load trees;
X = double( imread('cameraman.tif') );
A = X(1:n,1:n); % extract square image

% guarantee input is rank kd
% k = 4;
% [U,S,V] = svd(A);
% A = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';


ps = [4,8,16]; % patch sizes
ranks = 1:20;
erSVDP = nan(length(ranks), length(ps));
erNMFP = nan(length(ranks), length(ps));
erSVD = nan(length(ranks), 1);
erNMF = nan(length(ranks), 1);


for i = 1:length(ps) % For each patch-size
    % Patchify and decopose
    p = ps(i); % patch size
    Ap = patchify(A, p); 
    [Up,Sp,Vp] = svd(Ap,'econ');
    
    
    % Reconstruct
    Arecon = zeros( p^2, n^2/p^2 );
    for j = 1:length(ranks) % for each rank
        r = ranks(j);
        if ( r > size(Sp,1) || r > size(Sp,2) )
            break
        end
        % SVDP Error
        Arecon = Arecon + Sp(r,r)*Up(:,r)*Vp(:,r)';      
        erSVDP(j,i) = norm( A - depatchify( Arecon, p, n, n ), 'fro' );

        % NMFP Error        
        [Wp,Hp] = nnmf( Ap, r );
        erNMFP(j,i) = norm( A - depatchify( Wp*Hp, p, n, n ), 'fro' );
    end
    erSVDP(:,i) = erSVDP(:,i)/numel(A);  % MSE
    erNMFP(:,i) = erNMFP(:,i)/numel(A);  % MSE
end



% SVD Error
[U ,S ,V ] = svd(A,'econ'); % decompose
AreconSVD = zeros(n,n);
for j = 1:length(ranks)
    r = ranks(j); 
    AreconSVD = AreconSVD + S(r,r)*U(:,r)*V(:,r)';
    erSVD(j) = norm(A-AreconSVD,'fro');
    [W,H] = nnmf(A, r);
    erNMF(j) = norm(A-W*H, 'fro');
end
erSVD = erSVD/numel(A);
erNMF = erNMF/numel(A);

% Visualize results
figure('Position', [268   281   895   423])
hold all
plot(ranks, erSVD,  '.-', 'linewidth', 2)
plot(ranks, erSVDP, '.-',  'linewidth', 2)
plot(ranks, erNMF,  '--', 'linewidth', 2)
plot(ranks, erNMFP, '.--', 'linewidth', 2)
temp1 = arrayfun( @(x)['p = ',num2str(x),'(SVD)'], ps, 'un', 0);
temp2 = arrayfun( @(x)['p = ',num2str(x),'(NMF)'], ps, 'un', 0);

legend( [{'SVD (w/o patchification)'},temp1,{'NMF (w/o patchification)'},temp2] )
ylabel('MSE','fontsize',14)
xlabel('k(hat)','fontsize',14)
set(gca,'fontsize',14)
title('Quality of reconstruction','fontsize',14)
axis tight
