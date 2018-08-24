% Make file for mex functions


mex -compatibleArrayDims -I./src ./dfwavelet_forward.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfwavelet_inverse.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfsoft_thresh.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfwavelet_thresh.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfwavelet_thresh_spin.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfSUREshrink.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfwavelet_thresh_SURE.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfwavelet_thresh_SURE_spin.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./getMADsigma.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfwavelet_thresh_SURE_MAD.cpp ./src/dfwavelet.cpp

mex -compatibleArrayDims -I./src ./dfwavelet_thresh_SURE_MAD_spin.cpp ./src/dfwavelet.cpp
