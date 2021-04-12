function amp = All_amp(P,input)
%% This function is used to calcute the amplitude response of the fault-guided model
%% input
D_f = P(1); % fault diffusivity
D_r = P(2); % host rock diffusivity
Ss_f = P(3); % specific storage of fault
Ss_r = P(4); % specific storage of host rock

b = input(1); % fault thickness
h = input(2); % thickness of well open portion 
rc = input(3); % radius of well casing
rw = input(4); % radius of well open portion
w = input(5); % angular frequency
num = input(6); % param of numerical modelling
%% fault
i = sqrt(-1);
% from Prejean & Brodsky, 2005
A = sqrt(i*w*D_r);
f1 = (A+i*w*b)./(A*Ss_r./Ss_f+i*w*b)./Ss_f; 
% from Hsieh et al., 1987
Af = Drawdown(D_f,Ss_f,b,rw,w); 

%% Rock
% from Prejean & Brodsky, 2005
b=(h-b)/2;
deltab=b/num;
x = deltab/2:deltab:b-deltab/2;
A = sqrt(i*w*D_r);
lambda = sqrt(i*w./D_r);
f2=(1./Ss_f.*(A+i*b*w)./(A*Ss_r./Ss_f+i*b*w)-1./Ss_r).*exp(-lambda.*x)+1./Ss_r;
% from Hsieh et al., 1987
Ar = Drawdown(D_r,Ss_r,deltab,rw,w); 

%% Eq 9 in the corresponding paper
Sum = f1*Af+2*sum(f2)*Ar;
F = Sum./(i*w*pi*rc.^2+Af+2*Ar*length(f2));
amp = abs(F);
end