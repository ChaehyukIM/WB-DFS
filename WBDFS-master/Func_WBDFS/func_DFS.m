function [block]=func_DFS(dx,dy,dz,blocknumberx,blocknumbery,blocknumberz,block,nx,ny,nz,EXC)
% (c) Chaehyuk Im 2018

n=nx*ny*nz;
Dx=full(gallery('tridiag',nx,-1/2,0,1/2));
Dx(1,1)=-1;Dx(1,2)=1;Dx(nx,nx-1)=-1;Dx(nx,nx)=1;

Dy=full(gallery('tridiag',ny,-1/2,0,1/2));
Dy(1,1)=-1;Dy(1,2)=1;Dy(ny,ny-1)=-1;Dy(ny,ny)=1;

Dz=full(gallery('tridiag',nz,-1/2,0,1/2));
Dz(1,1)=-1;Dz(1,2)=1;Dz(nz,nz-1)=-1;Dz(nz,nz)=1;
% Define N matrix
Nx=full(gallery('tridiag',nx,1,-2,1));
Nx(1,1)=-1;Nx(nx,nx)=-1;

Ny=full(gallery('tridiag',ny,1,-2,1));
Ny(1,1)=-1;Ny(ny,ny)=-1;

Nz=full(gallery('tridiag',nz,1,-2,1));
Nz(1,1)=-1;Nz(nz,nz)=-1;
% A
Ix=eye(nx);Iy=eye(ny);Iz=eye(nz);
A=[kron(kron(Iz,Iy),Dx)/dx, kron(kron(Iz,Dy),Ix)/dy, kron(kron(Dz,Iy),Ix)/dz];

M=kron(kron(kron(eye(3),Iz),Iy),Nx^2)/dx^2 + kron(kron(kron(eye(3),Iz),Ny^2),Ix)/dy^2 ...
    + kron(kron(kron(eye(3),Nz^2),Iy),Ix)/dz^2 + kron(kron(kron(eye(3),Iz),Ny),Nx)*2/dx/dy ...
    + kron(kron(kron(eye(3),Nz),Ny),Ix)*2/dy/dz + kron(kron(kron(eye(3),Nz),Iy),Nx)*2/dx/dz ;

M=gpuArray(M);
A=gpuArray(A);
M=single(M);
A=single(A);
Psi=null(A);
TT=ctranspose(Psi)*M*Psi;

% [U,lambda,V]=svd(TT);
[Q,lambda]=eig(TT);

% Phi=Psi*U;
Phi=Psi*Q;

Phi=gpuArray(Phi);
lambda=gpuArray(lambda);

smin=0.02;
smax=1;

h = waitbar(0,'DFS calculating... Please wait...');
steps = sum(EXC(:));
step = 0;

for xx=1:blocknumberx
    for yy=1:blocknumbery
        for zz=1:blocknumberz
            if sum(block(xx,yy,zz).mask(:))~=0
                Uexp=gpuArray(block(xx,yy,zz).Uexp);
                Us=gpuArray(block(xx,yy,zz).Uexp);
                Us1=Us;   % Us(0)=Us=Uexp;
                syms x
                Usr= @(x) Phi*(gpuArray(eye(size(lambda,1))) + x*lambda)^-1*Phi'*Uexp;
%                 GCV2 = @(x) ((Usr(x)-Us1)'*(Usr(x)-Us1))/(3*n)/(1-trace((gpuArray(eye(size(lambda,1)))+x*lambda)^-1)/(3*n))^2;
                GCV2 = @(x) (norm(Usr(x)-Us1))^2/(3*n)/(1-trace((gpuArray(eye(size(lambda,1)))+x*lambda)^-1)/(3*n))^2;          % EQ 10
                
                s = fminbnd(GCV2,smin,smax); % minimize the smoothing parameter
                s2=s;    Us2=Usr(s2); % update Us(r)
                Us=Us2;                
                block(xx,yy,zz).us=zeros(nx,ny,nz); block(xx,yy,zz).vs=zeros(nx,ny,nz); block(xx,yy,zz).ws=zeros(nx,ny,nz);
                
                Us=gather(Us);
                for l=1:3
                    for k=1:nz
                        for j=1:ny
                            for i=1:nx
                                un=i+(j-1)*nx+(k-1)*nx*ny+(l-1)*n;
                                if l==1
                                    block(xx,yy,zz).us(i,j,k)=Us(un,1);
                                elseif l==2
                                    block(xx,yy,zz).vs(i,j,k)=Us(un,1);
                                elseif l==3
                                    block(xx,yy,zz).ws(i,j,k)=Us(un,1);
                                end
                            end
                        end
                    end
                end
                
                step = step + 1;
                waitbar(step / steps)                
                
            % Blocks without flow are filled with zeros
            elseif sum(block(xx,yy,zz).mask(:))==0  
                block(xx,yy,zz).us=zeros(nx,ny,nz);
                block(xx,yy,zz).vs=zeros(nx,ny,nz);
                block(xx,yy,zz).ws=zeros(nx,ny,nz);
            end            
        end
    end
end

close(h)