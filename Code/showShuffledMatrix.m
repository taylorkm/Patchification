% import lena image
A = double(imread('ImageDatabase/lena.jpg','jpg'));
p = 16;



% view shuffled image
Ahat = patchify(A,p);

figure(1)
% subplot(1,2,1)
imagesc(A)
colormap gray
c = caxis;
truesize

figure(2)
% subplot(1,2,2)
imagesc(Ahat)
colormap gray
caxis(c)
truesize

figure
imagesc(reshape(Ahat(:,139),p,p))
colormap gray
caxis(c)
truesize


% Create a plot with subaxes positioned wherever you want
figPosition = [0, 0, 900, 450];
f = figure('Position', figPosition);

% a1 and a2 will be right next to one another
a1Position = [0.05, 0.05, 0.45, 0.9];
a1 = axes('Position', a1Position);
imagesc(A)
colormap gray
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])

a2Position = [0.5, 0.05, 0.45, 0.9];
a2 = axes('Position', a2Position);
imagesc(Ahat)
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])



