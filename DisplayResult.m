clear;clc
%%
load Well2_result.mat
P = Pout2;
%%
df = P(:,2);
dr1 = P(:,3);
dr2 = P(:,6);
ssf = P(:,4);
ssr = P(:,5);
b1 = P(:,1);
b2 = P(:,7);

%% sama as the presseting in Grid Search
wellname1 = ; % well 1
wellname2 = ; % well 2
dfvec = ; % fault diffusivity
drvec1 = ; % host rock diffusivity of well 1
ssfvec = ; % specific storage of fault
ssrvec = ; % specific storage of host rock
bvec1 = ; % fault thickness at well 1
drvec2 = ; % host rock diffusivity of well 2
bvec2 = ; % fault thickness at well 2

%% params
 ConfInter = 90; % confidence interval
 n = 0.2; % smooth factor
%% diffusivity
    dfmin = min(dfvec);
    dfmax = max(dfvec);
    dfc = hist(df,dfvec);
    dflhd = dfc/sum(dfc);
    dflhd_out = smooth(dfvec,dflhd,n);
    [dfLB, dfUB] = ConfidenceInter(ConfInter,df);
    
    drmin1 = min(drvec1);
    drmax1 = max(drvec1);
    drc1 = hist(dr1,drvec1);
    drlhd1 = drc1/sum(drc1);
    drlhd1_out = smooth(drvec1,drlhd1,n);
    [drLB1, drUB1] = ConfidenceInter(ConfInter,dr1);

    drmin2 = min(drvec2);
    drmax2 = max(drvec2);
    drc2 = hist(dr2,drvec2);
    drlhd2 = drc2/sum(drc2);
    drlhd2_out = smooth(drvec2,drlhd2,n);
    [drLB2, drUB2] = ConfidenceInter(ConfInter,dr2);
    

    
    figure(1);clf;hold on
    plot(dfvec,dflhd,'LineWidth',2,'Color',[224 221 211]/255);
    plot(dfvec,dflhd_out,'LineWidth',3,'Color',[255 187 0]/255);
    box on;grid on
    xlim([dfvec(1) dfvec(end)]);    
    xlabel('fault diffusivity (m^2/s)');
    ylabel('probablity')
    scatter(dfLB,mean(dflhd),'r','filled')
    scatter(dfUB,mean(dflhd),'r','filled')
    set(gca,'Fontsize',14);
    hold off
    
    figure(2);clf;
    subplot(2,1,1);hold on
    plot(drvec1,drlhd1,'LineWidth',2,'Color',[224 221 211]/255);
    plot(drvec1,drlhd1_out,'LineWidth',3,'Color',[255 187 0]/255);
    box on;grid on
    xlim([drvec1(1) drvec1(end)]);
    xlabel(['host rock diffusivity at ',wellname1,' (m^2/s)']);
    ylabel('probablity')
    scatter(drLB1,mean(drlhd1),'r','filled')
    scatter(drUB1,mean(drlhd1),'r','filled')
    set(gca,'Fontsize',14);
    hold off
    subplot(2,1,2);hold on
    plot(drvec2,drlhd2,'LineWidth',2,'Color',[224 221 211]/255);
    plot(drvec2,drlhd2_out,'LineWidth',3,'Color',[255 187 0]/255);
    set(gca,'XScale','log');
    xlim([drvec2(1) drvec2(end)]);
    xlabel(['host rock diffusivity at ',wellname2,' (m^2/s)']);
    ylabel('probablity')
    scatter(drLB2,mean(drlhd2),'r','filled')
    scatter(drUB2,mean(drlhd2),'r','filled')
    set(gca,'Fontsize',14);
    box on;grid on
    hold off

%% specific storage
    ssfmin = min(ssfvec);
    ssfmax = max(ssfvec);
    ssfc = hist(ssf,ssfvec);
    ssflhd = ssfc/sum(ssfc);
    ssflhd_out = smooth(ssfvec,ssflhd,n);
    [ssfLB, ssfUB] = ConfidenceInter(ConfInter,ssf);
    
    ssrmin = min(ssrvec);
    ssrmax = max(ssrvec);
    ssrc = hist(ssr,ssrvec);
    ssrlhd = ssrc/sum(ssrc);
    ssrlhd_out = smooth(ssrvec,ssrlhd,n);
    [rLB, rUB] = ConfidenceInter(ConfInter,ssr);
    
    figure(3);clf
    subplot(2,1,1);hold on
    plot(ssfvec,ssflhd,'LineWidth',2,'Color',[224 221 211]/255);
    plot(ssfvec,ssflhd_out,'LineWidth',3,'Color',[255 187 0]/255);
    box on;grid on
    xlabel('specific storage of fault (1/m)');
    ylabel('probablity')
    scatter(ssfLB,mean(ssflhd),'r','filled')
    scatter(ssfUB,mean(ssflhd),'r','filled')
    set(gca,'Fontsize',14);
    hold off
    subplot(2,1,2);hold on
    plot(ssrvec,ssrlhd,'LineWidth',2,'Color',[224 221 211]/255);
    plot(ssrvec,ssrlhd_out,'LineWidth',3,'Color',[255 187 0]/255);
    set(gca,'XScale','log');
    box on;grid on
    xlabel('specific storage of host rock (1/m)');
    ylabel('probablity')
    xlim([ssrvec(1) ssrvec(end)]);
    scatter(rLB,mean(ssrlhd),'r','filled')
    scatter(rUB,mean(ssrlhd),'r','filled')
    set(gca,'Fontsize',14);
    hold off
    
%% fault thickness
    bmin1 = min(bvec1);
    bmax1 = max(bvec1);
    bc1 = hist(b1,bvec1);
    blhd1 = bc1/sum(bc1);
    blhd1_out = smooth(bvec1,blhd1,n);
    [bLB1, bUB1] = ConfidenceInter(ConfInter,b1);
    
    bmin2 = min(bvec2);
    bmax2 = max(bvec2);
    bc2 = hist(b2,bvec2);
    blhd2 = bc2/sum(bc2);
    lhd2_out = smooth(bvec2,blhd2,n);
    [bLB2, bUB2] = ConfidenceInter(ConfInter,b2);
    
    figure(4);clf
    subplot(2,1,1);hold on
    plot(bvec1,blhd1,'LineWidth',2,'Color',[224 221 211]/255);
    plot(bvec1,blhd1_out,'LineWidth',3,'Color',[255 187 0]/255);
    box on;grid on
    xlabel(['fault thickness at ',wellname1,' (m)']);
    ylabel('probablity')
    xlim([bvec1(1) bvec1(end)]);
    scatter(bLB1,mean(blhd1),'r','filled')
    scatter(bUB1,mean(blhd1),'r','filled')
    set(gca,'Fontsize',14);
    hold off
    subplot(2,1,2);hold on
    plot(bvec2,blhd2,'LineWidth',2,'Color',[224 221 211]/255);
    plot(bvec2,lhd2_out,'LineWidth',3,'Color',[255 187 0]/255);
    box on;grid on
    xlabel(['fault thickness at ',wellname2,' (m)']);
    ylabel('probablity')
    xlim([bvec2(1) bvec2(end)]);
    scatter(bLB2,mean(blhd2),'r','filled')
    scatter(bUB2,mean(blhd2),'r','filled')
    set(gca,'Fontsize',14);
    hold off
