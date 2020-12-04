%% read from slipcos.data to plot snapshot of nucleation
Nl = 1024; 
Nd = 384;
xg = linspace(0,482,Nd);
yg = linspace(-700,400,Nl);
[x,y] = meshgrid(xg,yg);
nn = Nl*Nd; yrs = 365*24*3600;

% folder = strcat('./gamma_h15_phi_06/');
% appendix = strcat('-h15_phi_06');

% folder = strcat('./gamma_h15_lf36_to_trench/');
% appendix = strcat('-h15-lf36');
% lnum = 515;

% folder = strcat('./b2009_h15_hetero_02/');
% appendix = strcat('-h15_hetero_02');
% nnum = 7;
% lnum = ntime(nnum,2);
% outfig = strcat([folder,'slp_event',num2str(nnum),'.jpg']);
% outfile = strcat([folder,'slp_event',num2str(nnum),'.txt']);

% folder = strcat('./gamma_h15_lf36_to_trench/');
% appendix = strcat('-h15-lf36');
% lnum = 923;
% outfile = strcat([folder,'slp_event4.txt']);

folder = strcat('./b2009_h15_hetero_02_trench/');
nnum = 15;
infile = strcat([folder,'slp_event',num2str(nnum),'.txt']);
subfile = strcat([folder,'sub_h15_hetero_02_eve',num2str(nnum),'.txt']);
slp = load(infile); % coseismic slip


data = load(subfile);
ss = load('../contour/Subsidence.txt');
[sx,sy] = lonlat2km_rotate2(ss(:,2),ss(:,1));
[ns,ms] = sort(sy);

figure;
set(gcf,'position',[100 100  750 400]);

subplot(1,3,3);

hold on;box on;
set(gca,'fontsize',12,'ylim',[-700 400],'xlim',[-3,0.5]);

xlabel('subsidence (m)');
% ylabel('along-strike position (km)');

plot(data(:,2),data(:,1)+50,'^k','markerfacecolor','k');
plot(data(:,3),data(:,1)+50,'-^','markerfacecolor',[232 67 106]/255,'color',[232 67 106]/255);

errorbar(-ss(ms,3),ns+50,ns-ns,ns-ns,-ss(ms,5),ss(ms,5),'k');

% 3 stations without error bars
dnum = [6,16,17];
plot([-ss(6,4),-ss(6,3)],[sy(6),sy(6)]+50,'--k');
plot([-ss(16,4),-ss(16,3)],[sy(16),sy(16)]+50,'--k');
plot([-ss(17,4),-ss(17,3)],[sy(17),sy(17)]+50,'--k');

%%
vvel = reshape(slp,Nl,Nd);

smoothness = 50;
VVq = xyz2surface(x,y,vvel,xg,yg,smoothness);


subplot(1,3,[1,2]);
hold on;box on;

set(gca,'FontSize',12,'xlim',[0 492], 'ylim',[-700 400]);
h = colorbar;
h.Label.String = 'Slip (m)'; 
colormap(flipud(brewermap([],'RdYlBu')));
xlabel('downdip distance (km)');
ylabel('along-strike position (km)');

pcolor(x,y,VVq);

shading interp;


 