nd1in=elements(ei,1);       nd2in=elements(ei,2);       nd3in=elements(ei,3);
ed1in=elementEdges(ei,1);   ed2in=elementEdges(ei,2);   ed3in=elementEdges(ei,3);
nd1x=nodes(nd1in,1);        nd2x=nodes(nd2in,1);        nd3x=nodes(nd3in,1);
nd1y=nodes(nd1in,2);        nd2y=nodes(nd2in,2);        nd3y=nodes(nd3in,2);
ed1x=0.5*(nd1x+nd2x);       ed2x=0.5*(nd2x+nd3x);       ed3x=0.5*(nd3x+nd1x);
ed1y=0.5*(nd1y+nd2y);       ed2y=0.5*(nd2y+nd3y);       ed3y=0.5*(nd3y+nd1y);

cx=(nd1x+nd2x+nd3x)/3.0;      cy=(nd1y+nd2y+nd3y)/3.0;

nd4x=ed1x;      nd5x=ed2x;      nd6x=ed3x;
nd4y=ed1y;      nd5y=ed2y;      nd6y=ed3y;


areatr=0.5*(nd1x*nd2y-nd2x*nd1y+nd2x*nd3y-nd3x*nd2y+nd3x*nd1y-nd1x*nd3y);

% calc normal vectors to the edges, note the sign!
ed1_n_x=-1*(nd1y-nd2y)/sqrt((nd2y-nd1y)*(nd2y-nd1y)+(nd2x-nd1x)*(nd2x-nd1x));    ed1_n_y=-1*(nd2x-nd1x)/sqrt((nd2y-nd1y)*(nd2y-nd1y)+(nd2x-nd1x)*(nd2x-nd1x));
ed2_n_x=-1*(nd2y-nd3y)/sqrt((nd3y-nd2y)*(nd3y-nd2y)+(nd3x-nd2x)*(nd3x-nd2x));    ed2_n_y=-1*(nd3x-nd2x)/sqrt((nd3y-nd2y)*(nd3y-nd2y)+(nd3x-nd2x)*(nd3x-nd2x));
ed3_n_x=-1*(nd3y-nd1y)/sqrt((nd1y-nd3y)*(nd1y-nd3y)+(nd1x-nd3x)*(nd1x-nd3x));    ed3_n_y=-1*(nd1x-nd3x)/sqrt((nd1y-nd3y)*(nd1y-nd3y)+(nd1x-nd3x)*(nd1x-nd3x));
ed1_cond=0;                 ed2_cond=0;                 ed3_cond=0;  %% 0 means not assigned edge, check for error.

% Triangle Parameters
a1=nd2x*nd3y-nd2y*nd3x;     a2=nd3x*nd1y-nd3y*nd1x;     a3=nd1x*nd2y-nd1y*nd2x;
b1=nd2y-nd3y;               b2=nd3y-nd1y;               b3=nd1y-nd2y;
c1=nd3x-nd2x;               c2=nd1x-nd3x;               c3=nd2x-nd1x;
