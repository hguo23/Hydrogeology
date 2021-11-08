clear;clc
%% input info
%%% well 1 %%%
wellname1 = ;
H1 = ; % thickness of open portion
amp1 = ; % amplitude response
pha1 = ; % phase response
D1 = ; % effective diffusivity
Ss1 = ; % effective specific storage
h1 = ; % fault thickness
rc1 = ; % Radius of water movement within the well casing
rw1 = ; % Radius of the screened or open portion of the well
thresAmp1 = ; % systematic error of amplitude response
thresPha1 = ; % systematic error of phase response

%%% well 2 %%%
wellname2 = ;
H2 = ; % thickness of open portion
amp2 = ; % amplitude response
pha2 = ; % phase response
D2 = ; % effective diffusivity
Ss2 = ; % effective specific storage
h2 = ; % fault thickness
rc2 = ; % Radius of water movement within the well casing
rw2 = ; % Radius of the screened or open portion of the well
thresAmp2 = ; % systematic error of amplitude response
thresPha2 = ; % systematic error of phase response

%% other info
tau = 12.4206*3600; % Period of the pressure head disturbance, M2 component
w = 2*pi/tau; % angular frequency
num = 1e3; % param used in numerical modelling

%% well 1
%%% presetting %%%
df = ; % fault diffusivity
dr1 = ; % host rock diffusivity of well 1
ssf = ; % specific storage of fault
ssr = ; % specific storage of host rock

% grid search params
count = 0;
param1 = nan(length(df)*length(dr1)*length(ssf)*length(ssr),4);
for i = 1:length(df)
    for j = 1:length(dr1)
        for m = 1:length(ssf)
            for n = 1:length(ssr)
                count = count+1;
                param1(count,:) = [df(i) dr1(j) ssf(m) ssr(n)];
            end
        end
    end
end

Pout1 = [];
da = nan(length(param1),1); %% to store amplitude response error
db = nan(length(param1),1); %% to store phase response error

for n = 1:length(h1)
    for i = 1:length(param1)
        P = param1(i,:);
        da(i) = abs(All_amp(P,[h1(n),H1,rc1,rw1,w,num])/amp1-1);
        db(i) = abs(All_pha(P,[h1(n),H1,rc1,rw1,w,num])/pha1-1);
    end
    I = (da<thresAmp1)&(db<thresPha1);
    c1 = length(Pout1);
    Pout1((c1+1):(c1+sum(I)),:) = [h1(n)*ones(sum(I),1) param1(I,:) da(I) db(I)];
end
save Well1_result Pout1
%%
dr2 = ; % host rock diffusivity of well 2

% grid search params
count = 0;
param1 = Pout1(:,1:5);
dif = Pout1(:,6:7);
param2 = nan(length(dr2)*size(param1,1)*length(h2),9);
for i = 1:length(dr2)
    for j = 1:size(param1,1)
        for k = 1:length(h2)
            count = count+1;
            param2(count,:) = [param1(j,:) dr2(i) h2(k) dif(j,:)];
        end
    end
end

Pout2 = [];
da = nan(length(param2),1); %% to store amplitude response error
db = nan(length(param2),1); %% to store phase response error

for i = 1:size(param2,1)
    P = param2(i,[2,6,4,5]);
    da(i) = abs(All_amp(P,[param2(i,7),H2,rc2,rw2,w,num])/amp2-1);
    db(i) = abs(All_pha(P,[param2(i,7),H2,rc2,rw2,w,num])/pha2-1);
end

I = (da<thresAmp2)&(db<thresPha2);
Pout2(1:sum(I),:) = [param2(I,:) da(I) db(I)];
save Well2_result Pout2
