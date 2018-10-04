%% dataset
addpath('MnistHelper/');
train_labels=loadMNISTLabels('train-labels.idx1-ubyte');
train_images=loadMNISTImages('train-images.idx3-ubyte');
test_labels=loadMNISTLabels('t10k-labels.idx1-ubyte');
test_images=loadMNISTImages('t10k-images.idx3-ubyte');




%% training params
batch_size=100;
wlrate=1e-4;
blrate=1e-4;
momentum=0.8;
max_iters = 1000;

%% mean subtraction
% for i=1:size(image,1)
%     for j=1:size(image,2)
% image(i,j,:)=image(i,j,:)-mean(mean(image));
%     end
% end
%%
%layer=init_fc(3000,size(input));

netdef;
num_layers = length(net.layers);



%% forward and backpropagation (training)

current_update_b=cell(num_layers,1);
for layer=1:num_layers;
    current_update_b{layer,1}=zeros(size(net.layers{layer}.bias));
end
empty_label=zeros(10,1); %%in mnist, there are 10 classes
batch_errors=zeros(size(net.layers{num_layers}.bias,1),batch_size);
batch_losses=zeros(batch_size,1);

figure;
iters = [];
iter_losses = [];

for iteration=1:max_iters;

    
    image_inds=randperm(size(train_images,2),batch_size); %%random batch

    for imind=1:batch_size;

        input_image=train_images(:,image_inds(imind));
        layer_inputs{1}=input_image;

        digitlabel=train_labels(image_inds(imind));
        label=empty_label;
        label(digitlabel+1)=1;


        for l=1:numel(net.layers)

            layer_inputs{1+l}=apply_layer(layer_inputs{l},net.layers{l,1});

        end

        [backerr,loss,losstype]=l2loss(label,layer_inputs{1+numel(net.layers)}); %%loss

        batch_errors(:,imind)=backerr;
        batch_losses(imind,1)=loss;
    end
    
    batch_loss=sum(batch_losses)/batch_size;
    backerr=sum(batch_errors,2)/batch_size;

    [net.layers{num_layers,1},backerr,current_update_b{num_layers,1}]=...
        bprop_fc(backerr,1,layer_inputs{numel(net.layers)+1},layer_inputs{numel(net.layers)},...
        net.layers{numel(net.layers)},blrate,wlrate,momentum,current_update_b{num_layers,1});

    for j=2:numel(net.layers);
        [net.layers{numel(net.layers)-j+1,1},backerr,current_update_b{numel(net.layers)-j+1,1}]=...
            bprop_fc(backerr,net.layers{numel(net.layers)-j+2}.weights,layer_inputs{numel(net.layers)-j+2},layer_inputs{numel(net.layers)-j+1},...
            net.layers{numel(net.layers)-j+1},blrate,wlrate,momentum,current_update_b{numel(net.layers)-j+1,1});
    end

    iters(iteration)=iteration;
    iter_losses(iteration)=batch_loss;
    plot(iter_losses,'b')
    title('Training Loss vs Iteration')
    xlabel('Iteration')
    ylabel('Tr. Loss')
     drawnow;
     hold on
end




%% forward propagation(inference) /test
image_index=8349;
layer_inputs=cell(num_layers+1,1);
layer_inputs{1}=test_images(:,image_index);
true_label=test_labels(image_index)
%label=[1 0 0 0 0]';

num_layers=numel(net.layers);

for l=1:num_layers
    
layer_inputs{1+l}=apply_layer(layer_inputs{l},net.layers{l,1});

end
network_output=layer_inputs{1+num_layers};
[~,prediction]=max(softmax(network_output));
prediction=prediction-1









