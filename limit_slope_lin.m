Ez0=(1/3)*(temp_Ez(1,1)+temp_Ez(2,1)+temp_Ez(3,1));
Ez0_x=(1/(2*areatr))*(b1*temp_Ez(1,1)+b2*temp_Ez(2,1)+b3*temp_Ez(3,1));
Ez0_y=(1/(2*areatr))*(c1*temp_Ez(1,1)+c2*temp_Ez(2,1)+c3*temp_Ez(3,1));
if edge_type(ed1in)==1
    Ez1_x=(1/(2*areatrng1))*(b1ng1*Ez_all(1,ngEl_ed1,tIn-1)+b2ng1*Ez_all(2,ngEl_ed1,tIn-1)+b3ng1*Ez_all(3,ngEl_ed1,tIn-1));
    Ez1_y=(1/(2*areatrng1))*(c1ng1*Ez_all(1,ngEl_ed1,tIn-1)+c2ng1*Ez_all(2,ngEl_ed1,tIn-1)+c3ng1*Ez_all(3,ngEl_ed1,tIn-1));
end
if edge_type(ed2in)==1
    Ez2_x=(1/(2*areatrng2))*(b1ng2*Ez_all(1,ngEl_ed2,tIn-1)+b2ng2*Ez_all(2,ngEl_ed2,tIn-1)+b3ng2*Ez_all(3,ngEl_ed2,tIn-1));
    Ez2_y=(1/(2*areatrng2))*(c1ng2*Ez_all(1,ngEl_ed2,tIn-1)+c2ng2*Ez_all(2,ngEl_ed2,tIn-1)+c3ng2*Ez_all(3,ngEl_ed2,tIn-1));
end
if edge_type(ed3in)==1
    Ez3_x=(1/(2*areatrng3))*(b1ng3*Ez_all(1,ngEl_ed3,tIn-1)+b2ng3*Ez_all(2,ngEl_ed3,tIn-1)+b3ng3*Ez_all(3,ngEl_ed3,tIn-1));
    Ez3_y=(1/(2*areatrng3))*(c1ng3*Ez_all(1,ngEl_ed3,tIn-1)+c2ng3*Ez_all(2,ngEl_ed3,tIn-1)+c3ng3*Ez_all(3,ngEl_ed3,tIn-1));
end
if edge_type(ed1in)~=1
    Ez1_x=Ez0_x;
    Ez1_y=Ez0_y;
end
if edge_type(ed2in)~=1
    Ez2_x=Ez0_x;
    Ez2_y=Ez0_y;
end
if edge_type(ed3in)~=1
    Ez3_x=Ez0_x;
    Ez3_y=Ez0_y;
end
g0=Ez0_x*Ez0_x+Ez0_y*Ez0_y;
g1=Ez1_x*Ez1_x+Ez1_y*Ez1_y;
g2=Ez2_x*Ez2_x+Ez2_y*Ez2_y;
g3=Ez3_x*Ez3_x+Ez3_y*Ez3_y;
epsln=1e-10;
w1=(g2*g3+epsln)/(g1*g1+g2*g2+g0*g0+3*epsln);
w2=(g3*g1+epsln)/(g2*g2+g3*g3+g0*g0+3*epsln);
w3=(g1*g2+epsln)/(g3*g3+g1*g1+g0*g0+3*epsln);

Ez0_x_lim=w1*Ez1_x+w2*Ez2_x+w3*Ez3_x;
Ez0_y_lim=w1*Ez1_y+w2*Ez2_y+w3*Ez3_y;

lim_left=[b1/(2*areatr), b2/(2*areatr), b3/(2*areatr); c1/(2*areatr), c2/(2*areatr), c3/(2*areatr); 1, 1, 1;];

lim_right=[Ez0_x_lim; Ez0_y_lim; 3*Ez0];

Ez_all(:,ei,tIn)=lim_left\lim_right;

if abs(Ez0_x_lim)>abs(Ez0_x) && abs(Ez0_y_lim)>abs(Ez0_y)
    Ez_all(:,ei,tIn)=temp_Ez(:,1);
end