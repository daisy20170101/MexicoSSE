%% load observation vector
dip = 13; 
strike = 0;
Nd = 384; 
Nl= 1024; 
ll = 1100/Nl; 
ww = 492/Nd;

% folder = strcat('./gamma_h15_lf36_to_trench/'); % phi=0.5
% folder = strcat('./gamma_h15_phi_06/'); % phi = 0.6
% folder = strcat('./gamma_h20/'); % phi=0.5
% folder = strcat('./gamma_h20_hetero_Lf/');
folder = strcat('./b2009_h15_hetero_02_trench/');

nnum = 6 ;
outfile = strcat([folder,'sub_h15_hetero_02_eve',num2str(nnum),'.txt']);
outfig = strcat([folder,'sub_eve',num2str(nnum),'.jpg']);
slp  = load([folder,'slp_event',num2str(nnum),'.txt']);

% folder = strcat('./b2009_h15_hetero_02/'); % phi = 0.2
% outfile = strcat([folder,'sub_b2009_h15_hetero_02_eve27.txt']);
% outfig = strcat([folder,'sub_eve2.jpg']);
% slp  = load([folder,'slp_event2.txt']);

ss = load('../contour/Subsidence.txt');

data_tide = load('subsidence_convt.txt');
sy = data_tide(:,2) + 50; % trench-parallel postion 
sx = data_tide(:,1)*cosd(13); % horizontal position

[ns,ms] = sort(sy);

[x,y] = meshgrid(linspace(0,482,Nd),linspace(-700,400,Nl));
Z = x*sind(13);
% Z = load('../contour/depth3D.txt');

vv1 = reshape(slp,Nl,Nd);

%% calculation
% vv1 = vvel;
distx = zeros(length(sx),1); disty= distx; distz= distx;

[ii,jj,v] = find(vv1 > 1.0);

tic;
parfor k = 1:length(ii)
     i = ii(k); j = jj(k);
      e = sx - x(i,j);
      n = sy - y(i,j); 
      [uE,uN,uZ] = okada85(e,n,-Z(i,j),strike,dip,ll,ww,90,vv1(i,j)/1000,0)     
      distz = distz + uZ;
      distx = distx + uE;
      disty = disty + uN;
end
toc;

%% Plot subsidence data wiht observations from Wang 2013.

data = [ns, -ss(ms,3),distz(ms)*1000];
save(outfile, '-ascii', 'data');

data = load(outfile);

ss = load('../contour/Subsidence.txt');
[sx,sy] = lonlat2km_rotate2(ss(:,2),ss(:,1));
[ns,ms] = sort(sy);

figure; 
hold on;box on;
set(gca,'fontsize',12,'ylim',[-700 400],'xlim',[-3,0.5]);
set(gcf,'position',[100 200 250 400]);
xlabel('subsidence (m)');
ylabel('along-strike position (km)');

plot(data(:,2),data(:,1)+50,'^k','markerfacecolor','k');
plot(data(:,3),data(:,1)+50,'-^','markerfacecolor',[232 67 106]/255,'color',[232 67 106]/255);

errorbar(-ss(ms,3),ns+50,ns-ns,ns-ns,-ss(ms,5),ss(ms,5),'k');

% 3 stations without error bars
dnum = [6,16,17];
plot([-ss(6,4),-ss(6,3)],[sy(6),sy(6)]+50,'--k');
plot([-ss(16,4),-ss(16,3)],[sy(16),sy(16)]+50,'--k');
plot([-ss(17,4),-ss(17,3)],[sy(17),sy(17)]+50,'--k');

saveas(gcf,outfig,'jpeg');



