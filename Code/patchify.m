function Atilde = patchify(A,p)
% Split a matrix into non-overlapping p-by-p patches.  

[n,m] = size(A);
if (mod(n,p) || mod(m,p))
    error('p must divide dimensions of A')
end
ntilde = n/p;
mtilde = m/p;

patches = mat2cell( A, p*ones(1,ntilde), p*ones(1,mtilde) );
Atilde = zeros( p^2, ntilde*mtilde );
k = 1;

for i = 1:ntilde
    for j = 1:mtilde       
        v = patches{i,j};               
        Atilde(:,k) = v(:);
        k = k + 1;
    end
end


