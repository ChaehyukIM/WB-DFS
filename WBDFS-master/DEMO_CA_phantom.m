% DEMO_CA_phantom
clc;clear;
load CA_phantom.mat
%
VX_WBDFS=cell(size(VX_FILTERED,1),1);
VY_WBDFS=cell(size(VX_FILTERED,1),1);
VZ_WBDFS=cell(size(VX_FILTERED,1),1);

for timestep = 1:length(VX_FILTERED)    
    tic
    vx=cell2mat(VX_FILTERED(timestep));vy=cell2mat(VY_FILTERED(timestep));vz=cell2mat(VZ_FILTERED(timestep));
        
    nx=8; ny=8; nz=8; % blocksize , num of block: 24x11x7
%     nx=10; ny=15; nz=11; % blocksize  , num of block: 16x4x4
    res = [1,1,1];
    dx=res(1);dy=res(2);dz=res(3);
    
    [vxWBDFS, vyWBDFS, vzWBDFS] = WBDFS_denoising(vx,vy,vz,dx,dy,dz,mask,nx,ny,nz);
    
    VX_WBDFS{timestep}=vxWBDFS;
    VY_WBDFS{timestep}=vyWBDFS;
    VZ_WBDFS{timestep}=vzWBDFS;
    
    toc
end
clear nx ny nz dx dy dz timestep

save(['DEMO_CA_phantom_WBDFS_' datestr(datetime,'_yymmdd_HHMM') '.mat'],...
    'VX_FILTERED','VY_FILTERED','VZ_FILTERED','VX_WBDFS','VY_WBDFS','VZ_WBDFS','mask','-v7.3')
fprintf('Result is saved \n')