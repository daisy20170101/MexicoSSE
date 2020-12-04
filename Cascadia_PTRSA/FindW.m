%% calculate and plot W downdip distance for two models.
% need to use PlotVar.m
Nl = 1024; 
Nd = 384;
[x,y] = meshgrid(linspace(0,492,Nd),linspace(-700,400,Nl));

b2009 = load('b2009_ab_par_02.txt');

cc = reshape(b2009,Nl,Nd);

[nx,ny] = find(cc<0);

%%
for i = 1:length(nx)
    xnew(i) = x(nx(i),ny(i));
    ynew(i) = y(nx(i),ny(i));
%     snew(i) = slpmatrix(nx(i),ny(i));
end

%%
for i = -700+10:20:350-10
    y_low= i - 1;
    y_up = i + 1;
    dnum = find(ynew > y_low & ynew < y_up);
    
    if (length(dnum)>0)
    xq = xnew(dnum); 
    yq = ynew(dnum);
%     sq = snew(dnum);
%     dd = mean(sq);
    
    d1 = xq(2:end)-xq(1:end-1);
%     data = [yq(1),sum(d1),sum(d1)/10,dd];
    data = [yq(1),sum(d1),sum(d1)/10];

    save ./Parameter_b2009.txt -ascii -append data;
    end
end

%%
bb1 =load('./Parameter_gamma.txt');
bb =load('./Parameter_b2009.txt');

figure;
hold on; box on;
subplot(1,2,1);
hold on;box on;
set(gca,'fontsize',12,'ylim',[-700 400]);
plot(bb1(:,2),bb1(:,1),'-r');
plot(bb(:,2),bb(:,1),'-b');
xlabel('W (km)');
ylabel('Along-strike (km)');
legend('Model I', 'Model II');



