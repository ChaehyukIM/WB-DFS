function [vxWBDFS, vyWBDFS, vzWBDFS] = WBDFS_denoising(vx,vy,vz,dx,dy,dz,mask,nx,ny,nz)
%
% WBDFS_denoising
% Inputs:
%     vx,vy,vz      - velocity data(3D) in x,y,z direction respectively
%     dx,dy,dz      - spatial resolution in x,y,z direction respectively
%     mask          - segmentation mask (with flow - 1, without flow - 0)
%     nx,ny,nz      - blocksize in x,y,z direction respectively
%                     (recommended default = 8,8,8)
% Outputs:
%     vxWBDFS, vyWBDFS, vzWBDFS     - denoised velocity data using WBDFS
% 
% This function is created by Chaehyuk Im by applying wall boundary
% information into Divergence-free Smoothing method and using singular
% value decomposition
%
% (c) Chaehyuk Im 2018

% total number of block
% width of overlap regions are 4 voxels
blocknumberx=(size(vx,1)-4)/(nx-4);
blocknumbery=(size(vx,2)-4)/(ny-4);
blocknumberz=(size(vx,3)-4)/(nz-4);

% Divide velocity field into Blocks
[block]=func_block_divide(vx,vy,vz,nx,ny,nz,blocknumberx,blocknumbery,blocknumberz,mask);

% Exclude blocks that do not require calculation
for i=1:blocknumberx
    for j=1:blocknumbery
        for k=1:blocknumberz
            EXC(i,j,k)=(sum(block(i,j,k).mask(:))~=0);
        end
    end
end

% WBDFS denoising for each block
Result=func_WBDFS(dx,dy,dz,blocknumberx,blocknumbery,blocknumberz,block,nx,ny,nz,EXC);

[vxWBDFS,vyWBDFS,vzWBDFS] = func_block_assemble(Result,blocknumberx,blocknumbery,blocknumberz,nx,ny,nz,vx);
