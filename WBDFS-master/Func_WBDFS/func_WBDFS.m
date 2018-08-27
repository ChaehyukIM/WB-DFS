function [block]=func_WBDFS(dx,dy,dz,blocknumberx,blocknumbery,blocknumberz,block,nx,ny,nz,EXC)
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

[U,lambda,V]=svd(TT);

Phi=Psi*U;

if gpuDeviceCount == 0
    Phi=gather(Phi);
    lambda=gather(lambda);
elseif gpuDeviceCount >= 1
    Phi=gpuArray(Phi);
    lambda=gpuArray(lambda);
end

smin=0;
smax=1;


h = waitbar(0,'WB-DFS calculating... Please wait...');
steps = sum(EXC(:));
step = 0;

for xx=1:blocknumberx
    for yy=1:blocknumbery
        for zz=1:blocknumberz
            if prod(block(xx,yy,zz).mask(:))~=0
                
                if gpuDeviceCount == 0
                    Uexp=gather(block(xx,yy,zz).Uexp);
                    Us=gather(block(xx,yy,zz).Uexp);
                elseif gpuDeviceCount >= 1
                    Uexp=gpuArray(block(xx,yy,zz).Uexp);
                    Us=gpuArray(block(xx,yy,zz).Uexp);
                end
                Us1=Us;
                syms x
                if gpuDeviceCount == 0
                    Usr= @(x) Phi*((eye(size(lambda,1))) + x*lambda)^-1*Phi'*Uexp;           % EQ 9
                    GCV2 = @(x) (norm(Usr(x)-Us1))^2/(3*n)/(1-trace(((eye(size(lambda,1)))+x*lambda)^-1)/(3*n))^2;          % EQ 10
                elseif gpuDeviceCount >= 1
                    Usr= @(x) Phi*(gpuArray(eye(size(lambda,1))) + x*lambda)^-1*Phi'*Uexp;           % EQ 9
                    GCV2 = @(x) (norm(Usr(x)-Us1))^2/(3*n)/(1-trace((gpuArray(eye(size(lambda,1)))+x*lambda)^-1)/(3*n))^2;          % EQ 10
                end
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
                
            elseif prod(block(xx,yy,zz).mask(:))==0  && EXC(xx,yy,zz)==1  % °æ°è¸é block
                A=gather(A);
                blockA=A;
                Mx=kron(kron(Iz,Iy),Nx^2)/dx^2;
                My=kron(kron(Iz,Ny^2),Ix)/dy^2;
                Mz=kron(kron(Nz^2,Iy),Ix)/dz^2;
                Mxy=kron(kron(Iz,Ny),Nx)*2/dx/dy;
                Myz=kron(kron(Nz,Ny),Ix)*2/dy/dz;
                Mxz=kron(kron(Nz,Iy),Nx)*2/dx/dz;
                
                for l=1:3
                    for i=1:nx
                        for j=1:ny
                            for k=1:nz   %  un=i+(j-1)*nx+(k-1)*nx*ny+(l-1)*n;
                                if block(xx,yy,zz).mask(i,j,k)==0
                                    if l==1      % Mxy
                                        Mxy(i+(j-1)*nx+(k-1)*nx*ny, 1 : nx*ny*nz )=zeros(1,nx*ny*nz);
                                        blockA(i+(j-1)*nx+(k-1)*nx*ny, 1+(j-1)*nx+(k-1)*nx*ny : nx+(j-1)*nx+(k-1)*nx*ny )=zeros(1,nx);
                                        Mx(i+(j-1)*nx+(k-1)*nx*ny, 1+(j-1)*nx+(k-1)*nx*ny : nx+(j-1)*nx+(k-1)*nx*ny )=zeros(1,nx);
                                    elseif l==2  % Myz
                                        Myz(i+(j-1)*nx+(k-1)*nx*ny, 1 : nx*ny*nz )=zeros(1,nx*ny*nz);
                                        for m=1:ny
                                            blockA(i+(j-1)*nx +(k-1)*nx*ny, i+(m-1)*nx+(k-1)*nx*ny  +(l-1)*n)=0;
                                            My(i+(j-1)*nx +(k-1)*nx*ny, i+(m-1)*nx+(k-1)*nx*ny)=0;
                                        end
                                    elseif l==3  % Dz -> (xx,yy) zz=1:nz
                                        Mxz(i+(j-1)*nx+(k-1)*nx*ny, 1 : nx*ny*nz )=zeros(1,nx*ny*nz);
                                        for m=1:nz
                                            blockA(i+(j-1)*nx +(k-1)*nx*ny, i+(j-1)*nx+(m-1)*nx*ny +(l-1)*n)=0;
                                            Mz(i+(j-1)*nx +(k-1)*nx*ny, i+(j-1)*nx+(m-1)*nx*ny)=0;
                                        end
                                    end
                                end
                                
                                
                                if l==1      % Mxy
                                    if i~=1
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i-1,j,k) > 0
                                            if j~=1
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-2)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Mx(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-1)*nx*ny)=5/dx^2;
                                            Mx(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            if i~=2
                                                Mx(i+(j-1)*nx+(k-1)*nx*ny,i-2+(j-1)*nx+(k-1)*nx*ny)=0;
                                            end
                                            if i~=nx
                                                Mx(i+1+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Mxy(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            blockA(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k-1)*nx*ny+(l-1)*n)=0;
                                            if j~=ny
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j)*nx+(k-1)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if i~=nx
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i+1,j,k) > 0
                                            if j~=1
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-2)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Mx(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-1)*nx*ny)=5/dx^2;
                                            Mx(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            if i~=nx-1
                                                Mx(i+(j-1)*nx+(k-1)*nx*ny,i+2+(j-1)*nx+(k-1)*nx*ny)=0;
                                            end
                                            if i~=1
                                                Mx(i-1+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Mxy(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            blockA(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k-1)*nx*ny+(l-1)*n)=0;
                                            if j~=ny
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j)*nx+(k-1)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if j~=1
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j-1,k) > 0
                                            if i~=1
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-2)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Mxy(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k-1)*nx*ny)=0;
                                            if i~=nx
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-2)*nx+(k-1)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if j~=ny
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j+1,k) > 0
                                            if i~=1
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Mxy(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k-1)*nx*ny)=0;
                                            if i~=nx
                                                Mxy(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j)*nx+(k-1)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    
                                elseif l==2
                                    if j~=1
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j-1,k) > 0
                                            if k~=1
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k-2)*nx*ny)=0;
                                            end
                                            My(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-1)*nx*ny)=5/dx^2;
                                            My(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k-1)*nx*ny)=0;
                                            if j~=2
                                                My(i+(j-1)*nx+(k-1)*nx*ny,i+(j-3)*nx+(k-1)*nx*ny)=0;
                                            end
                                            if j~=ny
                                                My(i+(j)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k-1)*nx*ny)=0;
                                            blockA(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k-1)*nx*ny+(l-1)*n)=0;
                                            if k~=nz
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if j~=ny
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j+1,k) > 0
                                            if k~=1
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k-2)*nx*ny)=0;
                                            end
                                            My(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-1)*nx*ny)=5/dx^2;
                                            My(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k-1)*nx*ny)=0;
                                            if j~=ny-1
                                                My(i+(j-1)*nx+(k-1)*nx*ny,i+(j+1)*nx+(k-1)*nx*ny)=0;
                                            end
                                            if j~=1
                                                My(i+(j-2)*nx+(k-1)*nx*ny,i+(j)*nx+(k-1)*nx*ny)=0;
                                            end
                                            Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k-1)*nx*ny)=0;
                                            blockA(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k-1)*nx*ny+(l-1)*n)=0;
                                            if k~=nz
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if k~=1
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j,k-1) > 0
                                            if j~=1
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k-2)*nx*ny)=0;
                                            end
                                            Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-2)*nx*ny)=0;
                                            if j~=ny
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k-2)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if k~=nz
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j,k+1) > 0
                                            if j~=1
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-2)*nx+(k)*nx*ny)=0;
                                            end
                                            Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k)*nx*ny)=0;
                                            if j~=ny
                                                Myz(i+(j-1)*nx+(k-1)*nx*ny,i+(j)*nx+(k)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    
                                elseif l==3
                                    if i~=1
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i-1,j,k) > 0
                                            if k~=1
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k-2)*nx*ny)=0;
                                            end
                                            Mxz(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            if k~=nz
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if i~=nx
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i+1,j,k) > 0
                                            if k~=1
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k-2)*nx*ny)=0;
                                            end
                                            Mxz(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k-1)*nx*ny)=0;
                                            if k~=nz
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if k~=1
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j,k-1) > 0
                                            if i~=1
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k-2)*nx*ny)=0;
                                            end
                                            Mz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-1)*nx*ny)=5/dx^2;
                                            Mz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-2)*nx*ny)=0;
                                            if k~=2
                                                Mz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-3)*nx*ny)=0;
                                            end
                                            if k~=nz
                                                Mz(i+(j-1)*nx+(k)*nx*ny,i+(j-1)*nx+(k-2)*nx*ny)=0;
                                            end
                                            Mxz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-2)*nx*ny)=0;
                                            blockA(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-2)*nx*ny+(l-1)*n)=0;
                                            if i~=nx
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k-2)*nx*ny)=0;
                                            end
                                        end
                                    end
                                    if k~=nz
                                        if block(xx,yy,zz).mask(i,j,k)-block(xx,yy,zz).mask(i,j,k+1) > 0
                                            if i~=1
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i-1+(j-1)*nx+(k)*nx*ny)=0;
                                            end
                                            Mz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k-1)*nx*ny)=5/dx^2;
                                            Mz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k)*nx*ny)=0;
                                            if k~=nz-1
                                                Mz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k+1)*nx*ny)=0;
                                            end
                                            if k~=1
                                                Mz(i+(j-1)*nx+(k-2)*nx*ny,i+(j-1)*nx+(k)*nx*ny)=0;
                                            end
                                            Mxz(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k)*nx*ny)=0;
                                            blockA(i+(j-1)*nx+(k-1)*nx*ny,i+(j-1)*nx+(k)*nx*ny+(l-1)*n)=0;
                                            if i~=nx
                                                Mxz(i+(j-1)*nx+(k-1)*nx*ny,i+1+(j-1)*nx+(k)*nx*ny)=0;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                Mx=kron(eye(3),Mx);                My=kron(eye(3),My);                Mz=kron(eye(3),Mz);
                Mxy=kron(eye(3),Mxy);                Myz=kron(eye(3),Myz);                Mxz=kron(eye(3),Mxz);
                M2=single(Mx+My+Mz+Mxy+Myz+Mxz);
                
                blockA=single(blockA);
                Psi2 = null(blockA);
                Psi2(isnan(Psi2))=0;
                
                TT2=ctranspose(Psi2)*M2*Psi2;
                
                % factorization using SVD
                [U2,lambda2,V2]=svd(TT2);
                
                Phi2=Psi2*U2;
                
                for k=1:nz
                    for j=1:ny
                        for i=1:nx
                            if block(xx,yy,zz).mask(i,j,k)==0
                                for l=1:3
                                    un=i+(j-1)*nx+(k-1)*nx*ny+(l-1)*n;
                                    Phi2(un,1:size(Phi2,2))=zeros(1,size(Phi2,2));
                                end
                            end
                        end
                    end
                end
                        
                if gpuDeviceCount == 0
                    Phi2=gather(Phi2);
                    lambda2=gather(lambda2);
                    Uexp=gather(block(xx,yy,zz).Uexp);
                    Us=gather(block(xx,yy,zz).Uexp);
                elseif gpuDeviceCount >= 1
                    Phi2=gpuArray(Phi2);
                    lambda2=gpuArray(lambda2);
                    Uexp=gpuArray(block(xx,yy,zz).Uexp);
                    Us=gpuArray(block(xx,yy,zz).Uexp);
                end              
                
                Us1=Us;   % Us(0)=Us=Uexp;
                syms x
                if gpuDeviceCount == 0
                    Usr= @(x) Phi2*((eye(size(lambda2,1))) + x*lambda2)^-1*Phi2'*Uexp;           % EQ 9
                    GCV2 = @(x) (norm(Usr(x)-Us1))^2/(3*n)/(1-trace(((eye(size(lambda2,1))) + x*lambda2)^-1)/(3*n))^2;      % EQ 10
                elseif gpuDeviceCount >= 1
                    Usr= @(x) Phi2*(gpuArray(eye(size(lambda2,1))) + x*lambda2)^-1*Phi2'*Uexp;           % EQ 9
                    GCV2 = @(x) (norm(Usr(x)-Us1))^2/(3*n)/(1-trace((gpuArray(eye(size(lambda2,1))) + x*lambda2)^-1)/(3*n))^2;      % EQ 10                    
                end
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