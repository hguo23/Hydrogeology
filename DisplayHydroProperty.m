clear;clc
%% input 
D1 = ; % effective diffusivity of well 1
Ss1 = ; % effective specific storage of well 1

D2 = ; % effective diffusivity of well 2
Ss2 = ; % effective specific storage of well 2

%% effective permeability
mu = ; % viscosity
rho = ; % water density
g = 9.81; % gravity acceleration
k1 = D1*Ss1*mu/rho/g;
k2 = D2*Ss2*mu/rho/g;

%%
load Well2_Result.mat
df = P(:,2);
dr1 = P(:,3);
ssf = P(:,4);
ssr = P(:,5);
dr2 = P(:,6);

kf = df.*ssf*mu/rho/g;
kr1 = dr1.*ssr*mu/rho/g;
kr2 = dr2.*ssr*mu/rho/g;
%%
ConfIn = 90; % confidence interval
pc = 30; % number of points in display

[dfmin, dfmax] = ConfidenceInter(ConfIn,df);
dfvec = logspace(log10(dfmin),log10(dfmax),pc); % all figures are in log scale
dfcount = hist(df,dfvec);
[dfcount,I] = sort(dfcount);
dfprob = dfcount/sum(dfcount);
dfvec = dfvec(I);
dfmean = mean(df);

[drmin1, drmax1] = ConfidenceInter(ConfIn,dr1);
drvec1 = logspace(log10(drmin1),log10(drmax1),pc);
drcount1 = hist(dr1,drvec1);
[drcount1,I] = sort(drcount1);
drprob1 = drcount1/sum(drcount1);
drvec1 = drvec1(I);
drmean1 = mean(dr1);

[drmin2, drmax2] = ConfidenceInter(ConfIn,dr2);
drvec2 = logspace(log10(drmin2),log10(drmax2),pc);
drcount2 = hist(dr2,drvec2);
[drcount2,I] = sort(drcount2);
drprob2 = drcount2/sum(drcount2);
drvec2 = drvec2(I);
drmean2 = mean(dr2);

[kfmin, kfmax] = ConfidenceInter(ConfIn,kf);
kfvec = logspace(log10(kfmin),log10(kfmax),pc);
kfcount = hist(kf,kfvec);
[kfcount,I] = sort(kfcount);
kfprob = kfcount/sum(kfcount);
kfvec = kfvec(I);
kfmean = mean(kf);

[krmin1, krmax1] = ConfidenceInter(ConfIn,kr1);
krvec1 = logspace(log10(krmin1),log10(krmax1),pc);
krcount1 = hist(kr1,krvec1);
[krcount1,I] = sort(krcount1);
krprob1 = krcount1/sum(krcount1);
krvec1 = krvec1(I);
krmean1 = mean(kr1);

[krmin2, krmax2] = ConfidenceInter(ConfIn,kr2);
krvec2 = logspace(log10(krmin2),log10(krmax2),pc);
krcount2 = hist(kr2,krvec2);
[krcount2,I] = sort(krcount2);
krprob2 = krcount2/sum(krcount2);
krvec2 = krvec2(I);
krmean2 = mean(kr2);

[ssfmin, ssfmax] = ConfidenceInter(ConfIn,ssf);
ssfvec = logspace(log10(ssfmin),log10(ssfmax),pc);
ssfcount = hist(ssf,ssfvec);
[ssfcount,I] = sort(ssfcount);
ssfprob = ssfcount/sum(ssfcount);
ssfvec = ssfvec(I);

[ssrmin, ssrmax] = ConfidenceInter(ConfIn,ssr);
ssrvec = logspace(log10(ssrmin),log10(ssrmax),pc);
ssrcount = hist(ssr,ssrvec);
[ssrcount,I] = sort(ssrcount);
ssrprob = ssrcount/sum(ssrcount);
ssrvec = ssrvec(I);

%% display
figure(1);clf
sc1 = 80;
sc2 = 50;
subplot(3,1,1);hold on
% fault
scatter(ones(1,length(dfcount)),dfvec,sc2,dfprob,'filled');
scatter(2*ones(1,length(dfcount)),dfvec,sc2,dfprob,'filled');
% host rock
scatter(ones(1,length(drcount1)),drvec1,sc2,drprob1,'filled');
scatter(2*ones(1,length(drcount2)),drvec2,sc2,drprob2,'filled');
% effective value
scatter(1,D1,sc1,'k','filled');
scatter(2,D2,sc1,'k','filled');
set(gca,'YScale','log')
% yticks([1e-6 1e-4 1e-2 1e-0])
ylabel('diffusivity (m^2/s)')
box on;grid on
set(gca,'Fontsize',14)
colorbar
hold off

subplot(3,1,2);hold on
% fault
scatter(ones(1,length(dfcount)),kfvec,sc2,kfprob,'filled');
scatter(2*ones(1,length(dfcount)),kfvec,sc2,kfprob,'filled');
% host rock
scatter(ones(1,length(drcount2)),krvec1,sc2,krprob1,'filled');
scatter(2*ones(1,length(drcount3)),krvec2,sc2,krprob2,'filled');
% effective value
scatter(1,k1,sc1,'k','filled');
scatter(2,k2,sc1,'k','filled');
set(gca,'YScale','log')
% yticks([1e-19 1e-17 1e-15 1e-13])
ylabel('permeability (m^2)')
box on;grid on
set(gca,'Fontsize',14)
colorbar
hold off

subplot(3,1,3);hold on
% fault
scatter(ones(1,length(ssfcount)),ssfvec,sc2,ssfprob,'filled');
scatter(2*ones(1,length(ssfcount)),ssfvec,sc2,ssfprob,'filled');
% host rock
scatter(ones(1,length(ssrcount)),ssrvec,sc2,ssrprob,'filled');
scatter(2*ones(1,length(ssrcount)),ssrvec,sc2,ssrprob,'filled');
% effective value
scatter(1,Ss1,sc1,'k','filled');
scatter(2,Ss2,sc1,'k','filled');
set(gca,'YScale','log')
% yticks([1e-7 1e-6 1e-5])
ylabel('specific storage (1/m)')
box on;grid on
set(gca,'Fontsize',14)
colorbar
hold off

