function A_recon = depatchify(Atk,p,n,m)
% This function inverts the patchify function.  In other words
% A = depatchify( patchify(A, p), p, size(A,1), size(A,2) )
ntilde = n/p;
mtilde = m/p;

k = 1;
patch_recon = cell(ntilde, mtilde);
for i = 1:ntilde
    for j = 1:mtilde
        patch_recon{i,j} = reshape( Atk(:,k), [p,p] );
        k = k+1;
    end
end

A_recon = cell2mat(patch_recon);


