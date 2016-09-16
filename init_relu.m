function [ relulayer] = init_relu(leakparam)
%ÝNÝT_RELU Summary of this function goes here
% leakage is a boolean denoting whether it is usual relu or prelu
% leakparam is the (out/in) at the negative side.

relulayer=struct();
relulayer.type='relu';
relulayer.leakparam=leakparam;
end

