aa = load('b2009_h15_hetero_02/sub_Uplift1.txt');
bb = load('gamma_h20_hetero_Lf_2/sub_gamma_uplift2.txt');

figure; hold on;

plot(bb(:,2)*1000/100,bb(:,1)+200,'-^','markerfacecolor',[232 67 106]/255,'color',[232 67 106]/255);
plot(aa(:,2)*1000,aa(:,1)+200,'-^','markerfacecolor',[67 106 232]/255,'color',[67 106 232]/255);

legend('Gamma','b2009');

xlabel('uplift rate (mm/year)');
ylabel('along-strike position (km)');
