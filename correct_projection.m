M1=max(W,[],3);
M2=min(W,[],3);
M3=max(interpolated_vel_abs,[],3);
figure;pcolor(xq,yq,M1);shading flat;caxis([-10 10])
figure;pcolor(xq,yq,M2);shading flat;caxis([-10 10])
figure;pcolor(xq,yq,M3);shading flat;caxis([-20 60]);colormap(jet(80))
hold on
quiver(xq,yq,NEW_vel_x(:,:,15),NEW_vel_y(:,:,15))
%% 


load('LAR190710184511.RAWJ8GF.mat', 'xq')
load('LAR190710184511.RAWJ8GF.mat', 'yq')
xqor=xq;
yqor=yq;
load('LAR190710190012.RAWJ8GR.mat')

for i=1:56
interpolated_dbz2(:,:,i)=interp2(xq,yq,interpolated_dbz(:,:,i),xqor,yqor);
interpolated_vel2(:,:,i)=interp2(xq,yq,interpolated_vel(:,:,i),xqor,yqor);
interpolated_vel_abs2(:,:,i)=interp2(xq,yq,interpolated_vel_abs(:,:,i),xqor,yqor);
end

interpolated_vel_abs=interpolated_vel_abs2;
interpolated_vel=interpolated_vel2;
interpolated_dbz=interpolated_dbz2;
load('LAR190710184511.RAWJ8GF.mat', 'xq')
load('LAR190710184511.RAWJ8GF.mat', 'yq')
clearvars i interpolated_vel_abs2  interpolated_vel2 interpolated_dbz2