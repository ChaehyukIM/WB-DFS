function [block]=func_block_divide(u,v,w,bsx,bsy,bsz,blocknumberx,blocknumbery,blocknumberz,mask)
% function to divide the entire field into blocks
%
% (c) Chaehyuk Im 2018

nx=bsx; ny=bsy; nz=bsz; n=nx*ny*nz;
block(blocknumberx,blocknumbery,blocknumberz).u=[];
block(blocknumberx,blocknumbery,blocknumberz).v=[];
block(blocknumberx,blocknumbery,blocknumberz).w=[];
block(blocknumberx,blocknumbery,blocknumberz).mask=[];
block(blocknumberx,blocknumbery,blocknumberz).Uexp=[];
for x=1:blocknumberx
    for y=1:blocknumbery
        for z=1:blocknumberz
            % Dividing the entire field into blocks with overlap region
            block(x,y,z).u=u(1+(x-1)*(bsx-4):bsx +(x-1)*(bsx-4) ,1+(y-1)*(bsy-4):bsy +(y-1)*(bsy-4), 1+(z-1)*(bsz-4):bsz +(z-1)*(bsz-4) );
            block(x,y,z).v=v(1+(x-1)*(bsx-4):bsx +(x-1)*(bsx-4) ,1+(y-1)*(bsy-4):bsy +(y-1)*(bsy-4), 1+(z-1)*(bsz-4):bsz +(z-1)*(bsz-4) );
            block(x,y,z).w=w(1+(x-1)*(bsx-4):bsx +(x-1)*(bsx-4) ,1+(y-1)*(bsy-4):bsy +(y-1)*(bsy-4), 1+(z-1)*(bsz-4):bsz +(z-1)*(bsz-4) );            
            block(x,y,z).mask=mask(1+(x-1)*(bsx-4):bsx +(x-1)*(bsx-4) ,1+(y-1)*(bsy-4):bsy +(y-1)*(bsy-4), 1+(z-1)*(bsz-4):bsz +(z-1)*(bsz-4));
            
            block(x,y,z).Uexp=zeros(3*n,1);
            
            % Changing the form from a matrix to one column
            for l=1:3
                for k=1:nz
                    for j=1:ny
                        for i=1:nx
                            un=i+(j-1)*nx+(k-1)*nx*ny+(l-1)*n;
                            if l==1
                                block(x,y,z).Uexp(un,1)=block(x,y,z).u(i,j,k) ;
                            elseif l==2
                                block(x,y,z).Uexp(un,1)=block(x,y,z).v(i,j,k) ;
                            elseif l==3
                                block(x,y,z).Uexp(un,1)=block(x,y,z).w(i,j,k) ;
                            end
                        end
                    end
                end
            end
        end
    end
end