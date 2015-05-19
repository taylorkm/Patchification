% Original image
p = 16;
A = double(imread('ImageDatabase/lena.jpg','jpg'));
Ahat = patchify(A,p);

% SVD
[U,S,V] = svd(Ahat,'econ');


ranks = [8,16,32];

SVDRecon = cell(1,length(ranks));
NMFRecon = cell(1,length(ranks));

rng(1);
for i = 1:length(ranks)
    r = ranks(i);
    % NMF
    [W,H] = nnmf(Ahat, r, 'algorithm', 'mult');
    NMFRecon{i} =depatchify( W*H, p, size(A,1), size(A,2) );
    % SVD
    Areconsvd = zeros(size(Ahat));
    for j = 1:r    
        Areconsvd = Areconsvd + S(j,j)*U(:,j)*V(:,j)';
    end
    SVDRecon{i} = depatchify( Areconsvd, p, size(A,1), size(A,2) );
end

figPosition = [0, 0, 900, 600];
f = figure('Position', figPosition);

% a1 and a2 will be right next to one another
aPosition = [0.05, 0.05, 0.3, 0.45];
a11 = axes('Position', aPosition);
imagesc(NMFRecon{1})
ylabel('NMF','fontsize',14)
colormap gray
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])


aPosition = [0.05, 0.5, 0.3, 0.45];
a12 = axes('Position', aPosition);
imagesc(SVDRecon{1})
title(['k=',num2str(ranks(1))],'fontsize',14)
ylabel('SVD','fontsize',14)
colormap gray
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])


aPosition = [0.35, 0.05, 0.3, 0.45];
a21 = axes('Position', aPosition);
imagesc(NMFRecon{2})
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])

aPosition = [0.35, 0.5, 0.3, 0.45];
a22 = axes('Position', aPosition);
imagesc(SVDRecon{2})
title(['k=',num2str(ranks(2))],'fontsize',14)
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])


aPosition = [0.65, 0.05, 0.3, 0.45];
a31 = axes('Position', aPosition);
imagesc(NMFRecon{3})
set(gca,'xtick',[])
set(gca,'ytick',[])

aPosition = [0.65, 0.5, 0.3, 0.45];
a32 = axes('Position', aPosition);
imagesc(SVDRecon{3})
title(['k=',num2str(ranks(3))],'fontsize',14)
set(gca,'xtick',[])
set(gca,'ytick',[])
