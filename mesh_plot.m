% mesh plot

for i=1:Nel
    line_plot(x_no(elements(i,1)),y_no(elements(i,1)),x_no(elements(i,2)),y_no(elements(i,2)),'b',1);
    line_plot(x_no(elements(i,2)),y_no(elements(i,2)),x_no(elements(i,3)),y_no(elements(i,3)),'b',1);
    line_plot(x_no(elements(i,3)),y_no(elements(i,3)),x_no(elements(i,1)),y_no(elements(i,1)),'b',1);
end

hold on;
