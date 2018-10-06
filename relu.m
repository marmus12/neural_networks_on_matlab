function [ y ] = relu( x,leakparam )
%UNTİTLED5 Summary of this function goes here
%   Detailed explanation goes here

if x>=0
    y=x;
else
    y=leakparam*x;
end

