% Test the algorithmic complexity of computing the svd of a patchified
% version of the matrix.
p = 8; % patches will be p-by-p
ns = 20:4:100;
% ms = ceil(ns*1);
ms = ceil(ns/p)*p;
t1 = zeros(size(ns));
t2 = zeros(size(ns));
t3 = zeros(size(ns));

for it = 1:length(ns)

    % Build simple image  
    
    ntilde = ns(it);
    mtilde = ms(it);

    n = p*ntilde;
    m = p*mtilde;

    
    A = rand(n,m);
    Ahat = patchify(A,p);

    % Approximate
    tic
    [U,S,V] = svd(A);
    t1(it) = toc;
    
    tic
    [Utilde,Stilde,Vtilde] = svd(Ahat);
    t2(it) = toc;
    
    tic
    [Utilde1,Stilde1,Vtilde1] = svd(Ahat,'econ');
    t3(it) = toc;

end


% Visualize
figure
x = p^2*ns.*ms;

% loglog(x,t1,'bx-',x,t2,'rx-',x,t3,'gx-','linewidth',1.5)
% legend('Computing T','Computing Q','Computing Q (economy)','location','SE')
loglog(x,t1,'bx-',x,t3,'gx-','linewidth',1.5)
legend('Computing T','Computing Q (economy)','location','SE')
xlabel('Total # of Matrix Entries')
ylabel('Time Req to Compute (sec.)')
set(gca,'fontsize',14)
title('Timing Comparisons')





