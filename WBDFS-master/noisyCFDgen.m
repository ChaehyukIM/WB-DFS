function [vx,vy,vz,vxN,vyN,vzN,mask] = noisyCFDgen(NL,STD,OUT,vox) 
% [vxN,vyN,vzN,mask] = noiyCFDgen(NL,STD,OUT,vox) 
% 
% This is created by Chaehyuk Im 2018
% 
% Input
%     NL    - Noise Level 0 ~ 1
%     STD   - the magnitude of range of standard deviation of outliers
%     OUT   - percantage of outlier's portion near wall
%     vox   - number of voxel from wall
%  
% Output
%     vx, vy, vz        - original velocity component
%     vxN, vyN, vzN     - noisy velocity component
%     mask              - segmenation mask
%  (c) Chaehyuk Im 2018
% 

% Ong's pipe data
load pipe.mat

mask=zeros(480,84,84);
mask(:,3:82,3:82)=imMag;

vxz=zeros(480,84,84);vyz=zeros(480,84,84);vzz=zeros(480,84,84);
vxz(:,3:82,3:82)=vx;vyz(:,3:82,3:82)=vy;vzz(:,3:82,3:82)=vz;

vx=vxz;vy=vyz;vz=vzz;

% Pipe boundary
B=zeros(3,3,3);
B(2,2,1)=1;
B(2,1,2)=-1;
B(2,3,2)=1;
B(2,2,3)=-1;

B2=zeros(3,3,3);
B2(2,2,1)=1;
B2(2,1,2)=1;
B2(2,3,2)=1;
B2(2,2,3)=1;

co=convn(mask,B,'same');
co2=convn(co,B2,'same');
co3=convn(co2,B2,'same');

imMask1=(co~=0);
Bd1=imMask1.*mask;

imMask2=(co2~=0);
Bd2=imMask2.*mask;

imMask3=(co3~=0);
Bd3=imMask3.*mask;

% Add noise at border
OUTd=100/OUT;
vxN=vx+(randn(size(vx))*sqrt(rms(vx(:)))*NL);
vyN=vy+(randn(size(vy))*sqrt(rms(vy(:)))*NL);
vzN=vz+(randn(size(vz))*sqrt(rms(vz(:)))*NL);
%outlier 2std of vx vy vz
uout=STD*2*std(vx(:))*(rand(size(vx))-0.5);
vout=STD*2*std(vy(:))*(rand(size(vy))-0.5);
wout=STD*2*std(vz(:))*(rand(size(vz))-0.5);
x=randi(size(vx,1),1,round(size(vx,1)*size(vx,2)*size(vx,3)/OUTd));
y=randi(size(vx,2),1,round(size(vx,1)*size(vx,2)*size(vx,3)/OUTd));
z=randi(size(vx,3),1,round(size(vx,1)*size(vx,2)*size(vx,3)/OUTd));
for i=1:size(x,2)
    mat(x(i),y(i),z(i))=1;
end

% Bd1=1 layer, Bd2 = 2 layers at border , Bd3 = 3 layers at border
if vox == 1
    Bd = Bd1;
elseif vox == 2
    Bd = Bd2;
elseif vox == 3
    Bd = Bd3;
else
    disp('Warning')
end
uout=uout.*mat.*Bd;
vout=vout.*mat.*Bd;
wout=wout.*mat.*Bd;
outlierpos = mat.*Bd;

vxN=(vxN+uout).*mask;
vyN=(vyN+vout).*mask;
vzN=(vzN+wout).*mask;

disp('Noisy Flow Error')
[vNRMSE_Noise,vMagErr_Noise,angErr_Noise] = calcVelError(mask,vx,vy,vz,vxN,vyN,vzN);
PVNR = 20*log10(1/vNRMSE_Noise);
fprintf('PVNR: \t\t\t%.2fdB\nNRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',PVNR,vNRMSE_Noise,vMagErr_Noise,angErr_Noise);