imj=sqrt(-1);
b_el=zeros(3,1);
K_el=zeros(3,3); % only one edge can contribute to K or b

%% for edge1
F_ed1=zeros(3,1);
l_nd1x=nd1x;    l_nd1y=nd1y;    l_nd2x=nd2x;    l_nd2y=nd2y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2); % edge length

if edge_type(ed1in)==1 % if this edge has a neighbour element,  integral contribution from this&neighbour
    for ji=1:1:Nline % integration sampling points
        ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
        xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
        yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
        wwLine=wwDuf*lLine; 
    
        % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
        nabla_Ez_x=b1*(Ez_all(1,ngEl_ed1,tIn-1)+Ez_all(1,ei,tIn-1))+b2*(Ez_all(2,ngEl_ed1,tIn-1)+Ez_all(2,ei,tIn-1))+b3*(Ez_all(2,ngEl_ed1,tIn-1)+Ez_all(2,ei,tIn-1));
        nabla_Ez_y=c1*(Ez_all(1,ngEl_ed1,tIn-1)+Ez_all(1,ei,tIn-1))+c2*(Ez_all(2,ngEl_ed1,tIn-1)+Ez_all(2,ei,tIn-1))+c3*(Ez_all(2,ngEl_ed1,tIn-1)+Ez_all(2,ei,tIn-1));
        
        % F = \int{nabla_Ez \dot \vec{n} Ni dl}
        dot_product=0.5*(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
        F_ed1(1,1)=F_ed1(1,1)+wwLine*dot_product*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        F_ed1(2,1)=F_ed1(2,1)+wwLine*dot_product*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        F_ed1(3,1)=F_ed1(3,1)+wwLine*dot_product*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
    end
    
elseif edge_type(ed1in)==2 % if edge is on input port, contribution from K and b
    count=count+1;
    ysr=(l_nd1y+l_nd2y)/2;
    K_el(1,2)=K_el(1,2)-imj*kx*lLine/6.;
    K_el(2,1)=K_el(2,1)-imj*kx*lLine/6.;
    K_el(1,1)=K_el(1,1)-imj*kx*lLine/3.;
    K_el(2,2)=K_el(2,2)-imj*kx*lLine/3.;
    b_el(1)=b_el(1)-2*c0*c0*imj*kx*lLine/2.*te_even_mode(ysr,E0,Order,d);
    b_el(2)=b_el(2)-2*c0*c0*imj*kx*lLine/2.*te_even_mode(ysr,E0,Order,d);

elseif edge_type(ed1in)==3
    K_el(1,2)=K_el(1,2)-imj*kx*lLine/6.;
    K_el(2,1)=K_el(2,1)-imj*kx*lLine/6.;
    K_el(1,1)=K_el(1,1)-imj*kx*lLine/3.;
    K_el(2,2)=K_el(2,2)-imj*kx*lLine/3.;      
end

%% for edge2
F_ed2=zeros(3,1);
l_nd1x=nd2x;    l_nd1y=nd2y;    l_nd2x=nd3x;    l_nd2y=nd3y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2); % edge length

if edge_type(ed2in)==1 % if this edge has a neighbour element,  integral contribution from this&neighbour
    for ji=1:1:Nline % integration sampling points
        ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
        xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
        yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
        wwLine=wwDuf*lLine; 
    
        % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
        nabla_Ez_x=b1*(Ez_all(1,ngEl_ed2,tIn-1)+Ez_all(1,ei,tIn-1))+b2*(Ez_all(2,ngEl_ed2,tIn-1)+Ez_all(2,ei,tIn-1))+b3*(Ez_all(2,ngEl_ed2,tIn-1)+Ez_all(2,ei,tIn-1));
        nabla_Ez_y=c1*(Ez_all(1,ngEl_ed2,tIn-1)+Ez_all(1,ei,tIn-1))+c2*(Ez_all(2,ngEl_ed2,tIn-1)+Ez_all(2,ei,tIn-1))+c3*(Ez_all(2,ngEl_ed2,tIn-1)+Ez_all(2,ei,tIn-1));
        
        % F = \int{nabla_Ez \dot \vec{n} Ni dl}
        dot_product=0.5*(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
        F_ed2(1,1)=F_ed2(1,1)+wwLine*dot_product*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        F_ed2(2,1)=F_ed2(2,1)+wwLine*dot_product*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        F_ed2(3,1)=F_ed2(3,1)+wwLine*dot_product*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
    end
    
elseif edge_type(ed2in)==2 % if edge is on input port, contribution from K and b
    count=count+1;
    ysr=(l_nd1y+l_nd2y)/2;
    K_el(2,3)=K_el(2,3)-imj*kx*lLine/6.;
    K_el(3,2)=K_el(3,2)-imj*kx*lLine/6.;
    K_el(2,2)=K_el(2,2)-imj*kx*lLine/3.;
    K_el(3,3)=K_el(3,3)-imj*kx*lLine/3.;
    b_el(2)=b_el(2)-2*c0*c0*imj*kx*lLine/2.*te_even_mode(ysr,E0,Order,d);
    b_el(3)=b_el(3)-2*c0*c0*imj*kx*lLine/2.*te_even_mode(ysr,E0,Order,d);

elseif edge_type(ed2in)==3
    K_el(2,3)=K_el(2,3)-imj*kx*lLine/6.;
    K_el(3,2)=K_el(3,2)-imj*kx*lLine/6.;
    K_el(2,2)=K_el(2,2)-imj*kx*lLine/3.;
    K_el(3,3)=K_el(3,3)-imj*kx*lLine/3.;   
end


%% for edge3
F_ed3=zeros(3,1);
l_nd1x=nd3x;    l_nd1y=nd3y;    l_nd2x=nd1x;    l_nd2y=nd1y;
lLine=sqrt((l_nd1x-l_nd2x)^2+(l_nd1y-l_nd2y)^2); % edge length

if edge_type(ed3in)==1 % if this edge has a neighbour element,  integral contribution from this&neighbour
    for ji=1:1:Nline % integration sampling points
        ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
        xLine=(l_nd2x-l_nd1x)*ksiDuf+l_nd1x;
        yLine=(l_nd2y-l_nd1y)*ksiDuf+l_nd1y;
        wwLine=wwDuf*lLine; 
    
        % nabla_Ez=nabla_N1*Ez1+nabla_N2*Ez2+nabla_N3*Ez3
        nabla_Ez_x=b1*(Ez_all(1,ngEl_ed3,tIn-1)+Ez_all(1,ei,tIn-1))+b2*(Ez_all(2,ngEl_ed3,tIn-1)+Ez_all(2,ei,tIn-1))+b3*(Ez_all(2,ngEl_ed3,tIn-1)+Ez_all(2,ei,tIn-1));
        nabla_Ez_y=c1*(Ez_all(1,ngEl_ed3,tIn-1)+Ez_all(1,ei,tIn-1))+c2*(Ez_all(2,ngEl_ed3,tIn-1)+Ez_all(2,ei,tIn-1))+c3*(Ez_all(2,ngEl_ed3,tIn-1)+Ez_all(2,ei,tIn-1));
        
        % F = \int{nabla_Ez \dot \vec{n} Ni dl}
        dot_product=0.5*(nabla_Ez_x*ed1_n_x+nabla_Ez_y*ed1_n_y);
        F_ed3(1,1)=F_ed3(1,1)+wwLine*dot_product*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        F_ed3(2,1)=F_ed3(2,1)+wwLine*dot_product*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        F_ed3(3,1)=F_ed3(3,1)+wwLine*dot_product*(1/(2*areatr))*(a3+b3*xLine+c3*yLine);
    end
    
elseif edge_type(ed3in)==2 % if edge is on input port, contribution from K and b
    count=count+1;
    ysr=(l_nd1y+l_nd2y)/2;
    K_el(3,1)=K_el(3,1)-imj*kx*lLine/6.;
    K_el(1,3)=K_el(1,3)-imj*kx*lLine/6.;
    K_el(1,1)=K_el(1,1)-imj*kx*lLine/3.;
    K_el(3,3)=K_el(3,3)-imj*kx*lLine/3.;
    b_el(1)=b_el(1)-2*c0*c0*imj*kx*lLine/2.*te_even_mode(ysr,E0,Order,d);
    b_el(3)=b_el(3)-2*c0*c0*imj*kx*lLine/2.*te_even_mode(ysr,E0,Order,d);

elseif edge_type(ed3in)==3
    K_el(3,1)=K_el(3,1)-imj*kx*lLine/6.;
    K_el(1,3)=K_el(1,3)-imj*kx*lLine/6.;
    K_el(1,1)=K_el(1,1)-imj*kx*lLine/3.;
    K_el(3,3)=K_el(3,3)-imj*kx*lLine/3.;  
end