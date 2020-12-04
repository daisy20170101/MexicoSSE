%% convert tidal station of Yousefi et al. 2018 into planar model
%% writen by  D. Li. Sep. 2020

% ss = load('Tidal_Yousefi_sub.txt');
ss = load('./Yousefi/aver_loc_coast.txt');
% lat long 20th-uplift-rate,21st-uplift-rate;

data = load('../FaultLock/gamma_lock.txt'); % Fault locking - Schmidt 2012- Gamma
% lat, long, depth, locking coeff.

lon = data(:,2);
lat = data(:,1);
depth = data(:,3);
phi = data(:,4);

data_sub = zeros(length(ss(:,1)),4);

for i = 1:length(ss(:,1))
    
    delta = 0.15; 
    num = find( data(:,1)> ss(i,3)-delta & data(:,1)< ss(i,3)+delta ...
        & data(:,2)> ss(i,2)-delta & data(:,2)< ss(i,2)+delta);
    
    data_sub(i,:) = data(num(1),:);
end

figure; hold on;
scatter(lat,lon,10,phi,'filled');
plot(data_sub(:,1),data_sub(:,2),'r^','markerfacecolor','r');

%% convert tidal stations to planar fault model.
% rotate stations to trench-parall and trench-normal coord. 
% for each station get the corresponding on-fault point based on the same
% locking coeff. 
% use the converted station for calculating tidal subsidence.

[dx,dy] = lonlat2km_rotate2(data_sub(:,1),data_sub(:,2));

data_tide2 = [dx,dy,data_sub(:,3),data_sub(:,4)];

fit_gamma = load('../Cascadia_data/GammaLock_fit_2.txt');

tide_sta = zeros(size(data_sub));

for i = 1:length(data_tide2(:,1))
    
    delta = 1.5;
    num = find( fit_gamma(:,2)> data_tide2(i,2)-1.5 & fit_gamma(:,2)< data_tide2(i,2)+1.5 ...
     & fit_gamma(:,4)> data_tide2(i,4)-0.005 & fit_gamma(:,4)< data_tide2(i,4)+0.005);
    
    tide_sta(i,:) = fit_gamma(num(1),:);
end

%% plot
data = load('subsidence_convt.txt');

figure; hold on;

scatter(fit_gamma(:,1),fit_gamma(:,2),10,fit_gamma(:,4),'filled');
plot(tide_sta(:,1),tide_sta(:,2),'^c','markerfacecolor','c');
plot(data(:,1),data(:,2),'^r','markerfacecolor','r');

colormap(flipud(brewermap([],'RdYlBu')));

save('Yousefi_convt2.txt','-ascii','tide_sta');

