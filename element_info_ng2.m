nd1inng2=elements(ngEl_ed2,1);       nd2inng2=elements(ngEl_ed2,2);       nd3inng2=elements(ngEl_ed2,3);

nd1xng2=nodes(nd1inng2,1);        nd2xng2=nodes(nd2inng2,1);        nd3xng2=nodes(nd3inng2,1);
nd1yng2=nodes(nd1inng2,2);        nd2yng2=nodes(nd2inng2,2);        nd3yng2=nodes(nd3inng2,2);

cxng2=(nd1xng2+nd2xng2+nd3xng2)/3.0;      cyng2=(nd1yng2+nd2yng2+nd3yng2)/3.0;



areatrng2=0.5*(nd1xng2*nd2yng2-nd2xng2*nd1yng2+nd2xng2*nd3yng2-nd3xng2*nd2yng2+nd3xng2*nd1yng2-nd1xng2*nd3yng2);


% Triangle Parameters
a1ng2=nd2xng2*nd3yng2-nd2yng2*nd3xng2;     a2ng2=nd3xng2*nd1yng2-nd3yng2*nd1xng2;     a3ng2=nd1xng2*nd2yng2-nd1yng2*nd2xng2;
b1ng2=nd2yng2-nd3yng2;                     b2ng2=nd3yng2-nd1yng2;                     b3ng2=nd1yng2-nd2yng2;
c1ng2=nd3xng2-nd2xng2;                     c2ng2=nd1xng2-nd3xng2;                     c3ng2=nd2xng2-nd1xng2;


tqng2=zeros(6,6);

tqng2(1,:)=(1/(2*areatrng2*areatrng2)).*[a1ng2*a1ng2-areatrng2*a1ng2, a1ng2*b1ng2*2-b1ng2*areatrng2, 2*a1ng2*c1ng2-c1ng2*areatrng2, b1ng2*b1ng2, 2*b1ng2*c1ng2, c1ng2*c1ng2];
tqng2(2,:)=(1/(2*areatrng2*areatrng2)).*[a2ng2*a2ng2-areatrng2*a2ng2, a2ng2*b2ng2*2-b2ng2*areatrng2, 2*a2ng2*c2ng2-c2ng2*areatrng2, b2ng2*b2ng2, 2*b2ng2*c2ng2, c2ng2*c2ng2];
tqng2(3,:)=(1/(2*areatrng2*areatrng2)).*[a3ng2*a3ng2-areatrng2*a3ng2, a3ng2*b3ng2*2-b3ng2*areatrng2, 2*a3ng2*c3ng2-c3ng2*areatrng2, b3ng2*b3ng2, 2*b3ng2*c3ng2, c3ng2*c3ng2];
tqng2(4,:)=(1/(areatrng2*areatrng2)).*[a1ng2*a2ng2, a1ng2*b2ng2+b1ng2*a2ng2, a1ng2*c2ng2+c1ng2*a2ng2, b1ng2*b2ng2, b1ng2*c2ng2+c1ng2*b2ng2, c1ng2*c2ng2];
tqng2(5,:)=(1/(areatrng2*areatrng2)).*[a2ng2*a3ng2, a2ng2*b3ng2+b2ng2*a3ng2, a2ng2*c3ng2+c2ng2*a3ng2, b2ng2*b3ng2, b2ng2*c3ng2+c2ng2*b3ng2, c2ng2*c3ng2];
tqng2(6,:)=(1/(areatrng2*areatrng2)).*[a3ng2*a1ng2, a3ng2*b1ng2+b3ng2*a1ng2, a3ng2*c1ng2+c3ng2*a1ng2, b3ng2*b1ng2, b3ng2*c1ng2+c3ng2*b1ng2, c3ng2*c1ng2];