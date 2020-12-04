%% read from slipcos.data to plot snapshot of nucleation
Nl = 1024; 
Nd = 384;
[x,y] = meshgrid(linspace(0,492,Nd),linspace(-700,400,Nl));

nn = Nl*Nd; 
yrs = 365*24*3600;

% folder = strcat('./gamma_h15_lf36_to_trench/');
% appendix = strcat('-h15-lf36');
% lnum = 923;

% folder = strcat('./gamma_h20/');
% appendix = strcat('-h20');
% lnum = 1187;

folder = strcat('./gamma_h20_hetero_Lf_2/');
appendix = strcat('-h20_phi_055');

% folder = strcat('./b2009_h15_hetero/');
% appendix = strcat('-h15_hetero');

tfile = load([folder,'/t-inter',appendix,'.dat']);
dt = tfile(2:end)-tfile(1:end-1);
lnum = 300;

f1 = fopen([folder,'/slipz1_inter','.bin']);
vel_b2009 = fread(f1,nn*lnum,'float32');

fclose('all'); 

%% % % plot movie
vidObj = VideoWriter([folder,'Movie_inter',1,'.avi'],'Motion JPEG AVI');
vidObj.FrameRate = 4;
vidObj.Quality = 50;
open(vidObj);
vvel = zeros(Nl,Nd);

for  i = 1:1:20
    i
    figure(999);
    hold on;box on;
    set(gcf,'position',[100 100  600 500]);
    set(gca,'FontSize',12,'xlim',[0 492], 'ylim',[-700 400]);
    colormap(flipud(brewermap([],'RdYlBu')));
    h = colorbar;
    h.Label.String = 'Log(V) (m/s)';

    vcos = vel_b2009((i-1)*nn+1:i*nn);

    for j = 1:Nd
        for k=1:Nl
            vvel(k,j) = vcos(j*Nl-Nl+k);
        end
    end

    pcolor(x,y,vvel);
%     caxis([-12 0]);
%     h.Limits = [-11 0];

    shading interp;

    title([num2str(tfile(i)),' yr'],'FontSize',12);
    cpos=h.Position; 
    ax = gca;
    axpos=ax.Position; 
    ax.Position = axpos;  cpos(3)=0.5*cpos(3);  h.Position=cpos;

    frame = getframe(gcf);
    writeVideo(vidObj,frame);
    close(999);
end
 close(vidObj);
