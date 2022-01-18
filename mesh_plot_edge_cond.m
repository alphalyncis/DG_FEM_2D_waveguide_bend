% mesh plot with edge conditions
for ei=1:Nel
    nd1in=elements(ei,1);       nd2in=elements(ei,2);       nd3in=elements(ei,3);
    ed1in=elementEdges(ei,1);   ed2in=elementEdges(ei,2);   ed3in=elementEdges(ei,3);
    color=['b' 'g' 'y' 'm']
    line_plot(x_no(nd1in),y_no(nd1in),x_no(nd2in),y_no(nd2in),color(edge_type(ed1in)),1);
    line_plot(x_no(nd2in),y_no(nd2in),x_no(nd3in),y_no(nd3in),color(edge_type(ed2in)),1);
    line_plot(x_no(nd3in),y_no(nd3in),x_no(nd1in),y_no(nd1in),color(edge_type(ed3in)),1);    
end

hold on;
