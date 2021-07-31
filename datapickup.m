function [fp]=data_pick(data,sptr,matrix)

fp=[];

for i=1:size(data,1)
    if sptr(i,1)==matrix(1) &  sptr(i,2)==matrix(2) & sptr(i,3)==matrix(3)
        fp=[fp;data(i,:)]; % data
    end


end
end