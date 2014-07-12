% Test the algorithmic complexity of computing the svd of a patchified
% version of the matrix.

ns = 2:3:35;
ms = ns;%round(ns*3/5);
t1 = zeros(size(ns));
t2 = zeros(size(ns));

for it = 1:length(ns)

    % Build simple image  
    p = 7; % patches will be p-by-p
    ntilde = ns(it);
    mtilde = ms(it);

    n = p*ntilde;
    m = p*mtilde;

    [x,y] = meshgrid( (0:m-1)/m, (0:n-1)/n );
    load trees;
    A = X(1:n,1:m);

    % Patchify
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


    % Approximate
    tic
    [U,S,V] = svd(A);
    t1(it) = toc;
    tic
    [Utilde,Stilde,Vtilde] = svd(Atilde);
    t2(it) = toc;

end


% Visualize
figure, plot(3*ns,t1,'b.-',3*ns,t2,'r.-')




