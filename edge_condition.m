% for edge 1
ngEl_ed1=-1; % ngEl_ed1=neighbour element of edge1
% find the ele index of the neighbour outside edge1
pos_neighbors=edge_ngEl(ed1in,:); % get the index of the 2 neighbour elements of edge1
if (pos_neighbors(1,1)==ei) && (pos_neighbors(1,2)>0.5) % if neighbour1 is the element itself and this edge not on boundary
    ngEl_ed1=pos_neighbors(1,2); % then neighbour2 is the neighbour element of edge1, save its element index
    element_info_ng1; % get the node coords, center, area, tq(?) of the this neighbour
    ed1_cond=1; % mark that edge1 has a neighbor element
end
if (pos_neighbors(1,2)==ei) && (pos_neighbors(1,1)>0.5) % if neighbour2 is the element itself and this edge not on boundary
    ngEl_ed1=pos_neighbors(1,1); % then neighbour1 is the neighbour element of edge1, save its index
    element_info_ng1;
    ed1_cond=1; % has a neighbor element
end
if ((ngEl_ed1==-1) && (ed1_cond==0)) % either ng 1 or 2 is the element itself, if the above two not satisfied, means that this edge is on boundary
    ed1_cond=2; % mark that edge1 is on the boundary
end

% for edge 2
ngEl_ed2=-1;
pos_neighbors=edge_ngEl(ed2in,:);
if (pos_neighbors(1,1)==ei) && (pos_neighbors(1,2)>0.5)
    ngEl_ed2=pos_neighbors(1,2);
    element_info_ng2;
    ed2_cond=1; % has a neighbor element
end
if (pos_neighbors(1,2)==ei) && (pos_neighbors(1,1)>0.5)
    ngEl_ed2=pos_neighbors(1,1);
    element_info_ng2;
    ed2_cond=1; % has a neighbor element
end
if ((ngEl_ed2==-1) && (ed2_cond==0))
    ed2_cond=2; % on the boundary
end

% for edge 3
ngEl_ed3=-1;
pos_neighbors=edge_ngEl(ed3in,:);
if (pos_neighbors(1,1)==ei) && (pos_neighbors(1,2)>0.5)
    ngEl_ed3=pos_neighbors(1,2);
    element_info_ng3;
    ed3_cond=1; % has a neighbor element
end
if (pos_neighbors(1,2)==ei) && (pos_neighbors(1,1)>0.5)
    ngEl_ed3=pos_neighbors(1,1);
    element_info_ng3;
    ed3_cond=1; % has a neighbor element
end
if ((ngEl_ed3==-1) && (ed3_cond==0))
    ed3_cond=2; % on the boundary
end


if ed1_cond==0 || ed2_cond==0 || ed3_cond==0
    display('error in ed conditions')
end