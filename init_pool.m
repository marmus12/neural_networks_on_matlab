function [ layer ] = init_pool( pooltype,kernel,stride,pads )
%POOL Summary of this function goes here
%   Pooltype can be 'max','ave'
%pads should be 1x2 or 2x1 array
layer=struct();
layer.kernel=kernel;
layer.stride=stride;
layer.type='pool';
layer.pads=pads;
layer.pooltype=pooltype;

end

