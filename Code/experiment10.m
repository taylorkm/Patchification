% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% 
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

k_hat_AsPercent = .5;
JMax = 10;
ns = 2.^(1:JMax);


% An image from the van Hateren database
f1 = fopen('ImageDatabase/imk00002.imc', 'r', 'ieee-be');
w = 1536;
h = 1024;
A0 = fread(f1, [w, h], 'uint16');

reconError = nan(length(ns), length(ns));
for i = 1:length(ns) 
    n = ns(i);
    A = A0(1:n, 1:n)'; % test-image of size n-by-n     
    for j = 1:i
        p = ns(j); % patch-size
        rr = ceil( k_hat_AsPercent * min(p^2,(n/p)^2) );
        fprintf('n = %d, p = %d, rr = %d\n', n, p, rr);
        reconError(i,j) = norm(A-Qtransform(rr, p, A),'fro');
    end
    reconError(i,:) = reconError(i,:)/numel(A); % FOR MSE
end

for i = 1:length(ns)
    reconError(i,i) = nan;
end

figure,imagesc(A),colormap gray

figure
loglog(ns,reconError','o-','linewidth',1.5)
temp1 = arrayfun( @(x)['n = ',num2str(x)], ns, 'un', 0);
legend(temp1)
xlabel('patch size (p)','fontsize',14)
ylabel('MSE','fontsize',14)
set(gca,'xtick',ns)
set(gca,'fontsize',14)



% Find optimal patch-size and plot it
[~,idx] = min(reconError,[],2);
figure
plot(ns,sqrt(ns),'r--', 'linewidth', 2)
hold on
plot(ns, 2.^idx, 'o-', 'linewidth', 2)
set(gca,'yscale','log')
set(gca,'xscale','log')
legend('n^{1/2}','p_{opt}')
xlabel('n','fontsize',14)
ylabel('optimal patch size','fontsize',14)
set(gca,'fontsize',14)
set(gca,'xtick',ns)
set(gca,'ytick',ns)
grid on
