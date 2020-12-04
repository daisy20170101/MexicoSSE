%% plot inter- and co- seismic slip
% folder = strcat('./gamma_h15_phi_06/');
% folder = strcat('./gamma_h20/');
% folder = strcat('./gamma_h15_lf36_to_trench/');
trch = load('TrenchQuasi.txt');
[tx,ty]= lonlat2km_rotate2(trch(:,1),trch(:,2));
trch3 = load('TrenchQuasi_3term.txt');
[tx3,ty3]= lonlat2km_rotate2(trch3(:,1),trch3(:,2));

% folderin = strcat('/Volumes/seismology-1/MegaPlanar/gamma/gamma_h20_hetero_Lf/');
% folder = strcat('./gamma_h20_hetero_Lf/');
% appendix = strcat('-h20_phi_055');
% outfig = strcat([folder,'/','CumuSlip_T.jpg']);


% folderin = strcat('gamma_h20_hetero_Lf_third/');
% folder = strcat('./gamma_h20_hetero_Lf/');
% appendix = strcat('-h20_phi_055');
% outfig = strcat([folder,'/','CumuSlip_T.jpg']);

folderin = strcat('/Volumes/seismology-1/MegaPlanar/b2009/b2009_h15_hetero_02_trench/');
% folderin = strcat('b2009_h15_hetero_02_trench');
folder  =  strcat('b2009_h15_hetero_02_trench');
appendix = strcat('-h15_hetero_02');
outfig = strcat([folder,'/','CumuSlip_T.jpg']);

% folderin = strcat('/Volumes/seismology-1/MegaPlanar/gamma/gamma_h20/');
% folder  =  strcat('gamma_h20');
% appendix = strcat('-h20');
% outfig = strcat([folder,'/','CumuSlip_T.jpg']);

f2 = fopen([folderin,'/','slipz2-cos',appendix,'.dat'],'r');
t2 = load([folderin,'/','t-cos',appendix,'.dat']);

nn = 1024*384; 
ncos = length(t2);
% ncos = 1610; % gamma_h20_hetero_Lf_2/

Nl = 1024; 
Nd = 384;

data2 = textscan(f2,'%f %f\n', ncos*Nl);

z_cos2 = data2{1,2};
slp_cos = reshape(z_cos2,Nl,ncos);
xpos = linspace(-700,400,Nl);

%%
f4 = fopen([folderin,'/slipz2-inter',appendix,'.dat'],'r');
t4 = load([folderin,'/t-inter',appendix,'.dat']);

nint = length(t4);
data4 = textscan(f4,'%f %f\n', nint*Nl);

z_int2 = data4{1,2};
% nint = length(xx_int2)/Nl;

slp_int = reshape(z_int2,Nl,nint);
% nint = 100;

%%

figure(99);
subplot(1,3,[1,2]);
hold on;box on;

set(gca,'xlim',[-700 400],'ylim',[0 90]);
% subplot(1,2,1); box on;
xlabel('along-strike position(km)');
ylabel('cumulative slip (m)');

ii = 1;
jj = 1;

k = 0;
for i = ii:6:ncos
    k = k+1;
%     plot(xx_cos2(((i-1)*Nl+1):i*Nl),z_cos2(((i-1)*Nl+1):i*Nl),'-r');
    plot(xpos,slp_cos(:,i),'-','color',[232 67 106]/255);
    % save data 
%     data_coseis(((k-1)*Nl+1):k*Nl,1) = z_cos2(((i-1)*Nl+1):i*Nl) - z_int2(((jj-1)*Nl+1):jj*Nl) ; 
%     plot(xpos,data_coseis(((k-1)*Nl+1):k*Nl,1),'-r');
end

k = 0;
for i = jj:6:nint
    k = k+1;
%     plot(xx_int2(((i-1)*Nl+1):i*Nl),z_int2(((i-1)*Nl+1):i*Nl),'-b');
    plot(xpos,slp_int(:,i),'-','color',[67 106 232]/255);
%     data_inter(((k-1)*Nl+1):k*Nl,1) = z_int2(((i-1)*Nl+1):i*Nl) - z_int2(((jj-1)*Nl+1):jj*Nl) ;
%     plot(xpos,data_inter(((k-1)*Nl+1):k*Nl,1),'-b');
end

% plot(ty,ty-ty,'^k','markerfacecolor','k');
plot(ty3,ty3-ty3,'^','markerfacecolor',[64,64,64]/255);
plot([ty3(1),ty3(1)],[0,120],'--','linewidth',1.5,'color',[64,64,64]/255);
plot([ty3(2),ty3(2)],[0,120],'--','linewidth',1.5,'color',[64,64,64]/255);
plot([ty3(3),ty3(3)],[0,120],'--','linewidth',1.5,'color',[64,64,64]/255);

%% plot max velocity
maxv = load([folderin,'/','maxv',appendix,'.dat']);

subplot(1,3,3);
hold on; 
box on;

set(gca,'xlim',[0 10],'ylim',[0 1600],'xdir','reverse');
plot(maxv(1:10:end,2),maxv(1:10:end,1),'-k');

tt = zeros(length(maxv(:,1)),1)+5;

plot(tt,maxv(:,1),'--k');

xlabel('log_{10}(V_{max}/V_{pl}) ');
ylabel('time (year)');

saveas(gcf,outfig,'jpeg');

%% select event in north
figure; hold on; box on;

smax = slp_cos(700,:); % x=50 km
plot(t2,smax,'-k');
ylabel('slip (m)');
xlabel('time (yr)');

dsmax = smax(2:end)-smax(1:end-1);
dnum = find(dsmax>0.5);


