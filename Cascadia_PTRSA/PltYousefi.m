% plot Yousefi et al. 2018
figure(2);
subplot(1,2,1);
set(gcf,'position',[100 100 750 350]);

hold on; 
box on; 
set(gca,'fontsize',12,'xlim',[-128.5 -121.5],'ylim',[40.0 49.5]);

ss = load('../contour/Subsidence.txt');
tt = load('Tidal_Yousefi_sub.txt');

mapshow(ncst(:,1),ncst(:,2),'color','k','linewidth',0.5);

plot(cc3(:,1),cc3(:,2),'-k','linewidth',2);
plot(cc10(:,1),cc10(:,2),'-.k','linewidth',1);
plot(cc20(:,1),cc20(:,2),'-.k','linewidth',1);
plot(cc30(:,1),cc30(:,2),'-.k','linewidth',1);
plot(cc40(:,1),cc40(:,2),'-.k','linewidth',1);
plot(cc50(:,1),cc50(:,2),'-.k','linewidth',1);
% plot(cc(:,2),cc(:,1),'sk','markerfacecolor','k');

plot(ss(:,2),ss(:,1),'^','markerfacecolor',[232 67 106]/255,'markeredgecolor','none');
plot(tt(:,2),tt(:,1),'^','markerfacecolor',[67 106 232]/255,'markeredgecolor','none');

subplot(1,2,2);
hold on;
plot(tt(:,4),tt(:,1),'^-r');
