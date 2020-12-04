% plot gamma shape

gamma = 0.2;

x = 0:0.05:1;
y1 = (exp(-x/gamma)-exp(-1/gamma))/(1-exp(-1/gamma));

figure; hold on; box on;

plot(x*100,y,'-k');


