function [ y ] = sigmoid( x,alpha )
%UNT�TLED5 Summary of this function goes here
%   Detailed explanation goes here

y=(1+exp(-alpha*x))^(-1);
end

