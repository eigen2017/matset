
rec_index=[2,3,5,7];

need_del_indexs=[];
idx_need_del_indexs=1;

index=1;
for m=1:length(cnnpart(:,5))
    if(cnnpart(m,5121) == person)
        yesyes=0;
        for nn=1:length(rec_index)
            if (index == rec_index(nn))
                yesyes=1;
                break;
            end
        end
        if (yesyes ==1)
            need_del_indexs(idx_need_del_indexs) = m;
            idx_need_del_indexs=idx_need_del_indexs+1;
        end
        index=index+1;
    end
end

xxx=length(need_del_indexs);

for m=xxx:-1:1
      cnnpart(need_del_indexs(m),:) = [];
end
      
clear xxx;
clear rec_index;
clear index;
clear nn;
clear m;
clear yesyes;
clear need_del_indexs;
clear idx_need_del_indexs;
lab=csvdata(:,5041);
newlab=zeros(1,3307);
newlab(1)=1;
for i=2:3307
    if lab(i)==lab(i-1)
        newlab(i)=newlab(i-1);
    else
        newlab(i)=newlab(i-1)+1;
    end
end

cnt = 1;
for i = 1:2573
    for j =1:30
        train = dataforcnn(1+(j-1)*168:j*168);
        train_label = dataforcnn(i,5041);
        all_cnn(cnt,:) = [train train_label];
        cnt = cnt + 1;
    end
end
        
