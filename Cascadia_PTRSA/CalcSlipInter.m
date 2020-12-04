%% read from slipcos.data to plot snapshot of nucleation
Nl = 1024; 
Nd = 384;
[x,y] = meshgrid(linspace(0,482,Nd),linspace(-700,400,Nl));
nn = Nl*Nd; yrs = 365*24*3600;

folder = strcat('./gamma_h20_hetero_Lf_2/');
appendix = strcat('-h20_phi_055');
outfile = strcat([folder,'slp_inter1.txt']);
outfig = strcat([folder,'slp_inter1.jpg']);

lnum = 300;
f1 = fopen([folder,'slipz1_inter.bin']);
slip = fread(f1,nn*lnum,'float32');

fclose('all');  
% clear vel5 vel6;
tfile = load([folder,'t-inter',appendix,'.dat']);


%% % % plot movie

slp = zeros(size(Nl*Nd,1));

ib = 202; % 20*5 = 100 yr
ie = 222; 

ib = 1; % 20*5 = 100 yr
ie = 21; 

slp = slip((ie-1)*nn+1:ie*nn) - slip((ib-1)*nn+1:ib*nn) ;

vvel = reshape(slp,Nl,Nd);


%%
% ss = load('../contour/Subsidence.txt');
% [sx,sy] = lonlat2km(ss(:,2),ss(:,1));
% % sx = sx/cosd(13);

figure(999);
hold on;box on;

set(gcf,'position',[100 100  600 500]);
set(gca,'FontSize',12,'xlim',[0 492], 'ylim',[-700 400]);
h = colorbar;
h.Label.String = 'Slip (m)'; 
colormap(flipud(brewermap([],'RdYlBu')));
xlabel('downdip distance (km)');
ylabel('along-strike position (km)');

pcolor(x,y,vvel);

shading interp;
save(outfile,'-ascii','slp');
saveas(gcf,outfig,'jpeg');
 