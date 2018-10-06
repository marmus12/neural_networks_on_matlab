function [ backerr,loss,losstype ] = l2loss(label,output )
%LOSS Summary of this function goes here
%   label and output are of same size, same shape
% [ backerr,loss,losstype ] = l2loss(label,output )
losstype='l2';
shape=size(label);
shape2=size(output);

if ~isequal(shape,shape2)
    error('Label and Output should be the same shape!')
end

loss=0.5*sum(sum(sum((label-output).^2)));
backerr=output-label; %%gradient of Loss wrt output vector

end

