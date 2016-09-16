function layer=init_fc(num_neurons,input_shape,nonlin);
% input_shape is a 1x3 array (elements can be 1).

layer=struct();
layer.num_neurons=num_neurons;
layer.type='fc';

layer.nonlin=nonlin;


layer.weights=randn(num_neurons,prod(input_shape));


layer.bias=randn(num_neurons,1);

