% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%
% Create a 2D plot of PSNR vs Memory Footprint -- in analogy with
% rate-distortion curves.
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% Original images for processing
A = double(imread('ImageDatabase/lena.jpg','jpg'));
% A = double( imread('cameraman.tif') );
[n,m] = size(A);

% for computing psnr
psnr = @(e) 10*log10(1/e);
% set of k values
ks = 2:2:50;
% set of p values
ps = [4,8,16,32,64]; 

% Allocate space
mf1 = zeros( length(ks), 1 );
er1 = zeros( length(ks), 1 );
mf2 = zeros( length(ks), length(ps) );
er2 = zeros( length(ks), length(ps) );
khats = nan( length(ks), length(ps) );

rng(0);

for i1 = 1:length(ks)
    k = ks(i1);
    mf1(i1) = k*(n+m);
    er1(i1) = psnr( 1/(n*m)*norm(A - Ttransform('nmf', k, A), 'fro') );
    for i2 = 1:length(ps)
        p = ps(i2);
        khat = ceil( k*(n+m)/(1+p^2+n*m/p^2) );
        khats(i1,i2)= khat;
        if ( i1 > 1 && khats(i1,i2) == khats(i1-1,i2) )
            mf2(i1,i2) = mf2(i1-1,i2);
            er2(i1,i2) = er2(i1-1,i2);
            continue
        else
            mf2(i1,i2) = khat*(1+p^2+n*m/p^2);
            er2(i1,i2) = psnr( 1/(n*m)*norm(A - Qtransform('nmf', khat,p,A),'fro') );
        end        
    end
end



% We can verify tht mf2 <= mf1 with the command all(mf2(:)<=mf1(:))



figure('position',[355,200,750,550])
plot(mf1,er1,'-',mf2,er2,'--','linewidth',4)
axis tight
xlabel('Memory Footprint','fontsize',22)
ylabel('PSNR','fontsize',22)
temp = arrayfun(@(x)['p = ',num2str(x)],ps,'un',0);
legend([{'T_k'},temp],'location','SE')
set(gca,'fontsize',22)
xlim([.1e4,2.5e4])


% temp = get(gca,'ColorOrder'); % cell of RGBS for colors
% offset = 500;
% for j = 1:length(ps)
%     for i = 1:length(ks)
%         text(mf2(i,j)+offset, er2(i,j)-0.2, num2str(khats(i,j)), 'color', temp(j+1,:) ,'fontsize',16)
%     end
% end