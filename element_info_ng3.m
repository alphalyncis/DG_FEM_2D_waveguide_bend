nd1inng3=elements(ngEl_ed3,1);       nd2inng3=elements(ngEl_ed3,2);       nd3inng3=elements(ngEl_ed3,3);

nd1xng3=nodes(nd1inng3,1);        nd2xng3=nodes(nd2inng3,1);        nd3xng3=nodes(nd3inng3,1);
nd1yng3=nodes(nd1inng3,2);        nd2yng3=nodes(nd2inng3,2);        nd3yng3=nodes(nd3inng3,2);

cxng3=(nd1xng3+nd2xng3+nd3xng3)/3.0;      cyng3=(nd1yng3+nd2yng3+nd3yng3)/3.0;



areatrng3=0.5*(nd1xng3*nd2yng3-nd2xng3*nd1yng3+nd2xng3*nd3yng3-nd3xng3*nd2yng3+nd3xng3*nd1yng3-nd1xng3*nd3yng3);


% Triangle Parameters
a1ng3=nd2xng3*nd3yng3-nd2yng3*nd3xng3;     a2ng3=nd3xng3*nd1yng3-nd3yng3*nd1xng3;     a3ng3=nd1xng3*nd2yng3-nd1yng3*nd2xng3;
b1ng3=nd2yng3-nd3yng3;                     b2ng3=nd3yng3-nd1yng3;                     b3ng3=nd1yng3-nd2yng3;
c1ng3=nd3xng3-nd2xng3;                     c2ng3=nd1xng3-nd3xng3;                     c3ng3=nd2xng3-nd1xng3;


tqng3=zeros(6,6);

tqng3(1,:)=(1/(2*areatrng3*areatrng3)).*[a1ng3*a1ng3-areatrng3*a1ng3, a1ng3*b1ng3*2-b1ng3*areatrng3, 2*a1ng3*c1ng3-c1ng3*areatrng3, b1ng3*b1ng3, 2*b1ng3*c1ng3, c1ng3*c1ng3];
tqng3(2,:)=(1/(2*areatrng3*areatrng3)).*[a2ng3*a2ng3-areatrng3*a2ng3, a2ng3*b2ng3*2-b2ng3*areatrng3, 2*a2ng3*c2ng3-c2ng3*areatrng3, b2ng3*b2ng3, 2*b2ng3*c2ng3, c2ng3*c2ng3];
tqng3(3,:)=(1/(2*areatrng3*areatrng3)).*[a3ng3*a3ng3-areatrng3*a3ng3, a3ng3*b3ng3*2-b3ng3*areatrng3, 2*a3ng3*c3ng3-c3ng3*areatrng3, b3ng3*b3ng3, 2*b3ng3*c3ng3, c3ng3*c3ng3];
tqng3(4,:)=(1/(areatrng3*areatrng3)).*[a1ng3*a2ng3, a1ng3*b2ng3+b1ng3*a2ng3, a1ng3*c2ng3+c1ng3*a2ng3, b1ng3*b2ng3, b1ng3*c2ng3+c1ng3*b2ng3, c1ng3*c2ng3];
tqng3(5,:)=(1/(areatrng3*areatrng3)).*[a2ng3*a3ng3, a2ng3*b3ng3+b2ng3*a3ng3, a2ng3*c3ng3+c2ng3*a3ng3, b2ng3*b3ng3, b2ng3*c3ng3+c2ng3*b3ng3, c2ng3*c3ng3];
tqng3(6,:)=(1/(areatrng3*areatrng3)).*[a3ng3*a1ng3, a3ng3*b1ng3+b3ng3*a1ng3, a3ng3*c1ng3+c3ng3*a1ng3, b3ng3*b1ng3, b3ng3*c1ng3+c3ng3*b1ng3, c3ng3*c1ng3];