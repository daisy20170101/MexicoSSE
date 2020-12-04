% ccab = load('gamma_ab_par_phi_055.txt');
% fault = load('../Cascadia_data/GammaLock_fit_2.txt');

ccab = load('b2009_ab_par_02.txt');
fault = load('../Cascadia_data/Burgette2009_fit_2.txt');

b =  0.01-ccab; 
mu = 0.3; 
nu = 0.25;
x = fault(:,1);
y = fault(:,2);

h = x-x+ 20; % hstar = 15;

% xLf =  h .* pi.*0.0035^2*500*(1-nu)/2/mu/0.0135;
xLf = h-h+ 99.77*0.75*0.8;

for i = 1:length(x)
   if y(i) > -800 && y(i)< 200
   xLf(i)= xLf(i)/3;
   end
end
save b2009_Lf_par_third.txt -ascii xLf;
 
%%
figure; hold on; box on;
scatter(x,y,20,xLf,'filled');
