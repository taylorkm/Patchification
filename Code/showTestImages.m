A1 = double(imread('ImageDatabase/lena.jpg','jpg'));
A2 = double( imread('cameraman.tif') );

figPosition = [0, 0, 900, 450];
f = figure('Position', figPosition);

% a1 and a2 will be right next to one another
a1Position = [0.05, 0.05, 0.45, 0.9];
a1 = axes('Position', a1Position);
imagesc(A1)
colormap gray
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])

a2Position = [0.5, 0.05, 0.45, 0.9];
a2 = axes('Position', a2Position);
imagesc(A2)
set(gca,'xtick',[]) % removes ticks on x axis
set(gca,'ytick',[])


