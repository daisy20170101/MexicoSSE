%% read from slipcos.data to plot snapshot of nucleation
Nl = 1024; 
Nd = 384;
[x,y] = meshgrid(linspace(0,482,Nd),linspace(-700,400,Nl));
nn = Nl*Nd; yrs = 365*24*3600;

% folderin= strcat('/Volumes/seismology-1/MegaPlanar/b2009/b2009_h15_hetero_02/');
% folder = strcat('./b2009_h15_hetero_02/');
% appendix = strcat('-h15_hetero_02');
% outfile = strcat([folder,'slp_inter_1700.txt']);
% outfig = strcat([folder,'slp_inter_1700.jpg']);

folderin= strcat('/Volumes/seismology-1/MegaPlanar/b2009/b2009_h15_hetero_02_trench/');
folder = strcat('./b2009_h15_hetero_02_trench/');
appendix = strcat('-h15_hetero_02');
outfile = strcat([folder,'slp_inter_200.txt']);
outfig = strcat([folder,'slp_inter_200.jpg']);

% folderin= strcat('/Volumes/seismology-1/MegaPlanar/gamma/gamma_h20_hetero_Lf_third/');
% folder = strcat('./gamma_h20_hetero_Lf_third/');
% appendix = strcat('-h20_phi_055');
% outfile = strcat([folder,'slp_inter_100.txt']);
% outfig = strcat([folder,'slp_inter_100.jpg']);

lnum = 20;
f1 = fopen([folderin,'slipz1_int_200.bin']);
vel = fread(f1,nn*lnum,'float32');
vel = vel-3 ;

fclose('all');  
% clear vel5 vel6;
tfile = load([folderin,'t-inter',appendix,'.dat']);
tsub = tfile(40:end);
dt = tsub(2:end)-tsub(1:end-1);

%% % % plot movie

slp = zeros(size(Nl*Nd,1));

for  i = 1:1:20-2
    
     vcos = 0.5*10.^vel((i-1)*nn+1:i*nn) + 0.5*10.^vel((i)*nn+1:i*nn+nn);
     slp = slp + vcos*dt(i) ;

end

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
caxis([0 4]);

shading interp;
save(outfile,'-ascii','slp');
saveas(gcf,outfig,'jpeg');
 