function convlayer=init_conv(kernel,stride,n_filters,pads,nonlin);

convlayer=struct();
convlayer.n_filters=n_filters;
convlayer.kernel=kernel;
convlayer.stride=stride;
convlayer.type='conv';
convlayer.pads=pads;
convlayer.weights=randn(convlayer.kernel,convlayer.kernel,convlayer.n_filters);
convlayer.bias=randn(convlayer.n_filters,1);
convlayer.nonlin=nonlin;

