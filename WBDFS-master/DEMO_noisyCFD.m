%% DEMO_noisyCFD
%
% 2018/08/27 updated
% Modified from Ong's demo_cfd.m
%
%% load data and 
clear;clc;

load pipe.mat

[vx,vy,vz,vxN,vyN,vzN,mask] = noisyCFDgen(0.1, 5, 30, 1);

clear imMag
vNMag=sqrt(vxN.^2+vyN.^2+vzN.^2);
res = [1,1,1];
%%
set(figure,'position',[800 100 200 800],'Color','w')
imagesc(vNMag(:,:,42));axis image
colormap jet
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

%% DFWs
% To remove the blocking artifacts, we do partial cycle spinning
% Here we do 2^3=8 random shifts
% as described in:
% Song SM, Pelc NJ., et al. JMRI 1993
% Noise reduction in three-dimensional phase-contrast MR velocity measurementsl.

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
% The following implements divergence-free smoothing method
% as described in:
% Wang C, Gao Q, Wang H, Wei R, Li T, Wang J. Experiments in Fluids 2016
% Divergence-free smoothing for volumetric PIV data.

dx=res(1); dy=res(2); dz=res(3);
nx=8;ny=8;nz=8; % blocksize
tic
[vxDFS, vyDFS, vzDFS] = DFS_denoising(vxN,vyN,vzN,dx,dy,dz,mask,nx,ny,nz);
toc
% Calculate errors
disp('Divergence Free Smoothing Error')
[vNRMSE_DFS,vMagErr_DFS,angErr_DFS] = calcVelError(mask,vx,vy,vz,vxDFS,vyDFS,vzDFS);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_DFS,vMagErr_DFS,angErr_DFS);
%% WB-DFS
% The following implements WB-DFS
% will be described in:
% Chaehyuk Im,Seungbin Ko., et al. 2018
% Divergence-free Smoothing for Denoising 4D-Flow MRI Measurements of a Wall-bounded Flow

fprintf('#3 WBDFS calculating \n')
tic
[vxWBDFS, vyWBDFS, vzWBDFS] = WBDFS_denoising(vxN,vyN,vzN,dx,dy,dz,mask,nx,ny,nz);
toc
%
% Calculate errors
disp('WB Divergence Free Smoothing Error')
[vNRMSE_DFSwb,vMagErr_DFSwb,angErr_DFSwb] = calcVelError(mask,vx,vy,vz,vxWBDFS,vyWBDFS,vzWBDFS);
fprintf('NRMSE: \t\t\t%f\nvMag Error: \t\t%f\nAbsolute Angle Error: \t%f\n\n',vNRMSE_DFSwb,vMagErr_DFSwb,angErr_DFSwb);

%% masking
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
%% Save
save(['DEMO_noisyCFD_' num2str(NL) '_STD_' num2str(STD) '_OUT_' num2str(OUT) datestr(datetime,'_yymmdd_HHMM') '.mat'],...
    'vx','vy','vz','vxN','vyN','vzN','vxFDM','vyFDM','vzFDM','vxDFWsms','vyDFWsms','vzDFWsms','vxRBF','vyRBF','vzRBF',...
    'vxDFS','vyDFS','vzDFS','vxWBDFS','vyWBDFS','vzWBDFS','mask','-v7.3')
fprintf('Result is saved \n')