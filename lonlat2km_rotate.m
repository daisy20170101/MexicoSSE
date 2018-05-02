%% convert depth contours of McCrory 2006.
%% this is to rotate coordinates
function [xr,yr]=lonlat2km_rotate(lon,lat)
% lon0 lat0 reference center
lon0=-126;
lat0= 46;

R = 6371/180*pi;
[arc,azi]=distance(lat0,lon0,lat,lon);
xaa=R*arc.*sin(azi/180*pi);
yaa=R*arc.*cos(azi/180*pi);
x=xaa;
y=yaa;

% rotation angle and center.
theta = 40;
x0 = -9.667;
y0 = 165.3;

x=x-x0;
y=y-y0;
xr = x*cos(theta/180*pi)+y*sin(theta/180*pi);
yr = y*cos(theta/180*pi)-x*sin(theta/180*pi);
clear x y x0 y0;
end
