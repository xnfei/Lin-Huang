addpath .\function
load testData.mat;
c2l=xlsread('c2l.xls');
prediction=[];
fp=[];
for i=1:size(testData,1)
    matrix=spt(i,:); % 3 portionID with strongest strength
    % pick data
    kfp=datapickup(trainData,sptr,matrix);
    if size(kfp)>=1
        fp=kfp;
    else
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
    end
     rr2tr=sqrt(sum((fp(:,1:8)-repmat(testData(i,1:8),size(fp, 1),1)).^2, 2));
     [~, I] = sort(rr2tr);
     prediction=[prediction;fp(I(1), 11)];
end

referc=testData(:,11);

count=0;
for i=1:size(prediction,1)
    if prediction(i,1)==referc(i,1)
        count=count+1;
    end
end
acc=count/size(prediction,1)

error=[];
for j=1:size(prediction,1)
    er_lon=(c2l(prediction(j),2)-c2l(referc(j),2))*((40000/360)*1000*cosd(c2l(referc(j),1)));
    er_lat=(c2l(prediction(j),1)-c2l(referc(j),1))*((40000/360)*1000);
    er=sqrt(er_lon^2+er_lat^2);
    error=[error,er];
end
mean(error)
cdfplot(error)