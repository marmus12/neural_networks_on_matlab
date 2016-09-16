function mapout=apply_layer(mapin,layer)

num_in_ch=size(mapin,3);

if strcmp(layer.type,'conv');
num_filter=layer.n_filters;
mapout=zeros(floor((size(mapin,1)-layer.kernel+2*layer.pads(1))/layer.stride+1),...
    floor((size(mapin,2)-layer.kernel+2*layer.pads(2))/layer.stride+1),num_in_ch,num_filter);

for ch=1:num_in_ch;
    for filter_ind=1:num_filter;
mapout(:,:,ch,filter_ind)=conv2d(mapin(:,:,ch),layer.weights(:,:,filter_ind),layer.stride,layer.pads,layer.bias(filter_ind));
    end
end

elseif strcmp(layer.type,'fc')
%mapout=zeros(layer.num_neurons,1);
%layershape=size(layer.weights);

% for n=1:layer.num_neurons;
%     mapout(n,1)=sum(mapin(:)'.*layer.weights(n,:))+layer.bias(n);
% end
mapin=mapin(:);
mapout=layer.weights*mapin+layer.bias;   

elseif strcmp(layer.type,'pool')
    mapout=zeros(floor((size(mapin,1)-layer.kernel+2*layer.pads(1))/layer.stride+1),...
    floor((size(mapin,2)-layer.kernel+2*layer.pads(2))/layer.stride+1),num_in_ch);
for ch=1:num_in_ch;
    mapout(:,:,ch)=pool2d(mapin(:,:,ch),layer.kernel,layer.stride,layer.pads,layer.pooltype);
end
end



%% nonlinearity
mapin=mapout;

if isstruct(layer.nonlin)
if strcmp(layer.nonlin.type,'relu')
 leakparamvec=layer.nonlin.leakparam*ones(size(mapin));
       mapout=arrayfun(@relu, mapin,leakparamvec);
       
elseif strcmp(layer.nonlin.type,'sigmoid')
    alphavec=layer.nonlin.alpha*ones(size(mapin));
    mapout=arrayfun(@sigmoid, mapin,alphavec);
    
elseif strcmp(layer.nonlin.type,'softmax')
       mapout=softmax(mapin(:));
end
else
    %% do nothing if the nonlinearity layer is not a struct
end

end
