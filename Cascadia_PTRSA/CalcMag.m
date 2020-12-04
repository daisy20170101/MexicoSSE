%% calculate moment magnitude
% slp = load('./x1100d492_gamma0.5_2/gamma_1493.txt');

folder = strcat('./gamma_h20_hetero_Lf_2/');
filein = strcat([folder,'slp_event8.txt']); % M9.0
filein = strcat([folder,'slp_event13.txt']); % M8.9

% folder = strcat('./gamma_h20_hetero_Lf_third/');
% filein = strcat([folder,'slp_event4.txt']); % M8.9
% filein = strcat([folder,'slp_event2.txt']); % M8.9
% filein = strcat([folder,'slp_event1.txt']); % M9.0
% filein = strcat([folder,'slp_event10.txt']); % M9.2
% filein = strcat([folder,'slp_event9.txt']); % M9.1
% filein = strcat([folder,'slp_event5.txt']); % M8.9
% filein = strcat([folder,'slp_event7.txt']); % M8.9
% filein = strcat([folder,'slp_event12.txt']); % M9.1


% folder = strcat('./b2009_h15_hetero_02/');
% filein = strcat([folder,'slp_event1.txt']); % Mw9.2
% filein = strcat([folder,'slp_event2.txt']); % Mw8.7
% filein = strcat([folder,'slp_event7.txt']); % Mw9.2
slp = load(filein);

mu = 30e9; % shear modulus
area = 1.28 * 1.07e6; % m^2

slp_all = sum(slp);
mag = 2/3* log10(slp_all*area*mu*1e7)-10.7;
mag
