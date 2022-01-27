b_el=zeros(3,1);
K_el=zeros(3,3); % only one edge can contribute to K or b

%% for edge1
F_ed1=zeros(3,1);
l_nd1x=nd1x;    l_nd1y=nd1y;    l_nd2x=nd2x;    l_nd2y=nd2y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2); % edge length

for ji=1:1:Nline % integration sampling points
    ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
    xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
    yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
    wwLine=wwDuf*lLine;

    if edge_type(ed1in)==1
        Ez_ext=Ez_all(:,ngEl_ed1,tIn-1);
    else
        b1ng1=0; b2ng1=0; b3ng1=0; c1ng1=0; c2ng1=0; c3ng1=0; areatrng1=areatr;
        Ez_ext=[0 0 0];
    end
    Ez_int=Ez_all(:,ei,tIn-1);
    % nabla(Ez)=nabla(N1_ng)*Ez1_ng+nabla(N2_ng)*Ez2_ng+nabla(N3_ng)*Ez3_ng+nabla(N1)*Ez1+nabla(N2)*Ez2+nabla(N3)*Ez3
    nabla_Ez_x=0.5*(1/(2*areatrng1))*(b1ng1*Ez_ext(1)+b2ng1*Ez_ext(2)+b3ng1*Ez_ext(3))+0.5*(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
    nabla_Ez_y=0.5*(1/(2*areatrng1))*(c1ng1*Ez_ext(1)+c2ng1*Ez_ext(2)+c3ng1*Ez_ext(3))+0.5*(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));
    
    nabla_Ez_x_2=(1/(2*areatrng1))*(b1ng1*Ez_ext(1)+b2ng1*Ez_ext(2)+b3ng1*Ez_ext(3))-(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
    nabla_Ez_y_2=(1/(2*areatrng1))*(c1ng1*Ez_ext(1)+c2ng1*Ez_ext(2)+c3ng1*Ez_ext(3))-(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));
    
    % F = \int{nabla_Ez \dot \vec{n} * Ni dl}
    dot_product=(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
    dot_product_2=abs(nabla_Ez_x_2*ed1_n_x+nabla_Ez_y_2*ed1_n_y);
    F_ed1(1,1)=F_ed1(1,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    F_ed1(2,1)=F_ed1(2,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    F_ed1(3,1)=F_ed1(3,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
end

%% for edge2
F_ed2=zeros(3,1);
l_nd1x=nd2x;    l_nd1y=nd2y;    l_nd2x=nd3x;    l_nd2y=nd3y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2); % edge length

for ji=1:1:Nline % integration sampling points
    ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
    xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
    yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
    wwLine=wwDuf*lLine;
    
    if edge_type(ed2in)==1
        Ez_ext=Ez_all(:,ngEl_ed2,tIn-1);
    else
        Ez_ext=[0 0 0];
        b1ng2=0; b2ng2=0; b3ng2=0; c1ng2=0; c2ng2=0; c3ng2=0; areatrng2=areatr;
    end
    Ez_int=Ez_all(:,ei,tIn-1);
    % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
    nabla_Ez_x=0.5*(1/(2*areatrng2))*(b1ng2*Ez_ext(1)+b2ng2*Ez_ext(2)+b3ng2*Ez_ext(3))+0.5*(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
    nabla_Ez_y=0.5*(1/(2*areatrng2))*(c1ng2*Ez_ext(1)+c2ng2*Ez_ext(2)+c3ng2*Ez_ext(3))+0.5*(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));

    nabla_Ez_x_2=(1/(2*areatrng2))*(b1ng2*Ez_ext(1)+b2ng2*Ez_ext(2)+b3ng2*Ez_ext(3))-(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
    nabla_Ez_y_2=(1/(2*areatrng2))*(c1ng2*Ez_ext(1)+c2ng2*Ez_ext(2)+c3ng2*Ez_ext(3))-(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));

    % F = \int{nabla_Ez \dot \vec{n} Ni dl}
    dot_product=(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
    dot_product_2=abs(nabla_Ez_x_2*ed1_n_x+nabla_Ez_y_2*ed1_n_y);
    F_ed2(1,1)=F_ed2(1,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    F_ed2(2,1)=F_ed2(2,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    F_ed2(3,1)=F_ed2(3,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

end

%% for edge3
F_ed3=zeros(3,1);
l_nd1x=nd3x;    l_nd1y=nd3y;    l_nd2x=nd1x;    l_nd2y=nd1y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2); % edge length

for ji=1:1:Nline % integration sampling points
    ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
    xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
    yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
    wwLine=wwDuf*lLine;
    
    if edge_type(ed3in)==1
        Ez_ext=Ez_all(:,ngEl_ed3,tIn-1);
    else
        Ez_ext=[0 0 0];
        b1ng3=0; b2ng3=0; b3ng3=0; c1ng3=0; c2ng3=0; c3ng3=0; areatrng3=areatr;
    end
    Ez_int=Ez_all(:,ei,tIn-1);
    % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
    nabla_Ez_x=0.5*(1/(2*areatrng3))*(b1ng3*Ez_ext(1)+b2ng3*Ez_ext(2)+b3ng3*Ez_ext(3))+0.5*(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
    nabla_Ez_y=0.5*(1/(2*areatrng3))*(c1ng3*Ez_ext(1)+c2ng3*Ez_ext(2)+c3ng3*Ez_ext(3))+0.5*(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));

    nabla_Ez_x_2=(1/(2*areatrng3))*(b1ng3*Ez_ext(1)+b2ng3*Ez_ext(2)+b3ng3*Ez_ext(3))-(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
    nabla_Ez_y_2=(1/(2*areatrng3))*(c1ng3*Ez_ext(1)+c2ng3*Ez_ext(2)+c3ng3*Ez_ext(3))-(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));

    % F = \int{nabla_Ez \dot \vec{n} Ni dl}
    dot_product=(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
    dot_product_2=abs(nabla_Ez_x_2*ed1_n_x+nabla_Ez_y_2*ed1_n_y);
    F_ed3(1,1)=F_ed3(1,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    F_ed3(2,1)=F_ed3(2,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    F_ed3(3,1)=F_ed3(3,1)+wwLine*c0*c0*(dot_product)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

end