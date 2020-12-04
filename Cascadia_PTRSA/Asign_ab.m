%% mapping locking distribution from Schmazle et al. 2014 onto the fault.
% data = load('../Cascadia_data/GammaLock_fit_2.txt');
% fileout = 'gamma_ab_par_055.txt';

% or mapping locking distribution from Burgette 2009 onto the fault.
data = load('../Cascadia_data/Burgette2009_fit_2.txt');
fileout = 'b2009_ab_par_02.txt';

dip_angle = 13; % slab dipping angle

x = data(:,1);
y = data(:,2);
z = data(:,1)*tand(dip_angle);
lock = data(:,4);
%% converting locking into a-b; to set 0.2 as downdip limit.

phi = 0.2;
ab_par = -(lock-phi)*0.0035/(1-phi);

dnum = find(ab_par > 0); % cut ab to between -0.0035 and 0.0035;
ab_par(dnum) = 4.0 *ab_par(dnum);
dnum = find(ab_par > 0.0035); % cut ab to between -0.0035 and 0.0035;
ab_par(dnum) = 0.0035;
dnum = find(ab_par<-0.0035);
ab_par(dnum) = -0.0035;

save(fileout, '-ascii', 'ab_par');

%% plot ccab
figure; 
hold on; 
box on;

set(gca,'FontSize',12,'xlim',[0 492],'ylim',[-700  400]);
scatter(x,y,20,ab_par,'filled'); 
caxis([ -0.0035 0.0035]);
colormap(flipud(brewermap([],'RdYlBu')));

colorbar;

% data1 = load('ab_dist_2020.txt');
% scatter(data1(:,1),data1(:,2),10,data1(:,4),'filled');

%%
% abt=load('../TremorLoc/abcontour_top_planar.txt');
% abb=load('../TremorLoc/abcontour_bot_planar.txt');
% plot(abt(:,1),abt(:,2),'-r');
% plot(abb(:,1),abb(:,2),'-r');

