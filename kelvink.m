function [ker, kei] = kelvink(n, x)
% kelvin function
% n: order
i = complex(0,1);
a = exp(pi*i/4);
b = exp(-n*pi*i/2);
ke = b*besselk(n,x*a);
ker = real(ke);
kei = imag(ke);