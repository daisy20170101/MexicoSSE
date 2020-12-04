%% load observation vector

ss = load('../contour/Subsidence.txt');
[sx,sy] = lonlat2km_rotate2(ss(:,2),ss(:,1));
[ns,ms] = sort(sy);

sy = ss(ms,1); % plot latitude

figure; 
hold on;box on;
set(gca,'fontsize',12,'ylim',[40 49.5],'xlim',[-3,0.5]);
set(gcf,'position',[100 200 250 350]);
xlabel('subsidence (m)');
ylabel('along-strike position (km)');

plot(-ss(ms,3),sy,'^k','markerfacecolor','k','markersize',6);
errorbar(-ss(ms,3),sy,ns-ns,ns-ns,-ss(ms,5),ss(ms,5),'k');

% 3 stations without error bars
dnum = [6,16,17];
plot([-ss(6,4),-ss(6,3)],[ss(6,1),ss(6,1)],'--k');
plot([-ss(16,4),-ss(16,3)],[ss(16,1),ss(16,1)],'--k');
plot([-ss(17,4),-ss(17,3)],[ss(17,1),ss(17,1)],'--k');

% saveas(gcf,outfig,'jpeg');



