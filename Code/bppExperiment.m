n = 2048;
v = linspace(-1,1, n);
T = 0.2; % is this related to bits-per-pixel?
vI = floor(abs(v/T)).*sign(v);
vQ = sign(vI) .* (abs(vI)+.5) * T;

clf;
subplot(1,2,1);
plot(v, vI);
axis('tight');
title(strcat(['Quantized integer values, T=' num2str(T)]));
subplot(1,2,2);
hold('on');
plot(v, vQ);
plot(v, v, 'r--');
axis('equal'); axis('tight');
title('De-quantized real values');