function f=dsigm(x,alpha)

f=(alpha*exp(-alpha*x))/(exp(-alpha*x) + 1)^2;

end
