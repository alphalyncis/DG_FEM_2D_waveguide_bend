Z=zeros(Nnodes,1);
% figure('pos',[50 50 850 850]);
% subplot(2,2,1);
colormap(jet);
h=trisurf(elements,nodes(:,1),nodes(:,2),Z,Ez_el(:,tIn));
h.LineStyle='none';
h.CDataMapping='scaled';
%caxis([0 ceil(max(Ez_el(:,1)))]);
caxis([-337 337]);
c=colorbar('East','FontSize',14);
set(gca,'fontsize', 12);
set(gca,'linewidth',2);
view(0,90);
xlabel('x [m]');
ylabel('y [m]'); daspect([1 1 1 ]);
title(['Ez, t=',num2str(dt*(tIn-1))]);