A = double(imread('ImageDatabase/lena.jpg','jpg'));
% A = double( imread('cameraman.tif') );


[n,m] = size(A);

% to compute psnr
psnr = @(e) 10*log10(1/e);
% set of k values
ks = 2:2:50;
% set of p values
ps = [4,8,16,32,64]; 


mf1 = zeros( length(ks), 1 );
er1 = zeros( length(ks), 1 );
mf2 = zeros( length(ks), length(ps) );
er2 = zeros( length(ks), length(ps) );
khats = zeros( length(ks), length(ps) );
for i1 = 1:length(ks)
    k = ks(i1);
    mf1(i1) = k*(1+n+m);
    er1(i1) = psnr( 1/(n*m)*norm(A - Ttransform('svd', k, A), 'fro') );
    for i2 = 1:length(ps)
        p = ps(i2);
        khat = ceil( k*(1+n+m)/(1+p^2+n*m/p^2) );
        khats(i1,i2)= khat;
        mf2(i1,i2) = khat*(1+p^2+n*m/p^2);
        er2(i1,i2) = psnr( 1/(n*m)*norm(A - Qtransform('svd',khat,p,A),'fro') );
    end
end



% We can verify tht mf2 <= mf1 with the command all(mf2(:)<=mf1(:))



figure('position',[355,200,750,550])
plot(mf1,er1,'-',mf2,er2,'--','linewidth',4)
axis tight
xlabel('Memory Footprint','fontsize',22)
ylabel('PSNR','fontsize',22)
temp = arrayfun(@(x)['p = ',num2str(x)],ps,'un',0);
legend([{'T_k'},temp],'location','NW')
set(gca,'fontsize',22)
xlim([.1e4,2.5e4])


% temp = get(gca,'ColorOrder'); % cell of RGBS for colors
% offset = 500;
% for j = 1:length(ps)
%     for i = 1:length(ks)
%         text(mf2(i,j)+offset, er2(i,j)-0.2, num2str(khats(i,j)), 'color', temp(j+1,:) ,'fontsize',16)
%     end
% end