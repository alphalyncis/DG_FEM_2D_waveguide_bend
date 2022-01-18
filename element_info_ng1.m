nd1inng1=elements(ngEl_ed1,1);       nd2inng1=elements(ngEl_ed1,2);       nd3inng1=elements(ngEl_ed1,3);

nd1xng1=nodes(nd1inng1,1);        nd2xng1=nodes(nd2inng1,1);        nd3xng1=nodes(nd3inng1,1);
nd1yng1=nodes(nd1inng1,2);        nd2yng1=nodes(nd2inng1,2);        nd3yng1=nodes(nd3inng1,2);

cxng1=(nd1xng1+nd2xng1+nd3xng1)/3.0;      cyng1=(nd1yng1+nd2yng1+nd3yng1)/3.0;

areatrng1=0.5*(nd1xng1*nd2yng1-nd2xng1*nd1yng1+nd2xng1*nd3yng1-nd3xng1*nd2yng1+nd3xng1*nd1yng1-nd1xng1*nd3yng1);

% Triangle Parameters
a1ng1=nd2xng1*nd3yng1-nd2yng1*nd3xng1;     a2ng1=nd3xng1*nd1yng1-nd3yng1*nd1xng1;     a3ng1=nd1xng1*nd2yng1-nd1yng1*nd2xng1;
b1ng1=nd2yng1-nd3yng1;                     b2ng1=nd3yng1-nd1yng1;                     b3ng1=nd1yng1-nd2yng1;
c1ng1=nd3xng1-nd2xng1;                     c2ng1=nd1xng1-nd3xng1;                     c3ng1=nd2xng1-nd1xng1;

tqng1=zeros(6,6); % ?

tqng1(1,:)=(1/(2*areatrng1*areatrng1)).*[a1ng1*a1ng1-areatrng1*a1ng1, a1ng1*b1ng1*2-b1ng1*areatrng1, 2*a1ng1*c1ng1-c1ng1*areatrng1, b1ng1*b1ng1, 2*b1ng1*c1ng1, c1ng1*c1ng1];
tqng1(2,:)=(1/(2*areatrng1*areatrng1)).*[a2ng1*a2ng1-areatrng1*a2ng1, a2ng1*b2ng1*2-b2ng1*areatrng1, 2*a2ng1*c2ng1-c2ng1*areatrng1, b2ng1*b2ng1, 2*b2ng1*c2ng1, c2ng1*c2ng1];
tqng1(3,:)=(1/(2*areatrng1*areatrng1)).*[a3ng1*a3ng1-areatrng1*a3ng1, a3ng1*b3ng1*2-b3ng1*areatrng1, 2*a3ng1*c3ng1-c3ng1*areatrng1, b3ng1*b3ng1, 2*b3ng1*c3ng1, c3ng1*c3ng1];
tqng1(4,:)=(1/(areatrng1*areatrng1)).*[a1ng1*a2ng1, a1ng1*b2ng1+b1ng1*a2ng1, a1ng1*c2ng1+c1ng1*a2ng1, b1ng1*b2ng1, b1ng1*c2ng1+c1ng1*b2ng1, c1ng1*c2ng1];
tqng1(5,:)=(1/(areatrng1*areatrng1)).*[a2ng1*a3ng1, a2ng1*b3ng1+b2ng1*a3ng1, a2ng1*c3ng1+c2ng1*a3ng1, b2ng1*b3ng1, b2ng1*c3ng1+c2ng1*b3ng1, c2ng1*c3ng1];
tqng1(6,:)=(1/(areatrng1*areatrng1)).*[a3ng1*a1ng1, a3ng1*b1ng1+b3ng1*a1ng1, a3ng1*c1ng1+c3ng1*a1ng1, b3ng1*b1ng1, b3ng1*c1ng1+c3ng1*b1ng1, c3ng1*c1ng1];