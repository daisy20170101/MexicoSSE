%% plot variables in the planar fault 
% var = load('./x1100d492_sse/vardep-h20-lf12_5.dat');
% folder = strcat('./gamma_h15_phi_06/');
% appendix = strcat('-h15_phi_06');

% folder = strcat('./gamma_h20/');
% appendix = strcat('-h20');

% folder = strcat('/Volumes/seismology-1/MegaPlanar/b2009/b2009_h20_hetero_02_trench/');
folder = strcat('b2009_h20_hetero_02_trench/');
appendix = strcat('-h15_hetero_02');

% folder = strcat('/Volumes/seismology-1/MegaPlanar/gamma/gamma_h20_hetero_Lf_third/');
% appendix = strcat('-h20_phi_055');

var = load([folder,'vardep',appendix,'.dat']);
% var  = load('b2009_ab_par_02.txt');
ccab = var(:,4); % a-b
cclf = var(:,3); % Lf
ccef = var(:,2); % eff. normal stress

%%
Nl = 1024; Nd = 384;
y = linspace(-700,400,Nl); 
ll = linspace(0, 492,Nd);
x = ll*cosd(13);
z = ll*sind(13);
[xx,yy] = meshgrid(x,y);

cc = reshape(ccef,Nl,Nd);

%%
figure; 
hold on; box on;
set(gcf,'position',[100 100 300 300]);
set(gca,'FontSize',12,'xlim',[0 50], 'ylim',[-700 400]);
% scatter(xx(:),yy(:),20,Lf);
pcolor(x*cosd(13),y,cc);
colormap(flipud(brewermap([],'RdYlBu')));

shading interp;
h = colorbar; 
% h.Limits =[-0.0035 0.0035];
% caxis([-0.0035 0.0035]);
% caxis([36 150]);

% caxis([36, 77]);
% plot(x10,y10,'-.w');
% plot(x20,y20,'-.w');
% plot(x30,y30,'-.w');
% plot(x40,y40,'-.w');
% plot(x3,y3,'-.w','linewidth',2);
% plot(x50,y50,'-.w');