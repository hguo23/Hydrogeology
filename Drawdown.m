function A = Drawdown(D,Ss,b,rw,w)
%% calculate drawdown based on Hsieh et al., 1987
i = sqrt(-1);
S = Ss.*b;
T = D*S;
alphaw = sqrt(w./D)*rw;
[Ker0, Kei0] = kelvink(0, alphaw);
[Ker1, Kei1] = kelvink(1, alphaw);
phi = -(Ker1+Kei1)./(sqrt(2).*alphaw.*(Ker1.^2+Kei1.^2));
psi = -(Ker1-Kei1)./(sqrt(2).*alphaw.*(Ker1.^2+Kei1.^2));
B = (phi*Ker0-psi*Kei0+i*(psi*Ker0+phi*Kei0))/(2*pi*T);
A = 1./B;