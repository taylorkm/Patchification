% Original images for processing
% If khat = p
A = double(imread('ImageDatabase/lena.jpg','jpg'));
% A = double( imread('cameraman.tif') );

[m,n] = size(A);
fontSize = 14;
p = 16; % patch size is p-by-p

figure,imagesc(A),colormap gray,title('Original image','fontsize',fontSize);

% 
Ahat = patchify(A, p);
[m2,n2] = size(A);

[~,idx] = sort(var(Ahat),'descend');
Ahat_srtd = Ahat(:,idx);




[U,S,V] = svd(Ahat,'econ');
DSVD = U*S;


khat = 32;
rng(1)
[W,H] = nnmf(Ahat,khat,'algorithm','mult','replicates',1);%20);


sumH = sum(H);
idx = sumH < quantile(sumH, .13);


cmappos = pink(64);
cmappos2 = pink(128);
cmapneg = flipud(bone(64));
cmapposneg = [cmapneg;cmappos];



showDictionary(Ahat(:,idx),4,8);
colormap(cmappos2);
%title('Original Patches','fontsize',fontSize)



showDictionary(DSVD(:,2:end),4,8);
colormap(cmapposneg);
% title('SVD Dictionary','fontsize',fontSize)


showDictionary(W,4,8);
colormap(cmappos2);
% title('NMF Dictionary','fontsize',fontSize)