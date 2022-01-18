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
imj=sqrt(-1);
mu0=4*pi*1.e-7;             % Mag. permeability of vacuum
eps0=8.85e-12;              % Diel. permittivity of vacuum
c=1/sqrt(mu0*eps0);
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
hold on;
axis equal;
axis off;
mesh_plot;
bcs_plot;
axis on;

matrix_assembly;
dt=0.05e-6;       %% dt=0.005/pi/2 is sufficiently fine and good.
Nt=3;

Ez_el=zeros(Nel,Nt);
Ez_all=zeros(3,Nel,Nt);

%% initialize
tIn=1;

figure(2);
Ereal_el=real(Ez_el);
plot_Ez;
drawnow;
hold on;
%% main time loop
% for tIn=2:1:Nt
%     tnow=dt*(tIn-1);
for ei=1:1:Nel
    %A=zeros(3,3); b=zeros(3,1);
    M=squeeze(M_all(ei,:,:));       N=squeeze(N_all(ei,:,:));     
    %F1=squeeze(Fe1_all(:,ei));      F2=squeeze(Fe2_all(:,ei));      F3=squeeze(Fe3_all(:,ei));
    element_info_lin;
    edge_condition;
    edge_contribution; % add the matrix contribution of the edges
end

%         edge_contribution; % add the matrix contribution of the edges
%         
%         % solve locally
%         left_ei=(1/dt).*M;
%         right_ei=(1/dt).*(M*u_allRK(:,ei,tIn-1))+2*pi.*((N1-N2)*u_allRK(:,ei,tIn-1))+(K1_e1+K1_e2+K1_e3)+(K2_e1+K2_e2+K2_e3);
%         temp_u=left_ei\right_ei;
% 
%         limit_slope_lin;
% 
%         % calc field value of the element from the 3 nodal values weighted by Ni
%         Ez_el(ei,tIn)=(1/(2*areatr))*(u_allRK(1,ei,tIn)*(a1+b1*cx+c1*cy)+u_allRK(2,ei,tIn)*(a2+b2*cx+c2*cy)+u_allRK(3,ei,tIn)*(a3+b3*cx+c3*cy));
%     end
%     
%     [tnow, tIn, max(Ez_el(:,tIn)), max(Ez_el(:,1)), min(Ez_el(:,tIn))]
% 
%     if (mod(tIn,2)==0)
%         plot_rotatingHill;
%         drawnow;
%         hold on;
%     end
% end
% 
% 
% plot_rotatingHill;
% hold off;
