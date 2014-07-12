% Given a simple image, compare rank-k approximations obtained via SVD when
% applying the decomposition to the original matrix, then when applying the
% decomposition to a patchified version of the original matrix.


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % Build simple image  % % % % % % % % % % % %
p = 5; % patches will be p-by-p
ntilde = 50;
mtilde = 30;

n = p*ntilde;
m = p*mtilde;

[x,y] = meshgrid( (0:m-1)/m, (0:n-1)/n );
load trees;
A = X(1:n,1:m);
% A = sin(20*pi*x).*cos(15*pi*y); % Original matrix



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % Patchify  % % % % % % % % % % % % % % %
patches = mat2cell( A, p*ones(1,ntilde), p*ones(1,mtilde) );

k = 1;
temp = zeros([p,p,1,ntilde*mtilde]);

Atilde = zeros( p^2, ntilde*mtilde );
for i = 1:ntilde
    for j = 1:mtilde   
        v = patches{i,j};
        temp(:,:,1,k) = v;        
        Atilde(:,k) = v(:);
        k = k + 1;
    end
end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % Approximate % % % % % % % % % % % % % %
[U,S,V] = svd(A);
[Utilde,Stilde,Vtilde] = svd(Atilde);

r = 7;
Ak  = U(:,1:r)*S(1:r,1:r)*V(:,1:r)';
Atk = Utilde(:,1:r)*Stilde(1:r,1:r)*Vtilde(:,1:r)';



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % Depatchify  % % % % % % % % % % % % % %
k = 1;
patch_recon = cell(ntilde, mtilde);
for i = 1:ntilde
    for j = 1:mtilde  
        patch_recon{i,j} = reshape( Atk(:,k), [p,p] );
        k = k+1;
    end
end
A_recon = cell2mat(patch_recon);




% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % Visualize % % % % % % % % % % % % % % %

figure('position',[360, 378, 720, 220])
subplot(1,3,1)
imagesc(A),colormap gray, c = caxis;
title('Original Image')

subplot(1,3,2)
imagesc(Ak),colormap gray
title(['Rank-',num2str(r),' Approx. of Orig. Image.'])

subplot(1,3,3)
imagesc(A_recon),colormap gray
title(['Rank-',num2str(r),' Approx. of Patchification'])







