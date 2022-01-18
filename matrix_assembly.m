nn=3;

M_all=zeros(Nel,3,3);       N_all=zeros(Nel,3,3);

for ei=1:1:Nel % ei=element index, nd=node, in=index
    nd1in=elements(ei,1);       nd2in=elements(ei,2);       nd3in=elements(ei,3);
    % node index of node 1      % node index of node 2      % node 3 index
    x1=nodes(nd1in,1);        x2=nodes(nd2in,1);        x3=nodes(nd3in,1);
    % x_coord of node 1         % x_coord of node 2         % ...
    y1=nodes(nd1in,2);        y2=nodes(nd2in,2);        y3=nodes(nd3in,2);
    % y_coord of node 1
    
    % Triangle Parameters
    a1=x2*y3-y2*x3;     a2=x3*y1-y3*x1;     a3=x1*y2-y1*x2;
    b1=y2-y3;               b2=y3-y1;               b3=y1-y2;
    c1=x3-x2;               c2=x1-x3;               c3=x2-x1;
    areatr=0.5*(x1*y2-x2*y1+x2*y3-x3*y2+x3*y1-x1*y3);
    
    if areatr<0
        display('areatrtr<0?');
    end
        
    for gi=1:1:Nduf % gi=1,2,...,9; summing 9 terms
        ksiDuf=sqDuf(gi,1);     etaDuf=sqDuf(gi,2);     wwDuf=sqDuf(gi,3);
        xDuf=x1+(x2-x1)*ksiDuf+(x3-x2)*ksiDuf*etaDuf;
        yDuf=y1+(y2-y1)*ksiDuf+(y3-y2)*ksiDuf*etaDuf;
        wwKsi2A=wwDuf*ksiDuf*2*areatr;
        
        M_all(ei,1,1)=M_all(ei,1,1)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(a1+b1*xDuf+c1*yDuf);
        M_all(ei,1,2)=M_all(ei,1,2)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(a2+b2*xDuf+c2*yDuf);
        M_all(ei,1,3)=M_all(ei,1,3)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(a3+b3*xDuf+c3*yDuf);
        M_all(ei,2,1)=M_all(ei,2,1)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(a1+b1*xDuf+c1*yDuf);
        M_all(ei,2,2)=M_all(ei,2,2)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(a2+b2*xDuf+c2*yDuf);
        M_all(ei,2,3)=M_all(ei,2,3)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(a3+b3*xDuf+c3*yDuf);
        M_all(ei,3,1)=M_all(ei,3,1)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(a1+b1*xDuf+c1*yDuf);
        M_all(ei,3,2)=M_all(ei,3,2)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(a2+b2*xDuf+c2*yDuf);
        M_all(ei,3,3)=M_all(ei,3,3)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(a3+b3*xDuf+c3*yDuf);
        
        N2_all(ei,1,1)=N2_all(ei,1,1)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(c1)*xDuf;
        N2_all(ei,1,2)=N2_all(ei,1,2)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(c2)*xDuf;
        N2_all(ei,1,3)=N2_all(ei,1,3)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(c3)*xDuf;
        N2_all(ei,2,1)=N2_all(ei,2,1)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(c1)*xDuf;
        N2_all(ei,2,2)=N2_all(ei,2,2)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(c2)*xDuf;
        N2_all(ei,2,3)=N2_all(ei,2,3)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(c3)*xDuf;
        N2_all(ei,3,1)=N2_all(ei,3,1)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(c1)*xDuf;
        N2_all(ei,3,2)=N2_all(ei,3,2)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(c2)*xDuf;
        N2_all(ei,3,3)=N2_all(ei,3,3)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(c3)*xDuf;
        
        N1_all(ei,1,1)=N1_all(ei,1,1)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(b1)*yDuf;
        N1_all(ei,1,2)=N1_all(ei,1,2)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(b2)*yDuf;
        N1_all(ei,1,3)=N1_all(ei,1,3)+wwKsi2A*(1/(4*areatr*areatr))*(a1+b1*xDuf+c1*yDuf)*(b3)*yDuf;
        N1_all(ei,2,1)=N1_all(ei,2,1)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(b1)*yDuf;
        N1_all(ei,2,2)=N1_all(ei,2,2)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(b2)*yDuf;
        N1_all(ei,2,3)=N1_all(ei,2,3)+wwKsi2A*(1/(4*areatr*areatr))*(a2+b2*xDuf+c2*yDuf)*(b3)*yDuf;
        N1_all(ei,3,1)=N1_all(ei,3,1)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(b1)*yDuf;
        N1_all(ei,3,2)=N1_all(ei,3,2)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(b2)*yDuf;
        N1_all(ei,3,3)=N1_all(ei,3,3)+wwKsi2A*(1/(4*areatr*areatr))*(a3+b3*xDuf+c3*yDuf)*(b3)*yDuf;
        
        F_all(1,ei)=F_all(1,ei)+wwKsi2A*(1/(2*areatr))*(a1+b1*xDuf+c1*yDuf);
        F_all(2,ei)=F_all(2,ei)+wwKsi2A*(1/(2*areatr))*(a2+b2*xDuf+c2*yDuf);
        F_all(3,ei)=F_all(3,ei)+wwKsi2A*(1/(2*areatr))*(a3+b3*xDuf+c3*yDuf); 
    end
    
    % for edge1
    l_x1=x1;    l_y1=y1;    l_x2=x2;    l_y2=y2;
    lLine=sqrt((l_x1-l_x2)^2+(l_y1-l_y2)^2);
    for ji=1:1:Nline
        ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
        xLine=(l_x2-l_x1)*ksiDuf+l_x1;
        yLine=(l_y2-l_y1)*ksiDuf+l_y1;
        wwLine=wwDuf*lLine;

        Fe1_all(1,ei)=Fe1_all(1,ei)+wwLine*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        Fe1_all(2,ei)=Fe1_all(2,ei)+wwLine*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        Fe1_all(3,ei)=Fe1_all(3,ei)+wwLine*(1/(2*areatr))*(a3+b3*xLine+c3*yLine); 
    end

    % for edge2
    l_x1=x2;    l_y1=y2;    l_x2=x3;    l_y2=y3;
    lLine=sqrt((l_x1-l_x2)^2+(l_y1-l_y2)^2);
    for ji=1:1:Nline
        ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
        xLine=(l_x2-l_x1)*ksiDuf+l_x1;
        yLine=(l_y2-l_y1)*ksiDuf+l_y1;
        wwLine=wwDuf*lLine;
                
        Fe2_all(1,ei)=Fe2_all(1,ei)+wwLine*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        Fe2_all(2,ei)=Fe2_all(2,ei)+wwLine*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        Fe2_all(3,ei)=Fe2_all(3,ei)+wwLine*(1/(2*areatr))*(a3+b3*xLine+c3*yLine); 
    end
    
    % for edge3
    l_x1=x3;    l_y1=y3;    l_x2=x1;    l_y2=y1;
    lLine=sqrt((l_x1-l_x2)^2+(l_y1-l_y2)^2);
    for ji=1:1:Nline
        ksiDuf=NumQuadPoints(ji,1);     wwDuf=NumQuadPoints(ji,2);
        xLine=(l_x2-l_x1)*ksiDuf+l_x1;
        yLine=(l_y2-l_y1)*ksiDuf+l_y1;
        wwLine=wwDuf*lLine;
                
        Fe3_all(1,ei)=Fe3_all(1,ei)+wwLine*(1/(2*areatr))*(a1+b1*xLine+c1*yLine);
        Fe3_all(2,ei)=Fe3_all(2,ei)+wwLine*(1/(2*areatr))*(a2+b2*xLine+c2*yLine);
        Fe3_all(3,ei)=Fe3_all(3,ei)+wwLine*(1/(2*areatr))*(a3+b3*xLine+c3*yLine); 
    end
end