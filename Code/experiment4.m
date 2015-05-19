% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% Compare the quality of reconstructing an image matrix using regular SVD,
% as well as patchified SVD.
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

n = 256; % look at n-by-n image NO SUPPORT FOR CHANGING N
% load trees;
% A = X(1:n,1:n); % extract square image

A = double(imread('ImageDatabase/lena.jpg','jpg'));

ps = [2, 4, 8, 16, 32, 64, 128]; % patch sizes
ranks = 1:128;
er = nan(length(ranks), length(ps));
erSVD = nan(length(ranks), 1);

for i = 1:length(ps) % For each patch-size
    % Patchify and decopose
    p = ps(i); % patch size
    Ap = patchify(A, p); 
    [Up,Sp,Vp] = svd(Ap);
    
    % Reconstruct
    Arecon = zeros( p^2, n^2/p^2 );
    for j = 1:length(ranks)
        r = ranks(j);
        if ( r > size(Sp,1) || r > size(Sp,2) )
            break
        end
        Arecon = Arecon + Sp(r,r)*Up(:,r)*Vp(:,r)';      
        er(j,i) = norm( A - depatchify(Arecon, p, n, n),'fro' );
    end
    er(:,i) = er(:,i)/numel(A); % mse
end




[U ,S ,V ] = svd(A); % decompose
AreconSVD = zeros(n,n);
for j = 1:length(ranks)
    r = ranks(j); 
    AreconSVD = AreconSVD + S(r,r)*U(:,r)*V(:,r)';
    erSVD(j) = norm(A-AreconSVD,'fro');
end
erSVD = erSVD/numel(A);

% Visualize results
figure('Position', [268   281   895   423])
hold all
plot(ranks, erSVD,'k.-','linewidth',1.5)
plot(ranks, er,'.-','linewidth',1.5)
temp = arrayfun(@(x)['p = ',num2str(x)],ps,'un',0);

legend({'SVD (w/o patchification)',temp{:}})
ylabel('MSE','fontsize',14)
xlabel('k(-hat)','fontsize',14)
set(gca,'fontsize',14)
title('Quality of reconstruction','fontsize',14)
axis tight
