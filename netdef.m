tic
net=struct();
%% convolutional stage
net.layers={};
% net.layers{1,1}=init_conv(3,1,20,[1 1]);
% net.layers{2,1}=init_sigmoid(0.25);
% net.layers{3,1}=init_conv(3,1,20,[1 1]);
% net.layers{4,1}=init_sigmoid(0.25);
input=train_images(:,1); %% sample input 
input_shape=size(input);
%% this step is for obtaining input shapes (optional for conv layers, mandatory for fc)
 
if exist('outputs')
for l=1:numel(net.layers)
outputs{l,1}=apply_layer(input,net.layers{l,1});
input=outputs{l,1};
end

output_sizes=zeros(size(outputs,1),4);
for k=1:size(outputs,1)
    output_sizes(k,:)=size(outputs{k,1});
end

clear outputs;
end
input_shape=size(input);
%% fully connected layers
net.layers{1,1}=init_fc(100,input_shape,init_sigmoid(1));
input=apply_layer(input,net.layers{1,1});
input_shape=size(input);

net.layers{2,1}=init_fc(100,input_shape,init_sigmoid(1));

input=apply_layer(input,net.layers{2,1});
input_shape=size(input);

net.layers{3,1}=init_fc(10,input_shape,'none'); %%in mnist, there are 10 classes

%% generate layer names
net.names=cell(numel(net.layers),1);
types={'fc','conv','pool'};
typebins=zeros(numel(types),1);
for l=1:length(net.layers);
    indcell=strfind(types,net.layers{l,1}.type);
    binind=find(~cellfun(@isempty,indcell));
    typebins(binind,1)=typebins(binind,1)+1;
  net.names{l,1}=[net.layers{l,1}.type num2str(typebins(binind,1))];
end
%%
toc





