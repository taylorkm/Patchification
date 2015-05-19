function showDictionary(W,nr,nc)
% Given a n-by-k matrix W, this function plots each of the k-columns as a
% sqrt(n) -by- sqrt(n) patch.

if ~nargin
    W = eye(16);
end

if nargin < 2
    nr = 2;
    nc = 8;
end


h = 0.001; % stepsize between images

[n,m] = size(W);
p = sqrt(n);
assert( mod(p,1) == 0, 'Number of rows of W must be squared integer.')

minw = min(W(:));
maxw = max(W(:));


ss = get(0,'screensize');
w = 0.4;
figure('Position',[ss(3)*(1-w)/2, ss(4)*(1-w)/2, ss(3)*w, ss(4)*w*(ss(3)/ss(4))*nr/nc] );


k = 1;

for i = nr:-1:1
    for j = 1:nc
        if k > size(W,2)
            return;
        end
        a1Position = [0.05+(j-1)*0.9/nc + nr*h, 0.05+(i-1)*0.9/nr + nc*h, 0.9/nc - nr*h, 0.9/nr-nc*h];        
        axes('Position', a1Position); %#ok<LAXES>        
        imagesc(reshape(W(:,k),p,p))
        colormap gray
        caxis([minw,maxw])
        set(gca,'xtick',[]) % removes ticks on x axis
        set(gca,'ytick',[])
        k = k+1;
    end
end
