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

% folder = strcat('./b2009_h15_hetero_02_trench/');
% outfile = strcat([folder,'sub_Uplift_65.txt']);
% outfig = strcat([folder,'Uplift_65.jpg']);
% slp = load([folder,'slp_inter_65.txt']);

folder = strcat('./gamma_h20_hetero_Lf_third/');
outfile = strcat([folder,'sub_uplift_1200.txt']);
outfig = strcat([folder,'Uplift_1200.jpg']);
slp  = load([folder,'slp_inter_1200.txt']);

% ss = load('Tidal_Yousefi_sub.txt');

data_tide = load('Yousefi/Yousefi_convt2.txt');
sy = data_tide(:,2); % trench-parallel postion 
sx = data_tide(:,1)*cosd(13); % horizontal position
data_aver = load('Yousefi/aver_loc_coast.txt');

% [x,y] = meshgrid(linspace(-170,322,Nd),linspace(-700,400,Nl));
[x,y] = meshgrid(linspace(0,482,Nd),linspace(-700,400,Nl));
Z = x*sind(13);

vv1 = reshape(slp,Nl,Nd);  % reshape slp array to metrix
 
%% calculation
% vv1 = vvel;
distx = zeros(length(sx),1); disty= distx; distz= distx;
[ii,jj,v] = find(vv1 > 0.5);

tic;
parfor k = 1:length(ii)
     i = ii(k); 
     j = jj(k);
      e = sx - x(i,j);
      n = sy - y(i,j); 
      [uE,uN,uZ] = okada85(e,n,-Z(i,j),strike,dip,ll,ww,90,vv1(i,j)/1000,0)     
      distz = distz + uZ;
      distx = distx + uE;
      disty = disty + uN;
end
toc;

data = [sy,distz*1000/100]; % data = [sy,distz*ww*1000]; ?? % in m
save(outfile, '-ascii', 'data');

%%
data = load(outfile);

% ss = load('../contour/Subsidence.txt');
% [sx,sy] = lonlat2km_rotate2(ss(:,2),ss(:,1));
% [ns,ms] = sort(sy);

figure; 
hold on;
box on;

% set(gca,'fontsize',12,'ylim',[-700 400]);
set(gca,'xdir','reverse');
set(gcf,'position',[100 200 400 250]);
ylabel('uplift rate (mm/year)');
xlabel('along-strike position (km)');

% plot(data(:,2)*1000,data(:,1)+200,'-^','markerfacecolor',[232 67 106]/255,'color',[232 67 106]/255);
plot(data_aver(:,2),data(:,2)*1000,'-^','markerfacecolor',[232 67 106]/255,'color',[232 67 106]/255);

saveas(gcf,outfig,'jpeg');
