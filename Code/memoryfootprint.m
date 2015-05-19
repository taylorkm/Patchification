% SVD compression rate
svdr = @(k,n,m) k*(1+n+m);
qsvdr = @(k,p,n,m) k*(1+p.^2+n*m./(p.^2));

ks = 1:50;
ps = 2:50;
p = 16;
k = 32;
ns = [256,900];
ms = [256,1600];


ss = get(0,'ScreenSize');
figure('Position',[(ss(3)-900)/2 200 900 350])
subplot(1,2,1)
plot(ps, ones(size(ps))*svdr(k, ns(1), ms(1)),'--', ps, qsvdr(k, ps, ns(1), ms(1)),'-','linewidth',1.5)
xlabel('p','fontsize',14)
ylabel(['Memory footprint using k = ',num2str(k)],'fontsize',14)
set(gca,'yscale','log')
legend('T','Q')
set(gca,'fontsize',14)



subplot(1,2,2)
plot(ps, ones(size(ps))*svdr(k, ns(2), ms(2)),'--',ps, qsvdr(k,ps,ns(2),ms(2)),'-','linewidth',1.5)
xlabel('p','fontsize',14)
ylabel(['Memory footprint using k = ',num2str(k)],'fontsize',14)
set(gca,'yscale','log')
legend('T','Q')
set(gca,'fontsize',14)