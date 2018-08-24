function [wholeUS,wholeVS,wholeWS]=func_block_assemble(Result,blocknumberx,blocknumbery,blocknumberz,bsx,bsy,bsz,u)
% function to assemble blocks into the entire field
%
% (c) Chaehyuk Im 2018


% apply weight factor into the blocks
for xxx=1:blocknumberx
    for yyy=1:blocknumbery
        for zzz=1:blocknumberz
            if xxx >=2 && xxx<= blocknumberx-1 && yyy >=2 && yyy<=blocknumbery-1 && zzz>=2 && zzz<=blocknumberz-1
                for i=1:bsx
                    for j=1:bsy
                        for k=1:bsz
                            if i==1 || i==bsx || j==1 || j==bsy || k==1 || k==bsz
                                Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                            end
                            if i==2 || i==bsx-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if i==3 || i==bsx-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if j==2 || j==bsy-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if j==3 || j==bsy-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if k==2 || k==bsz-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if k==3 || k==bsz-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                        end
                    end
                end
            elseif (xxx==1 || xxx==blocknumberx) && (yyy==1 || yyy==blocknumbery) && (zzz==1 ||zzz==blocknumberz)  % type1
                if xxx==1 && yyy==1 && zzz==1               %(1,1,1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || (j==bsy && blocknumbery~=1) || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && yyy==1 && zzz==1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || (j==bsy && blocknumbery~=1) || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx==1 && (yyy==blocknumbery && blocknumbery~=1) && zzz==1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || j==1 || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx==1 && yyy==1 && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || (j==bsy && blocknumbery~=1) || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && (yyy==blocknumbery && blocknumbery~=1) && zzz==1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || j==1 || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && yyy==1 && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || (j==bsy && blocknumbery~=1) || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx==1 && (yyy==blocknumbery && blocknumbery~=1) && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || j==1 || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && (yyy==blocknumbery && blocknumbery~=1) && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || j==1 || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                end
            elseif xxx==1 && yyy ~=1 && yyy~=blocknumbery && zzz ~=1 && zzz~=blocknumberz
                for i=1:bsx
                    for j=1:bsy
                        for k=1:bsz
                            if (i==bsx && blocknumberx~=1) || j==1 || j==bsy || k==1 || k==bsz
                                Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                            end
                            if (i==bsx-1 && blocknumberx~=1)
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if (i==bsx-2 && blocknumberx~=1)
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if j==2 || j==bsy-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if j==3 || j==bsy-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if k==2 || k==bsz-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if k==3 || k==bsz-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                        end
                    end
                end
            elseif (xxx==blocknumberx && blocknumberx~=1) && yyy ~=1 && yyy~=blocknumbery && zzz ~=1 && zzz~=blocknumberz
                for i=1:bsx
                    for j=1:bsy
                        for k=1:bsz
                            if i==1 || j==1 || j==bsy || k==1 || k==bsz
                                Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                            end
                            if i==2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if i==3
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if j==2 || j==bsy-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if j==3 || j==bsy-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if k==2 || k==bsz-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if k==3 || k==bsz-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                        end
                    end
                end
            elseif xxx~=1 && xxx~=blocknumberx && yyy ==1 && zzz ~=1 && zzz~=blocknumberz
                for i=1:bsx
                    for j=1:bsy
                        for k=1:bsz
                            if i==1 || i==bsx || (j==bsy && blocknumbery~=1) || k==1 || k==bsz
                                Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                            end
                            if i==2 || i==bsx-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if i==3 || i==bsx-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if (j==bsy-1 && blocknumbery~=1)
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if (j==bsy-2 && blocknumbery~=1)
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if k==2 || k==bsz-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if k==3 || k==bsz-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                        end
                    end
                end
            elseif xxx~=1 && xxx~=blocknumberx && (yyy ==blocknumbery && blocknumbery~=1) && zzz ~=1 && zzz~=blocknumberz
                for i=1:bsx
                    for j=1:bsy
                        for k=1:bsz
                            if i==1 || i==bsx || j==1 || k==1 || k==bsz
                                Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                            end
                            if i==2 || i==bsx-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if i==3 || i==bsx-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if j==2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if j==3
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if k==2 || k==bsz-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if k==3 || k==bsz-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                        end
                    end
                end
            elseif xxx~=1 && xxx~=blocknumberx && yyy ~=1 && yyy~=blocknumbery && zzz ==1
                for i=1:bsx
                    for j=1:bsy
                        for k=1:bsz
                            if i==1 || i==bsx || j==1 || j==bsy || (k==bsz && blocknumberz~=1)
                                Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                            end
                            if i==2 || i==bsx-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if i==3 || i==bsx-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if j==2 || j==bsy-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if j==3 || j==bsy-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if (k==bsz-1 && blocknumberz~=1)
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if (k==bsz-2 && blocknumberz~=1)
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                        end
                    end
                end
            elseif xxx~=1 && xxx~=blocknumberx && yyy ~=1 && yyy~=blocknumbery && (zzz ==blocknumberz && blocknumberz~=1)
                for i=1:bsx
                    for j=1:bsy
                        for k=1:bsz
                            if i==1 || i==bsx || j==1 || j==bsy || k==1
                                Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                            end
                            if i==2 || i==bsx-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if i==3 || i==bsx-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if j==2 || j==bsy-1
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if j==3 || j==bsy-2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                            if k==2
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                            end
                            if k==3
                                Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                            end
                        end
                    end
                end
            else
                if xxx==1 && yyy==1 && zzz>=2 &&zzz<=blocknumberz-1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || (j==bsy && blocknumbery~=1) || k==1 || k==bsz
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2 || k==bsz-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3 || k==bsz-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx==1 && (yyy==blocknumbery && blocknumbery~=1) && zzz>=2 && zzz<=blocknumberz-1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || j==1 || k==1 || k==bsz
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2 || k==bsz-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3 || k==bsz-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && yyy==1 && zzz>=2 && zzz<=blocknumberz-1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || (j==bsy && blocknumbery~=1) || k==1 || k==bsz
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2 || k==bsz-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3 || k==bsz-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && (yyy==blocknumbery && blocknumbery~=1) && zzz>=2 && zzz<=blocknumberz-1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || j==1 || k==1 || k==bsz
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2 || k==bsz-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3 || k==bsz-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx==1 && yyy>=2 && yyy<=blocknumbery-1 && zzz==1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || j==1 || j==bsy || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2 || j==bsy-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3 || j==bsy-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx==1 && yyy>=2 && yyy<=blocknumbery-1 && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if (i==bsx && blocknumberx~=1) || j==1 || j==bsy || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if (i==bsx-1 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (i==bsx-2 && blocknumberx~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2 || j==bsy-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3 ||  j==bsy-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && yyy>=2 && yyy<=blocknumbery-1 && zzz==1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || j==1 || j==bsy || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2 || j==bsy-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3 || j==bsy-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif (xxx==blocknumberx && blocknumberx~=1) && yyy>=2 && yyy<=blocknumbery-1 && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || j==1 || j==bsy || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2 || j==bsy-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3 || j==bsy-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx>=2 && xxx<=blocknumberx-1 && yyy==1 && zzz==1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || i==bsx || (j==bsy && blocknumbery~=1) || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2 || i==bsx-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3 || i==bsx-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx>=2 && xxx<=blocknumberx-1 && yyy==1 && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || i==bsx || (j==bsy && blocknumbery~=1) || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2 || i==bsx-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3 || i==bsx-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (j==bsy-1 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (j==bsy-2 && blocknumbery~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx>=2 && xxx<=blocknumberx-1 && (yyy==blocknumbery && blocknumbery~=1) && zzz==1
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || i==bsx || j==1 || (k==bsz && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2 || i==bsx-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3 || i==bsx-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if (k==bsz-1 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if (k==bsz-2 && blocknumberz~=1)
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                elseif xxx>=2 && xxx<=blocknumberx-1 && (yyy==blocknumbery && blocknumbery~=1) && (zzz==blocknumberz && blocknumberz~=1)
                    for i=1:bsx
                        for j=1:bsy
                            for k=1:bsz
                                if i==1 || i==bsx || j==1 || k==1
                                    Result(xxx,yyy,zzz).us(i,j,k)=0;  Result(xxx,yyy,zzz).vs(i,j,k)=0;  Result(xxx,yyy,zzz).ws(i,j,k)=0;
                                end
                                if i==2 || i==bsx-1
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if i==3 || i==bsx-2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if j==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if j==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                                if k==2
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)/3;
                                end
                                if k==3
                                    Result(xxx,yyy,zzz).us(i,j,k)=Result(xxx,yyy,zzz).us(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).vs(i,j,k)=Result(xxx,yyy,zzz).vs(i,j,k)*2/3;
                                    Result(xxx,yyy,zzz).ws(i,j,k)=Result(xxx,yyy,zzz).ws(i,j,k)*2/3;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

wholeUS=zeros(size(u));
wholeVS=zeros(size(u));
wholeWS=zeros(size(u));

% Assembling blocks into an entire field
for xx=1:blocknumberx
    for yy=1:blocknumbery
        for zz=1:blocknumberz
            wholeUS(1+(xx-1)*(bsx-4):bsx +(xx-1)*(bsx-4) ,1+(yy-1)*(bsy-4):bsy +(yy-1)*(bsy-4), 1+(zz-1)*(bsz-4):bsz +(zz-1)*(bsz-4)) ...
                = real(wholeUS(1+(xx-1)*(bsx-4):bsx +(xx-1)*(bsx-4) ,1+(yy-1)*(bsy-4):bsy +(yy-1)*(bsy-4), 1+(zz-1)*(bsz-4):bsz +(zz-1)*(bsz-4)) + Result(xx,yy,zz).us);
            wholeVS(1+(xx-1)*(bsx-4):bsx +(xx-1)*(bsx-4) ,1+(yy-1)*(bsy-4):bsy +(yy-1)*(bsy-4), 1+(zz-1)*(bsz-4):bsz +(zz-1)*(bsz-4))...
                = real(wholeVS(1+(xx-1)*(bsx-4):bsx +(xx-1)*(bsx-4) ,1+(yy-1)*(bsy-4):bsy +(yy-1)*(bsy-4), 1+(zz-1)*(bsz-4):bsz +(zz-1)*(bsz-4)) + Result(xx,yy,zz).vs);
            wholeWS(1+(xx-1)*(bsx-4):bsx +(xx-1)*(bsx-4) ,1+(yy-1)*(bsy-4):bsy +(yy-1)*(bsy-4), 1+(zz-1)*(bsz-4):bsz +(zz-1)*(bsz-4))...
                = real(wholeWS(1+(xx-1)*(bsx-4):bsx +(xx-1)*(bsx-4) ,1+(yy-1)*(bsy-4):bsy +(yy-1)*(bsy-4), 1+(zz-1)*(bsz-4):bsz +(zz-1)*(bsz-4)) + Result(xx,yy,zz).ws);
            
        end
    end
end