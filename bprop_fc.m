function [ layer,layererr,current_update_b ] = bprop_fc( above_error,above_w,z,layer_input,layer,blrate,wlrate,momentum,last_update_b)
%UNTÝTLED7 Summary of this function goes here
%   backpropagation for fc layer

if ~strcmp(layer.type,'fc')
    error('wrong layer type!')
end

if isstruct(layer.nonlin)
if strcmp(layer.nonlin.type,'relu');
   
   layererr=above_w'*above_error.*arrayfun(@(d) drelu(d,layer.nonlin.leakparam),z);

elseif strcmp(layer.nonlin.type,'sigmoid');
  
    layererr=above_w'*above_error.*arrayfun(@(d) dsigm(d,layer.nonlin.alpha),z);
    
%elseif strcmp(layer.nonlin.type,'softmax');
  
  %  layererr=above_w'.*arrayfun(@dsoftmax,above_error,z, );
end
else
    layererr=above_w'*above_error;
   
end
current_update_b=blrate*layererr+last_update_b*momentum;
layer.bias=layer.bias-current_update_b;
% size(layererr)
% size(layer_input)
wgradient=layererr(:)*layer_input(:)';
%wgradient=wgradient(:);
layershape=size(layer.weights);
% size(wgradient)
% size(layer.weights)
wgradient=reshape(wgradient,size(layer.weights));

layer.weights=layer.weights-wlrate*wgradient;


end

