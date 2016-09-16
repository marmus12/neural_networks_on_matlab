function f=drelu(x,leakparam)

if x<=0
    f=leakparam;
else
    f=1;
end
end
