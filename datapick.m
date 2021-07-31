function [fp,dsptr]=data_pick(data,sptr,matrix)

fp=[];
dsptr=[];
for i=1:size(data,1)
    if ifinf(sptr(i,1),matrix)
        fp=[fp;data(i,:)]; % data
        a=size(sptr,2)-1;  % strength order
        b=size(sptr,2);
        if b==5
            dsptr=[dsptr;sptr(i,a-2:b)];
        elseif b==4
            dsptr=[dsptr;sptr(i,a-1:b)];
        elseif b==3
            dsptr=[dsptr;sptr(i,a:b)];
        elseif b==2
            dsptr=[dsptr;sptr(i,b)];
        end
%         if b>2
%             dsptr=[dsptr;sptr(i,a:b)];
%         else
%             dsptr=[dsptr;sptr(i,b)];
%         end
            
    end


end
end