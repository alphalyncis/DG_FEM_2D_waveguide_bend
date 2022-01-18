temp_u=zeros(3,1);

% for edge1
K1_e1=zeros(3,1); K2_e1=zeros(3,1);
l_nd1x=nd1x;    l_nd1y=nd1y;    l_nd2x=nd2x;    l_nd2y=nd2y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2); % edge length
for ji=1:1:Nline % integration sampling points
    ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
    xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
    yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
    wwLine=wwDuf*lLine;
    
    % calc field value of current element (from the 3 edge centers?
    c0_pnt=(1/(2*areatr))*(u_allRK(1,ei,tIn-1)*(a1+b1*xLine+c1*yLine)+u_allRK(2,ei,tIn-1)*(a2+b2*xLine+c2*yLine)+u_allRK(3,ei,tIn-1)*(a3+b3*xLine+c3*yLine));    
    c0_ng=c0_pnt;
    if ed1_cond==1 % if this edge has a neighbour element
        % calc field value of its neighbour element
        c0_ng=(1/(2*areatrng1))*(u_allRK(1,ngEl_ed1,tIn-1)*(a1ng1+b1ng1*xLine+c1ng1*yLine)+u_allRK(2,ngEl_ed1,tIn-1)*(a2ng1+b2ng1*xLine+c2ng1*yLine)+u_allRK(3,ngEl_ed1,tIn-1)*(a3ng1+b3ng1*xLine+c3ng1*yLine));
    end
    % evaluate the integration with field contribution from this&neighbour
    % K1 = {{field}} * edge_normal_vector \dot r_vec * shape function
    K1_e1(1,1)=K1_e1(1,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed1_n_x*yLine+ed1_n_y*xLine)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    K1_e1(2,1)=K1_e1(2,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed1_n_x*yLine+ed1_n_y*xLine)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    K1_e1(3,1)=K1_e1(3,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed1_n_x*yLine+ed1_n_y*xLine)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

    % K2 = [[field]] * |edge_normal_vector \dot r_vec| * shape function
    K2_e1(1,1)=K2_e1(1,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed1_n_x*yLine+ed1_n_y*xLine)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    K2_e1(2,1)=K2_e1(2,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed1_n_x*yLine+ed1_n_y*xLine)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    K2_e1(3,1)=K2_e1(3,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed1_n_x*yLine+ed1_n_y*xLine)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
end

% for edge2
K1_e2=zeros(3,1); K2_e2=zeros(3,1);
l_nd1x=nd2x;    l_nd1y=nd2y;    l_nd2x=nd3x;    l_nd2y=nd3y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2);
for ji=1:1:Nline
    ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
    xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
    yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
    wwLine=wwDuf*lLine;
    
    c0_pnt=(1/(2*areatr))*(u_allRK(1,ei,tIn-1)*(a1+b1*xLine+c1*yLine)+u_allRK(2,ei,tIn-1)*(a2+b2*xLine+c2*yLine)+u_allRK(3,ei,tIn-1)*(a3+b3*xLine+c3*yLine));
    c0_ng=c0_pnt;
    if ed2_cond==1
        c0_ng=(1/(2*areatrng2))*(u_allRK(1,ngEl_ed2,tIn-1)*(a1ng2+b1ng2*xLine+c1ng2*yLine)+u_allRK(2,ngEl_ed2,tIn-1)*(a2ng2+b2ng2*xLine+c2ng2*yLine)+u_allRK(3,ngEl_ed2,tIn-1)*(a3ng2+b3ng2*xLine+c3ng2*yLine));
    end
    K1_e2(1,1)=K1_e2(1,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed2_n_x*yLine+ed2_n_y*xLine)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    K1_e2(2,1)=K1_e2(2,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed2_n_x*yLine+ed2_n_y*xLine)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    K1_e2(3,1)=K1_e2(3,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed2_n_x*yLine+ed2_n_y*xLine)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

    K2_e2(1,1)=K2_e2(1,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed2_n_x*yLine+ed2_n_y*xLine)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    K2_e2(2,1)=K2_e2(2,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed2_n_x*yLine+ed2_n_y*xLine)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    K2_e2(3,1)=K2_e2(3,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed2_n_x*yLine+ed2_n_y*xLine)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
end

% for edge3
K1_e3=zeros(3,1); K2_e3=zeros(3,1);
l_nd1x=nd3x;    l_nd1y=nd3y;    l_nd2x=nd1x;    l_nd2y=nd1y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2);
for ji=1:1:Nline
    ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
    xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
    yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
    wwLine=wwDuf*lLine;
    
    c0_pnt=(1/(2*areatr))*(u_allRK(1,ei,tIn-1)*(a1+b1*xLine+c1*yLine)+u_allRK(2,ei,tIn-1)*(a2+b2*xLine+c2*yLine)+u_allRK(3,ei,tIn-1)*(a3+b3*xLine+c3*yLine));
    c0_ng=c0_pnt;
    if ed3_cond==1
        c0_ng=(1/(2*areatrng3))*(u_allRK(1,ngEl_ed3,tIn-1)*(a1ng3+b1ng3*xLine+c1ng3*yLine)+u_allRK(2,ngEl_ed3,tIn-1)*(a2ng3+b2ng3*xLine+c2ng3*yLine)+u_allRK(3,ngEl_ed3,tIn-1)*(a3ng3+b3ng3*xLine+c3ng3*yLine));
    end
    K1_e3(1,1)=K1_e3(1,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed3_n_x*yLine+ed3_n_y*xLine)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    K1_e3(2,1)=K1_e3(2,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed3_n_x*yLine+ed3_n_y*xLine)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    K1_e3(3,1)=K1_e3(3,1)+wwLine*2*pi*0.5*(c0_pnt+c0_ng)*(-ed3_n_x*yLine+ed3_n_y*xLine)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

    K2_e3(1,1)=K2_e3(1,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed3_n_x*yLine+ed3_n_y*xLine)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
    K2_e3(2,1)=K2_e3(2,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed3_n_x*yLine+ed3_n_y*xLine)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
    K2_e3(3,1)=K2_e3(3,1)+wwLine*2*pi*(c0_ng-c0_pnt)*abs(-ed3_n_x*yLine+ed3_n_y*xLine)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
end