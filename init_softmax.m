function [layer] = init_softmax()
%ÝNÝT_RELU Summary of this function goes here
% leakage is a boolean denoting whether it is usual relu or prelu
% leakparam is the (out/in) at the negative side.

layer=struct();
layer.type='softmax';

end

