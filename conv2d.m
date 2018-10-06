 function output=conv2d(input,filter,stride,pads,bias)

kernel=size(filter,1);
%figure
%imshow(imresize(filter,3*kernel.*[1,1]));
outsize(1)=(size(input,1)-kernel+2*pads(1))/stride+1;
outsize(2)=(size(input,2)-kernel+2*pads(2))/stride+1;

output=zeros(floor(outsize(1)),floor(outsize(2)));
p_input=zeros(size(input,1)+2*pads(1),size(input,2)+2*pads(2));
p_input((1:size(input,1))+pads(1),(1:size(input,2))+pads(2))=input;

for k=1:floor(outsize(1));
    for l=1:floor(outsize(2));
       insquare=p_input((1:kernel)+stride*(k-1),(1:kernel)+stride*(l-1));
       
       output(k,l)=sum(sum(insquare.*filter))+bias;
    end
end

%figure
%imshow(uint8(output/29));