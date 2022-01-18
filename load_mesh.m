% load mesh
elements=load('elements.txt'); % n_elements x 3 matrix, saves the nodes indexes of each element
elements=elements+1; % e.g. el_1: 9 0 12 -> 10 1 13
bcs=load('bcs.txt');  % n_boundary_segments x 2 matrix, save the nodes indexes of each boundary segment
bcs=bcs+1;
nodes=load('nodes.txt'); % x,y coord of each node, 3122 nodes in total
domains=load('domains.txt'); % for each element, all 1?
edges=load('edges.txt'); % node indexes of all edges, 9203 edges in total
elementEdges=load('elementEdges.txt'); % saves the edge indexes of the 3 edges in an element
    % elementEdges(j,:)= the 3 edge indexes of the j_th element
Nel=size(elements,1);
Nedges=size(edges,1);
Nnodes=size(nodes,1);
Nbounds=size(bcs,1);

edge_type=zeros(Nedges,1);
edge_ngEl=zeros(Nedges,2); % saves the element index of the 2 neighbour elements of an edge
% ng:neighbour

for i=1:1:Nedges
    ctr=0;
    for j=1:1:Nel
        if ((elementEdges(j,1)==i)||(elementEdges(j,2)==i)||(elementEdges(j,3)==i))
            ctr=ctr+1;
            edge_ngEl(i,ctr)=j;
        end
        if ctr==2
            break
        end
    end
end

for i=1:1:Nnodes
   x_no(i)=nodes(i,1);
   y_no(i)=nodes(i,2);
   st_no(i)=0; % 0 or 1, marks if the node is boundary node
end

for i=1:1:Nbounds
   in=bcs(i,1);
   st_no(in)=1;
   in=bcs(i,2);
   st_no(in)=1;
end
    
    