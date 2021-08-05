addpath .\function
load testData.mat;
% c2l=xlsread('c2l.xls');
veloc=testData(:,9:10);
prediction=[];
fp=[];
k=5;
for i=1:size(testData,1)
    matrix=spt(i,:); % 3 portionID with strongest strength
    % pick data
    [ffp,dsptr]=datapick(trainData,sptr,matrix);
    if size(ffp)>=1
        [dfp,tsptr]=datapick(ffp,dsptr,matrix);
        if size(dfp)>=1
            [tfp,~]=datapick(dfp,tsptr,matrix);
            if size(tfp)>=1
                fp=tfp;
            else
                fp=dfp;
            end
        else
            fp=ffp;
        end
    else
        fp=trainData;
    end
     rr2tr=sqrt(sum((fp(:,1:8)-repmat(testData(i,1:8),size(fp, 1),1)).^2, 2));
%      [~, I] = sort(rr2tr);
%      if size(fp,1)>=k
%          prediction=[prediction;mean(fp(I(1:k), 9:10))];
%      else
%          prediction=[prediction;mean(fp(I(1:size(fp,1)), 9:10))];
%      end
     [w, I] = sort(rr2tr);
     if size(fp,1)>=k
         nw=flipud(w(1:k,1))./sum(w(1:k,1));
         prediction=[prediction;sum(fp(I(1:k), 9:10).*nw,1)];
     else
         nw=flipud(w(1:size(fp,1),1))./sum(w(1:size(fp,1),1));
         prediction=[prediction;sum(fp(I(1:size(fp,1)), 9:10).*nw,1)];
     end
end
clear i




error=[];
for i=1:size(prediction,1)
    er_lon=(prediction(i,2)-testData(i,10))*((40000/360)*1000*cosd(testData(i,9)));
    er_lat=(prediction(i,1)-testData(i,9))*((40000/360)*1000);
    er=sqrt(er_lon^2+er_lat^2);
    error=[error;er];
end
mean(error)
figure
cdfplot(error)
