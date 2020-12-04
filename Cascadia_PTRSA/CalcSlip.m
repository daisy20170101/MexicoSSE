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

% folderin = strcat('/Volumes/seismology-1/MegaPlanar/gamma/gamma_h20_hetero_Lf_third/');
% folder = strcat('./gamma_h20_hetero_Lf_third/');
% appendix = strcat('-h20_phi_055');

folderin= strcat('/Volumes/seismology-1/MegaPlanar/b2009/b2009_h15_hetero_02_trench/');
folder = strcat('./b2009_h15_hetero_02_trench/');
appendix = strcat('-h15_hetero_02');

folderin= strcat('/Volumes/seismology-1/MegaPlanar/gamma/gamma_h20/');
folder = strcat('./gamma_h20/');
appendix = strcat('-h20');

nnum = 5;
lnum = ntime(nnum,2);
outfile = strcat([folder,'slp_event',num2str(nnum),'.txt']);
outfig = strcat([folder,'slp_event',num2str(nnum),'.jpg']);

% f1 = fopen([folderin,'slipz1_cos',num2str(nnum),'.bin']);
f1 = fopen([folderin,'slipz1_cos5','.bin']);
vel = fread(f1,nn*lnum,'float32');
vel = vel -log10(yrs)-3 ;

fclose('all');  
% clear vel5 vel6;
tfile = load([folderin,'t-cos',appendix,'.dat']);
tsub = tfile(ntime(nnum,1):end);
dt = tsub(2:end)-tsub(1:end-1);
dt = dt*yrs;

% lnum = floor(lnum/6);
%% % % plot movie

slp = zeros(size(Nl*Nd,1));

for  i = 2:1:lnum-2
    
%     vcos = 10.^vel((i-1)*nn+1:i*nn);
 vcos = 0.5*10.^vel((i-1)*nn+1:i*nn) + 0.5*10.^vel((i)*nn+1:i*nn+nn);
 slp = slp + vcos*dt(i) ;

end


vvel = reshape(slp,Nl,Nd);

% VVq = interp2(x,y,vvel,x+10,y+10,'nearest');
smoothness = 50;
VVq = xyz2surface(x,y,vvel,xg,yg,smoothness);

%%
% ss = load('../contour/Subsidence.txt');
% [sx,sy] = lonlat2km(ss(:,2),ss(:,1));
% % sx = sx/cosd(13);

figure;
hold on;box on;

set(gcf,'position',[100 100  600 500]);
set(gca,'FontSize',12,'xlim',[0 492], 'ylim',[-700 400]);
h = colorbar;
h.Label.String = 'Slip (m)'; 
colormap(flipud(brewermap([],'RdYlBu')));
xlabel('downdip distance (km)');
ylabel('along-strike position (km)');

pcolor(x,y,VVq);
% scatter(x(:),y(:),10,slp(:),'filled');
% plot(sx,sy,'s-c');
caxis([0 20]);

shading interp;
save(outfile,'-ascii','slp');
saveas(gcf,outfig,'jpeg');
 