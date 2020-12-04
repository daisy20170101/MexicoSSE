%% calculate and plot W downdip distance for two models.

ccab = -0.0035;
b =  0.01-ccab; 
mu = 0.3; 
nu = 0.25;
xLf = 99.9 ;
eff = 500 ;

h1 = 2*mu*b*xLf / (pi.*abs(ccab)^2*eff*(1-nu));
h2 = 2*mu*b*49.9 / (pi.*abs(ccab)^2*eff*(1-nu));
h3 = 2*mu*b*33.3 / (pi.*abs(ccab)^2*eff*(1-nu));


bb1 =load('./Parameter_gamma.txt');
bb =load('./Parameter_b2009.txt');

figure;
hold on; box on;

subplot(1,3,1);
hold on;box on;
set(gca,'fontsize',12,'ylim',[-700 400]);
plot(bb1(:,2)/h1,bb1(:,1),'-r');
% plot(bb(:,2)/h1,bb(:,1),'-b');
xlabel('W/h^* ');
ylabel('Along-strike (km)');
legend('Model I', 'Model II');


subplot(1,3,2);
hold on;box on;
set(gca,'fontsize',12,'ylim',[-700 400]);
plot(bb1(:,2)/h2,bb1(:,1),'-r');
% plot(bb(:,2)/h2,bb(:,1),'-b');
xlabel('W/h^* ');
ylabel('Along-strike (km)');
legend('Model I', 'Model II');

subplot(1,3,3);
hold on;box on;
set(gca,'fontsize',12,'ylim',[-700 400]);
plot(bb1(:,2)/h3,bb1(:,1),'-r');
% plot(bb(:,2)/h3,bb(:,1),'-b');
xlabel('W/h^* ');
ylabel('Along-strike (km)');
legend('Model I', 'Model II');