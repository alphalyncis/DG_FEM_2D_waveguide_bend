clc; clear all; close all;

load_mesh;
numerical_quadrature_points;

% Parameters definition
% **************************************************************
d=0.02;                      % Distance of the waveguide plates 
f=10e9;                     % Frequency (1st mode between 7.5-15e9 Hz)
Order=0;                    % Order of the even mode
eps1=1.;                    % Permittivity of the input/output branch of the waveguide
eps2=4.;                    % Permittivity of the waveguide discontinuity
%imj=sqrt(-1);
mu0=4*pi*1.e-7;             % Mag. permeability of vacuum
eps0=8.85e-12;              % Diel. permittivity of vacuum
c0=1/sqrt(mu0*eps0);
omega=2*pi*f;               % Angular frequency
k0=omega*sqrt(mu0*eps0);    % Free space wave-vector
ky=(2*Order+1)*pi/d;        % Even modes
kx=sqrt(k0^2-ky^2);         % Guiding mode propagation constant
% E0=1.;                                % Amplitude of the input signal
E0=sqrt(2)*sqrt(2*omega*mu0/(kx*d));    % Normalized input signal:Pin=1
solver=1;                   % 1 - sparse matrix solver; 2 - GMRES iterative solver

[x_min_bc,y_min_bc,y_max_bc,x_max_bc]=find_boundaries(Nnodes,x_no,y_no);
boundary_nodes; % excludes the input and output ports from boundary nodes

% Plot mesh and boundary nodes
figure(1);
axis([x_min_bc x_max_bc y_min_bc y_max_bc]);
axis equal;
axis off;
hold on;
mesh_plot;
bcs_plot;
axis on;

matrix_assembly;
dt=0.0002e-9;
Nt=50;

Ez_el=zeros(Nel,Nt);
Ez_all=zeros(3,Nel,Nt);
%Ez_all(1,463,2)=E0;

%% initialize
% tIn=1;
% Ereal_el=real(Ez_el);
% plot_Ez;
% drawnow;
% hold on;

%% main time loop
for tIn=3:1:Nt
    tnow=dt*(tIn-1);
    count=0;
    
    for ei=1:1:Nel
        M=squeeze(M_all(ei,:,:));       N=squeeze(N_all(ei,:,:));     
        element_info_lin;
        edge_condition; % identify edge type (1-inside domain, 2-input port, 3-output port, 4-PEC)
        edge_contribution_testwp; % integral contribution of the edges

        % solve locally
        % temp_Ez=zeros(3,1);
        left_ei=(1/dt^2).*N + M + (1/dt).*K_el;
        right_ei=((2/dt^2).*N + (1/dt).*K_el)*Ez_all(:,ei,tIn-1) - (1/dt^2).*(N*Ez_all(:,ei,tIn-2)) + b_el+F_ed1+F_ed2+F_ed3;
        temp_Ez=left_ei\right_ei;
        
        Ez_all(:,ei,tIn)=temp_Ez(:,1);
        limit_slope_lin;
        Ez_all(1,465,tIn)=Ez_all(1,465,tIn)+E0*cos(omega*tnow); % Nr.463
        % calc field value of the element from the 3 nodal values weighted by Ni
        Ez_el(ei,tIn)=(1/(2*areatr))*(Ez_all(1,ei,tIn)*(a1+b1*cx+c1*cy)+Ez_all(2,ei,tIn)*(a2+b2*cx+c2*cy)+Ez_all(3,ei,tIn)*(a3+b3*cx+c3*cy));
    end
    
    % print results and plot at each time n steps
    if (mod(tIn,1)==0)
        [tnow, tIn, max(Ez_el(:,tIn)), max(Ez_el(:,tIn)), min(Ez_el(:,tIn))] %#ok<NOPTS>
        %Ereal_el=real(Ez_el);
        figure(2)
        plot_Ez;
        drawnow;
        hold on;
    end
end

hold off;
