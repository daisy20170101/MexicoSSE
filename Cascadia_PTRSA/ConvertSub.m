%% 
ss = load('../contour/Subsidence.txt');
% long, lat: ss(:,2),ss(:,1);

data = load('../FaultLock/gamma_lock.txt'); % Fault locking - Schmidt 2012- Gamma

lon = data(:,2);
lat = data(:,1);
depth = data(:,3);
phi = data(:,4);

data_sub = zeros(length(ss(:,1)),4);

for i = 1:length(ss(:,1))
    delta = 0.1;
    num = find( data(:,1)> ss(i,2)-delta & data(:,1)< ss(i,2)+delta ...
        & data(:,2)> ss(i,1)-delta & data(:,2)< ss(i,1)+delta);
    
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

data_tide = load('tide_sta.txt');

[dx,dy] = lonlat2km_rotate2(data_tide(:,1),data_tide(:,2));

data_tide2 = [dx,dy,data_tide(:,3),data_tide(:,4)];

fit_gamma = load('../Cascadia_data/GammaLock_fit_2.txt');

tide_sta = zeros(size(data_sub));

for i = 1:length(data_tide(:,1))
    
    delta = 1.5;
    num = find( fit_gamma(:,2)> data_tide2(i,2)-1.5 & fit_gamma(:,2)< data_tide2(i,2)+1.5 ...
        & fit_gamma(:,4)> data_tide2(i,4)-0.01 & fit_gamma(:,4)< data_tide2(i,4)+0.01);
    
    tide_sta(i,:) = fit_gamma(num(1),:);
end

figure; hold on;

scatter(fit_gamma(:,1),fit_gamma(:,2),10,fit_gamma(:,4),'filled');
plot(tide_sta(:,1),tide_sta(:,2),'^c');
% plot(dx,dy,'^r');

save('subsidence_convt.txt','-ascii','tide_sta');

