function [result]=ifin(value,matrix)
result=0;
for i=1:size(matrix,2)
    if value==matrix(1,i)
        result=1;
    end
end
end
