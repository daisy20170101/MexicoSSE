%% load observation vector
dip = 13; 
strike = 0;
Nd = 384; 
Nl= 1024; 
ll = 1100/Nl; 
ww = 492/Nd;

folder = strcat('./b2009_h15_hetero_02_trench/');
outfig = strcat([folder,'Locking65.jpg']);
slp = load([folder,'slp_inter_65.txt']);

folder = strcat('./gamma_h20_hetero_Lf_third/');
outfig = strcat([folder,'Locking_100.jpg']);
slp  = load([folder,'slp_inter_100.txt']);
dur = 90;

[x,y] = meshgrid(linspace(0,482,Nd),linspace(-700,400,Nl));

slp_int = reshape(slp,Nl,Nd);

%% calculation
figure; 
hold on;
box on;

set(gca,'fontsize',12,'ylim',[-700 400],'xlim',[0 492]);
set(gcf,'position',[100 200 400 500]);

locking = (0.041*dur - slp_int) / (0.041*dur);

pcolor(x,y,locking);
shading interp;
colormap(flipud(brewermap([],'RdYlBu')));

caxis([0 1]);
h = colorbar;
h.Label.String = 'Fault locking coefficient'; 
xlabel('downdip distance (km)');
ylabel('along-strike position (km)');

saveas(gcf,outfig,'jpeg');
