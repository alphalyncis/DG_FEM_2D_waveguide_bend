clc; clear all; close all;

load_mesh;
numerical_quadrature_points;

% Parameters definition
% **************************************************************
d=0.02;                      % Distance of the waveguide plates 
f=10e9;                     % Frequency
Order=0;                    % Order of the even mode
eps1=1.;                    % Permittivity of the input branch of the waveguide
eps2=4.;                    % Permittivity of the waveguide discontinuity    
eps3=1.;                    % Permittivity of the output branch of the waveguide
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
axis([x_min_bc x_max_bc y_min_bc y_max_bc]);
hold on;
axis equal;
axis off;
mesh_plot;
bcs_plot;
axis on;

% matrix_assembly;
% dt=0.005/pi/2;       %% dt=0.005/pi/2 is sufficiently fine and good.
% Nt=ceil(1/dt);
% 
% u_elRK=zeros(Nel,Nt);
% u_allRK=zeros(3,Nel,Nt);

% %% initialize
% gauss_sigma=0.2;
% tIn=1;
% for ei=1:1:Nel
%     M=squeeze(M_all(ei,:,:)); F=squeeze(F_all(:,ei));
%     element_info_lin;
%     gauss_exponent = ((cx-0.2).^2 + (cy-0.2).^2)./(2*gauss_sigma^2);
%     gauss_amplitude = 1 / (gauss_sigma * sqrt(2*pi));
%     gauss_val       = gauss_amplitude  * exp(-gauss_exponent);
%     if gauss_val<1e-4
%         gauss_val=0;
%     end
%     ini_left=M;
%     ini_right=gauss_val.*F;
%     u_allRK(:,ei,1)=ini_left\ini_right;
%     
%     u_elRK(ei,1)=(1/(2*areatr))*(u_allRK(1,ei,1)*(a1+b1*cx+c1*cy)+u_allRK(2,ei,1)*(a2+b2*cx+c2*cy)+u_allRK(3,ei,1)*(a3+b3*cx+c3*cy));
% end
% 
% 
% figure('pos',[50 50 750 750]);
% plot_rotatingHill;
% drawnow;
% hold on;
% %% main time loop
% for tIn=2:1:Nt
%     tnow=dt*(tIn-1);
%     for ei=1:1:Nel
%         A=zeros(3,3); b=zeros(3,1);
%         M=squeeze(M_all(ei,:,:));       N1=squeeze(N1_all(ei,:,:));     N2=squeeze(N2_all(ei,:,:));
%         F1=squeeze(Fe1_all(:,ei));      F2=squeeze(Fe2_all(:,ei));      F3=squeeze(Fe3_all(:,ei));
%         element_info_lin;
%         edge_cond_rotatingHill;
%         
%         BDF_stepping;
%     end
%     
%     [tnow, tIn, max(u_elRK(:,tIn)), max(u_elRK(:,1)), min(u_elRK(:,tIn))]
% 
%     if (mod(tIn,5)==0)
%         plot_rotatingHill;
%         drawnow;
%         hold on;
%     end
% end
% 
% 
% plot_rotatingHill;
% hold off;
