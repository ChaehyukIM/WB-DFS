function [vxDFS, vyDFS, vzDFS] = DFS_denoising(vx,vy,vz,dx,dy,dz,mask,nx,ny,nz)
% 
% DFS_denoising
% Inputs:
%     vx,vy,vz      - velocity data in x,y,z direction respectively
%     dx,dy,dz      - spatial resolution in x,y,z direction respectively
%     mask          - segmentation mask (logical)
%     nx,ny,nz      - blocksize in x,y,z direction respectively
%                     (recommended default = 8,8,8)
% Outputs:
%     vxDFS, vyDFS, vzDFS     - denoised velocity data using DFS
% 
%
% This function is created by Chaehyuk Im based on the detailed description of Wang's paper
% Wang C, Gao Q, Wang H, Wei R, Li T, Wang J. Divergence-free smoothing for volumetric PIV data. Experiments in Fluids 2016;57(1):15.
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

% DFS denoising for each block
Result=func_DFS(dx,dy,dz,blocknumberx,blocknumbery,blocknumberz,block,nx,ny,nz,EXC);

% Blocks without flow are filled with zeros
for xx=1:blocknumberx
    for yy=1:blocknumbery
        for zz=1:blocknumberz
            if sum(block(xx,yy,zz).mask(:))==0  
                Result(xx,yy,zz).us=zeros(nx,ny,nz);
                Result(xx,yy,zz).vs=zeros(nx,ny,nz);
                Result(xx,yy,zz).ws=zeros(nx,ny,nz);
            end
        end
    end
end

[vxDFS,vyDFS,vzDFS] = func_block_assemble(Result,blocknumberx,blocknumbery,blocknumberz,nx,ny,nz,vx);
