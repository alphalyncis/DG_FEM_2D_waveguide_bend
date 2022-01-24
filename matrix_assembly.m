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
        
        M_all(ei,1,1)=M_all(ei,1,1)+wwKsi2A*c0*c0*(1/(4*areatr^2))*(b1^2+c1^2);
        M_all(ei,2,2)=M_all(ei,2,2)+wwKsi2A*c0*c0*(1/(4*areatr^2))*(b2^2+c2^2);
        M_all(ei,3,3)=M_all(ei,3,3)+wwKsi2A*c0*c0*(1/(4*areatr^2))*(b3^2+c3^2);
        M_all(ei,1,2)=M_all(ei,3,3)+wwKsi2A*c0*c0*(1/(4*areatr^2))*(b1*b2+c1*c2);
        M_all(ei,1,3)=M_all(ei,3,3)+wwKsi2A*c0*c0*(1/(4*areatr^2))*(b3*b1+c3*c1);
        M_all(ei,2,3)=M_all(ei,3,3)+wwKsi2A*c0*c0*(1/(4*areatr^2))*(b2*b3+c2*c3);
        M_all(ei,2,1)=M_all(ei,1,2);
        M_all(ei,3,1)=M_all(ei,1,3);
        M_all(ei,3,2)=M_all(ei,2,3);
        
        N_all(ei,1,1)=N_all(ei,1,1)+wwKsi2A*(1/(4*areatr^2))*(a1+b1*xDuf+c1*yDuf)*(a1+b1*xDuf+c1*yDuf);
        N_all(ei,1,2)=N_all(ei,1,2)+wwKsi2A*(1/(4*areatr^2))*(a1+b1*xDuf+c1*yDuf)*(a2+b2*xDuf+c2*yDuf);
        N_all(ei,1,3)=N_all(ei,1,3)+wwKsi2A*(1/(4*areatr^2))*(a1+b1*xDuf+c1*yDuf)*(a3+b3*xDuf+c3*yDuf);
        N_all(ei,2,1)=N_all(ei,2,1)+wwKsi2A*(1/(4*areatr^2))*(a2+b2*xDuf+c2*yDuf)*(a1+b1*xDuf+c1*yDuf);
        N_all(ei,2,2)=N_all(ei,2,2)+wwKsi2A*(1/(4*areatr^2))*(a2+b2*xDuf+c2*yDuf)*(a2+b2*xDuf+c2*yDuf);
        N_all(ei,2,3)=N_all(ei,2,3)+wwKsi2A*(1/(4*areatr^2))*(a2+b2*xDuf+c2*yDuf)*(a3+b3*xDuf+c3*yDuf);
        N_all(ei,3,1)=N_all(ei,3,1)+wwKsi2A*(1/(4*areatr^2))*(a3+b3*xDuf+c3*yDuf)*(a1+b1*xDuf+c1*yDuf);
        N_all(ei,3,2)=N_all(ei,3,2)+wwKsi2A*(1/(4*areatr^2))*(a3+b3*xDuf+c3*yDuf)*(a2+b2*xDuf+c2*yDuf);
        N_all(ei,3,3)=N_all(ei,3,3)+wwKsi2A*(1/(4*areatr^2))*(a3+b3*xDuf+c3*yDuf)*(a3+b3*xDuf+c3*yDuf);
        
    end
%     
%     % bcs def
%     if st_no(nd1in)==1
%         for j=1:3
%             M_all(ei,1,j)=0.;
%         end
%     end
%     if st_no(nd2in)==1
%         for j=1:3
%             M_all(ei,2,j)=0.;
%         end
%     end
%     if st_no(nd3in)==1
%         for j=1:3
%             M_all(ei,3,j)=0.;
%         end
%     end
end