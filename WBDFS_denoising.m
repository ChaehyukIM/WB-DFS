function [vxWBDFS, vyWBDFS, vzWBDFS] = WBDFS_denoising(vx,vy,vz,dx,dy,dz,mask,nx,ny,nz)

% WBDFS_denoising
% Inputs:
%     vx,vy,vz      - velocity data in x,y,z direction respectively
%     dx,dy,dz      - spatial resolution in x,y,z direction respectively
%     mask          - segmentation mask (logical)
%     nx,ny,nz      - blocksize in x,y,z direction respectively
%                     (recommended default = 8,8,8)
% Outputs:
%     vxWBDFS, vyWBDFS, vzWBDFS     - denoised velocity data using WBDFS
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

% convert double to single
% str = whos;
% for i = 1:length(str)
%     if strcmp(str(i).class,'double')
%         name = str(i).name;
%         assignin('base', name, single(evalin('base', name)));
%     end
% end

% WBDFS denoising for each block
Result=func_WBDFS(dx,dy,dz,blocknumberx,blocknumbery,blocknumberz,block,nx,ny,nz,EXC);

% Blocks with no flow are filled with zeros
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

[vxWBDFS,vyWBDFS,vzWBDFS] = func_block_assem(Result,blocknumberx,blocknumbery,blocknumberz,nx,ny,nz,vx);
