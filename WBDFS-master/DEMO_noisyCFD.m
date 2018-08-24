% last updated 2018/08/24
clear;clc;

load pipe.mat

mask=zeros(480,84,84);
mask(:,3:82,3:82)=imMag;

vxz=zeros(480,84,84);vyz=zeros(480,84,84);vzz=zeros(480,84,84);
vxz(:,3:82,3:82)=vx;vyz(:,3:82,3:82)=vy;vzz(:,3:82,3:82)=vz;

vx=vxz;vy=vyz;vz=vzz;

vMag = sqrt(vx.^2+vy.^2+vz.^2); % Velocity magnitude
vMax = max(vMag(:));            % Maximum speed
FOV = size(vMag);               % Field of view
N = FOV(3);                     % Number of slices (for plotting)
res = [1,1,1];                  % Relative resolution

ph0 = zeros(FOV);               % Reference phase in phase contrast

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
NL=0.1; % noise level
STD=5;  % std range
OUT=30; % outlier percantage at border
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
Bd=Bd1;
uout=uout.*mat.*Bd;
vout=vout.*mat.*Bd;
wout=wout.*mat.*Bd;
outlierpos = mat.*Bd;

vxN=(vxN+uout).*mask;
vyN=(vyN+vout).*mask;
vzN=(vzN+wout).*mask;

vNMag=sqrt(vxN.^2+vyN.^2+vzN.^2);

disp('Noisy Flow Error')
[vNRMSE_Noise,vMagErr_Noise,angErr_Noise] = calcVelError(mask,vx,vy,vz,vxN,vyN,vzN);
PVNR = 20*log10(1/vNRMSE_Noise);
fprintf('PVNR: \t\t\t%.2fdB\nNRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',PVNR,vNRMSE_Noise,vMagErr_Noise,angErr_Noise);
%%
set(figure,'position',[800 100 200 800],'Color','w')
imagesc(vNMag(:,:,42));axis image
colormap jet
%% DivFree Wavelet with SureShrink and MAD sigma estimation
% Here, we use Median Absolute Deviation to estimate noise std
% and then use SureShrink to find the optimal threshold that minimizes MSE

minSize = 20*ones(1,3); % Smallest wavelet level size

% Denoise
[vxDFWsm,vyDFWsm,vzDFWsm] = dfwavelet_thresh_SURE_MAD(vxN,vyN,vzN,minSize,res);

% Calculate errors
disp('DivFree Wavelet w/ SureShrink and MAD')
[vNRMSE_DFWsm,vMagErr_DFWsm,angErr_DFWsm] = calcVelError(mask,vx,vy,vz,vxDFWsm,vyDFWsm,vzDFWsm);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_DFWsm,vMagErr_DFWsm,angErr_DFWsm);
pause(1);
%% DivFree Wavelet with SureShrink, MAD and random cycle spinning
% To remove the blocking artifacts, we do partial cycle spinning
% Here we do 2^3=8 random shifts

spins = 2;              % Number of cycle spinning per dimension
isRandShift = 1;        % Use random shift
minSize = 20*ones(1,3); % Smallest wavelet level size

% Denoise
[vxDFWsms,vyDFWsms,vzDFWsms] = dfwavelet_thresh_SURE_MAD_spin(vxN,vyN,vzN,minSize,res,spins,isRandShift);

% Calculate errors
disp('DivFree Wavelet w/ SureShrink, MAD and Partial Cycle Spinning')
[vNRMSE_DFWsms,vMagErr_DFWsms,angErr_DFWsms] = calcVelError(mask,vx,vy,vz,vxDFWsms,vyDFWsms,vzDFWsms);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_DFWsms,vMagErr_DFWsms,angErr_DFWsms);
pause(1);
% %%
%% FDM
% The following implements finite difference method denoising
% as described in:
% Song SM, Pelc NJ., et al. JMRI 1993
% Noise reduction in three-dimensional phase-contrast MR velocity measurementsl.

% Denoise
[vxFDM,vyFDM,vzFDM] = fdmDenoise(vxN,vyN,vzN,res);

% Calculate errors
disp('Finite Difference Method Error')
[vNRMSE_FDM,vMagErr_FDM,angErr_FDM] = calcVelError(mask,vx,vy,vz,vxFDM,vyFDM,vzFDM);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_FDM,vMagErr_FDM,angErr_FDM);
pause(1);

%% RBF
% This can take a while to run
% The following implements divergence-free radial basis function denoising
% as described in:
% Busch J, Kozerke S., et al. MRM 2012
% Construction of divergence-free velocity fields from cine 3D phase-contrast flow measurements.

radius = 9;     % Radius of kernel
nIter = 20;     % Number of iterations for lsqr

% Plot during iterations, if on, does gradient descent instead of lsqr
doplot = 0;


[vxRBF,vyRBF,vzRBF] = rbfDenoise(vxN,vyN,vzN,mask,radius,res,nIter,doplot);

% Calculate errors
disp('Radial Basis Function Error')
[vNRMSE_RBF,vMagErr_RBF,angErr_RBF] = calcVelError(mask,vx,vy,vz,vxRBF,vyRBF,vzRBF);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_RBF,vMagErr_RBF,angErr_RBF);
pause(1);
%% DFS
resol=1;
dx=resol; dy=resol; dz=resol;
nx=8;ny=8;nz=8; % blocksize
tic
[vxDFS, vyDFS, vzDFS] = DFS_denoising(vxN,vyN,vzN,dx,dy,dz,mask,nx,ny,nz);
toc
% Calculate errors
disp('Divergence Free Smoothing Error')
[vNRMSE_DFS,vMagErr_DFS,angErr_DFS] = calcVelError(mask,vx,vy,vz,vxDFS,vyDFS,vzDFS);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_DFS,vMagErr_DFS,angErr_DFS);
%% WB-DFS
fprintf('#3 WBDFS calculating \n')
tic
[vxWBDFS, vyWBDFS, vzWBDFS] = WBDFS_denoising(vxN,vyN,vzN,dx,dy,dz,mask,nx,ny,nz);
toc
%
% Calculate errors
disp('WB Divergence Free Smoothing Error')
[vNRMSE_DFSwb,vMagErr_DFSwb,angErr_DFSwb] = calcVelError(mask,vx,vy,vz,vxWBDFS,vyWBDFS,vzWBDFS);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_DFSwb,vMagErr_DFSwb,angErr_DFSwb);
%% Save
save(['DEMO_noisyCFD_' num2str(NL) '_STD_' num2str(STD) '_OUT_' num2str(OUT) datestr(datetime,'_yymmdd_HHMM') '.mat'],...
    'vx','vy','vz','vxN','vyN','vzN','vxFDM','vyFDM','vzFDM','vxRBF','vyRBF','vzRBF','vxDFWsm','vyDFWsm','vzDFWsm','vxDFWsms','vyDFWsms','vzDFWsms',...
    'vxDFS','vyDFS','vzDFS','vxWBDFS','vyWBDFS','vzWBDFS','mask','-v7.3')
fprintf('Result is saved \n')

%%
vxN = vxN .*mask;
vyN = vyN .*mask;
vzN = vzN .*mask;
vxFDM=vxFDM.*mask;
vyFDM=vyFDM.*mask;
vzFDM=vzFDM.*mask;
vxRBF=vxRBF.*mask;
vyRBF=vyRBF.*mask;
vzRBF=vzRBF.*mask;
vxDFWsm=vxDFWsm.*mask;
vyDFWsm=vyDFWsm.*mask;
vzDFWsm=vzDFWsm.*mask;
vxDFWsms=vxDFWsms.*mask;
vyDFWsms=vyDFWsms.*mask;
vzDFWsms=vzDFWsms.*mask;
vxDFS=vxDFS.*mask;
vyDFS=vyDFS.*mask;
vzDFS=vzDFS.*mask;
vxWBDFS=vxWBDFS.*mask;
vyWBDFS=vyWBDFS.*mask;
vzWBDFS=vzWBDFS.*mask;