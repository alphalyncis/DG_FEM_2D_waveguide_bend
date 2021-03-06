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
    
    if (edge_type(ed1in)==1 || edge_type(ed1in)==4) % if this edge has a neighbour element,  integral contribution from this&neighbour
        if edge_type(ed1in)==4
            Ez_ext=[0 0 0];
            b1ng1=0; b2ng1=0; b3ng1=0; c1ng1=0; c2ng1=0; c3ng1=0; areatrng1=areatr;
        else
            Ez_ext=Ez_all(:,ngEl_ed1,tIn-1);
        end
        Ez_int=Ez_all(:,ei,tIn-1);
        % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
        nabla_Ez_x=(1/(2*areatrng1))*(b1ng1*Ez_ext(1)+b2ng1*Ez_ext(2)+b3ng1*Ez_ext(3))-(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
        nabla_Ez_y=(1/(2*areatrng1))*(c1ng1*Ez_ext(1)+c2ng1*Ez_ext(2)+c3ng1*Ez_ext(3))-(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));

        % F = \int{nabla_Ez \dot \vec{n} * Ni dl}
        dot_product=0.5*(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
        F_ed1(1,1)=F_ed1(1,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        F_ed1(2,1)=F_ed1(2,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        F_ed1(3,1)=F_ed1(3,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

    elseif edge_type(ed1in)==2 % if edge is on input port, contribution from K and b
        count=count+1;
        ysr=(l_nd1y+l_nd2y)/2;
        K_el(1,1)=K_el(1,1)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)^2;
        K_el(2,2)=K_el(2,2)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)^2;
        K_el(3,3)=K_el(3,3)+wwLine*c0*(1/(4*areatr*areatr))*(a3+b3*xLine+c3*yLine)^2;
        K_el(1,2)=K_el(1,2)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a2+b2*xLine+c2*yLine);
        K_el(1,3)=K_el(1,3)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,3)=K_el(2,3)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,1)=K_el(1,2);
        K_el(3,1)=K_el(1,3);
        K_el(3,2)=K_el(2,3);
        
        b_el(1,1)=b_el(1,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        b_el(2,1)=b_el(2,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        b_el(3,1)=b_el(3,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
    
    elseif edge_type(ed1in)==3
        K_el(1,1)=K_el(1,1)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)^2;
        K_el(2,2)=K_el(2,2)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)^2;
        K_el(3,3)=K_el(3,3)+wwLine*c0*(1/(4*areatr*areatr))*(a3+b3*xLine+c3*yLine)^2;
        K_el(1,2)=K_el(1,2)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a2+b2*xLine+c2*yLine);
        K_el(1,3)=K_el(1,3)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,3)=K_el(2,3)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,1)=K_el(1,2);
        K_el(3,1)=K_el(1,3);
        K_el(3,2)=K_el(2,3);
    end
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
    
    if (edge_type(ed2in)==1 || edge_type(ed2in)==4) % if this edge has a neighbour element,  integral contribution from this&neighbour
        if edge_type(ed2in)==4
            Ez_ext=[0 0 0];
            b1ng2=0; b2ng2=0; b3ng2=0; c1ng2=0; c2ng2=0; c3ng2=0; areatrng2=areatr;
        else
            Ez_ext=Ez_all(:,ngEl_ed2,tIn-1);
        end
        Ez_int=Ez_all(:,ei,tIn-1);
        % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
        nabla_Ez_x=(1/(2*areatrng2))*(b1ng2*Ez_ext(1)+b2ng2*Ez_ext(2)+b3ng2*Ez_ext(3))-(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
        nabla_Ez_y=(1/(2*areatrng2))*(c1ng2*Ez_ext(1)+c2ng2*Ez_ext(2)+c3ng2*Ez_ext(3))-(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));

        % F = \int{nabla_Ez \dot \vec{n} Ni dl}
        dot_product=0.5*(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
        F_ed2(1,1)=F_ed2(1,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        F_ed2(2,1)=F_ed2(2,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        F_ed2(3,1)=F_ed2(3,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

    elseif edge_type(ed2in)==2 % if edge is on input port, contribution from K and b
        ysr=(l_nd1y+l_nd2y)/2;
        K_el(1,1)=K_el(1,1)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)^2;
        K_el(2,2)=K_el(2,2)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)^2;
        K_el(3,3)=K_el(3,3)+wwLine*c0*(1/(4*areatr*areatr))*(a3+b3*xLine+c3*yLine)^2;
        K_el(1,2)=K_el(1,2)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a2+b2*xLine+c2*yLine);
        K_el(1,3)=K_el(1,3)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,3)=K_el(2,3)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,1)=K_el(1,2);
        K_el(3,1)=K_el(1,3);
        K_el(3,2)=K_el(2,3);
        
        b_el(1,1)=b_el(1,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        b_el(2,1)=b_el(2,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        b_el(3,1)=b_el(3,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
    
    elseif edge_type(ed2in)==3
        K_el(1,1)=K_el(1,1)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)^2;
        K_el(2,2)=K_el(2,2)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)^2;
        K_el(3,3)=K_el(3,3)+wwLine*c0*(1/(4*areatr*areatr))*(a3+b3*xLine+c3*yLine)^2;
        K_el(1,2)=K_el(1,2)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a2+b2*xLine+c2*yLine);
        K_el(1,3)=K_el(1,3)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,3)=K_el(2,3)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,1)=K_el(1,2);
        K_el(3,1)=K_el(1,3);
        K_el(3,2)=K_el(2,3);        
    end
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
    
    if (edge_type(ed3in)==1 || edge_type(ed3in)==4) % if this edge has a neighbour element,  integral contribution from this&neighbour
        if edge_type(ed3in)==4
            Ez_ext=[0 0 0];
            b1ng3=0; b2ng3=0; b3ng3=0; c1ng3=0; c2ng3=0; c3ng3=0; areatrng3=areatr;
        else
            Ez_ext=Ez_all(:,ngEl_ed3,tIn-1);
        end
        Ez_int=Ez_all(:,ei,tIn-1);
        % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
        nabla_Ez_x=(1/(2*areatrng3))*(b1ng3*Ez_ext(1)+b2ng3*Ez_ext(2)+b3ng3*Ez_ext(3))-(1/(2*areatr))*(b1*Ez_int(1)+b2*Ez_int(2)+b3*Ez_int(3));
        nabla_Ez_y=(1/(2*areatrng3))*(c1ng3*Ez_ext(1)+c2ng3*Ez_ext(2)+c3ng3*Ez_ext(3))-(1/(2*areatr))*(c1*Ez_int(1)+c2*Ez_int(2)+c3*Ez_int(3));

        % F = \int{nabla_Ez \dot \vec{n} Ni dl}
        dot_product=0.5*(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
        F_ed3(1,1)=F_ed3(1,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        F_ed3(2,1)=F_ed3(2,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        F_ed3(3,1)=F_ed3(3,1)+wwLine*c0*c0*dot_product*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);

    elseif edge_type(ed3in)==2 % if edge is on input port, contribution from K and b
        ysr=(l_nd1y+l_nd2y)/2;
        K_el(1,1)=K_el(1,1)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)^2;
        K_el(2,2)=K_el(2,2)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)^2;
        K_el(3,3)=K_el(3,3)+wwLine*c0*(1/(4*areatr*areatr))*(a3+b3*xLine+c3*yLine)^2;
        K_el(1,2)=K_el(1,2)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a2+b2*xLine+c2*yLine);
        K_el(1,3)=K_el(1,3)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,3)=K_el(2,3)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,1)=K_el(1,2);
        K_el(3,1)=K_el(1,3);
        K_el(3,2)=K_el(2,3);
        
        b_el(1,1)=b_el(1,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        b_el(2,1)=b_el(2,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        b_el(3,1)=b_el(3,1)-wwLine*2*c0*te_even_mode(ysr,E0,Order,d)*omega*sin(omega*tnow)*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
    
    elseif edge_type(ed3in)==3
        K_el(1,1)=K_el(1,1)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)^2;
        K_el(2,2)=K_el(2,2)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)^2;
        K_el(3,3)=K_el(3,3)+wwLine*c0*(1/(4*areatr*areatr))*(a3+b3*xLine+c3*yLine)^2;
        K_el(1,2)=K_el(1,2)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a2+b2*xLine+c2*yLine);
        K_el(1,3)=K_el(1,3)+wwLine*c0*(1/(4*areatr*areatr))*(a1+b1*xLine+c1*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,3)=K_el(2,3)+wwLine*c0*(1/(4*areatr*areatr))*(a2+b2*xLine+c2*yLine)*(a3+b3*xLine+c3*yLine);
        K_el(2,1)=K_el(1,2);
        K_el(3,1)=K_el(1,3);
        K_el(3,2)=K_el(2,3);        
    end
end
%b_el, count