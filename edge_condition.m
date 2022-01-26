% identify edge conditions: 
% 1 - inside domain, has a neighbour element
% 2 - on input port
% 3 - on output port
% 4 - on PEC

% verical ports
xp=0.; % Input
yp=0.12; % Output

% for edge 1
ngEl_ed1=-1; % ngEl_ed1：neighbour element of edge1
% find the ele index of the neighbour outside edge1
pos_neighbors=edge_ngEl(ed1in,:); % get the index of the 2 neighbour elements of edge1
if (pos_neighbors(1,1)==ei) && (pos_neighbors(1,2)>0.5) % if neighbour1 is the element itself and this edge not on boundary
    ngEl_ed1=pos_neighbors(1,2); % then neighbour2 is the neighbour element of edge1, save its element index
    element_info_ng1; % get the node coords, center, area, tq(?) of the this neighbour
    edge_type(ed1in)=1; % mark edge1 has a neighbor element

elseif (pos_neighbors(1,2)==ei) && (pos_neighbors(1,1)>0.5) % if neighbour2 is the element itself and this edge not on boundary
    ngEl_ed1=pos_neighbors(1,1); % then neighbour1 is the neighbour element of edge1, save its index
    element_info_ng1;
    edge_type(ed1in)=1; % mark edge1 has a neighbor element

elseif ((ngEl_ed1==-1) && (edge_type(ed1in)==0)) % either ng 1 or 2 is the element itself, so if ngEl_ed1 not assigned, means that this edge is on boundary
    if (abs(nd1x-nd2x)<0.0001 && abs(nd1x-xp)<0.0001) % if edge on input port
        edge_type(ed1in)=2; % mark edge1 is on the input port
    elseif (abs(nd1y-nd2y)<0.0001 && abs(nd1y-yp)<0.0001)
        edge_type(ed1in)=3; % mark edge1 is on the output port
    else
        edge_type(ed1in)=4; % mark edge1 is PEC
    end    
end

% for edge 2
ngEl_ed2=-1;
pos_neighbors=edge_ngEl(ed2in,:);
if (pos_neighbors(1,1)==ei) && (pos_neighbors(1,2)>0.5)
    ngEl_ed2=pos_neighbors(1,2);
    element_info_ng2;
    edge_type(ed2in)=1; % has a neighbor element
elseif (pos_neighbors(1,2)==ei) && (pos_neighbors(1,1)>0.5)
    ngEl_ed2=pos_neighbors(1,1);
    element_info_ng2;
    edge_type(ed2in)=1; % has a neighbor element
elseif ((ngEl_ed2==-1) && (ed2_cond==0))
    if (abs(nd2x-nd3x)<0.0001 && abs(nd2x-xp1)<0.0001) % if edge on input port
        edge_type(ed2in)=2; % mark edge2 is on the input port
    elseif (abs(nd2y-nd3y)<0.0001 && abs(nd2y-yp2)<0.0001)
        edge_type(ed2in)=3; % mark edge2 is on the output port
    else
        edge_type(ed2in)=4; % mark edge2 is PEC
    end 
end

% for edge 3
ngEl_ed3=-1;
pos_neighbors=edge_ngEl(ed3in,:);
if (pos_neighbors(1,1)==ei) && (pos_neighbors(1,2)>0.5)
    ngEl_ed3=pos_neighbors(1,2);
    element_info_ng3;
    edge_type(ed3in)=1; % has a neighbor element
elseif (pos_neighbors(1,2)==ei) && (pos_neighbors(1,1)>0.5)
    ngEl_ed3=pos_neighbors(1,1);
    element_info_ng3;
    edge_type(ed3in)=1; % has a neighbor element
elseif ((ngEl_ed3==-1) && (ed3_cond==0))
    if (abs(nd3x-nd1x)<0.0001 && abs(nd3x-xp1)<0.0001) % if edge on input port
        edge_type(ed3in)=2; % mark edge3 is on the input port
    elseif (abs(nd3y-nd1y)<0.0001 && abs(nd3y-yp2)<0.0001)
        edge_type(ed3in)=3; % mark edge3 is on the output port
    else
        edge_type(ed3in)=4; % mark edge3 is PEC
    end 
end


if edge_type(ed1in)==0 || edge_type(ed2in)==0 || edge_type(ed3in)==0
    display('error in edge conditions') %#ok<DISPLAYPROG>
end