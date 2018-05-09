function [Template,weight] = produceTemplate(sample)
NN = 256;
TemplateCandidate = zeros(30,NN);
for i = 1:30
    TemplateCandidate(i,1:NN) = sample((i-1)*NN+1:i*NN);
end
    
cosineDistace = pdist(TemplateCandidate, 'cosine');
MatrixDistance = squareform(cosineDistace);
SumDistance = sum(MatrixDistance,2);
OrderContribution = sort(SumDistance);
ContributionCnt = 0;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           for i = 30:-1:1
    ContributionCnt = ContributionCnt + OrderContribution(i);
    if(ContributionCnt/sum(OrderContribution) > 0.7)
        location = i;
        break;
    end
end
j = 1;
for i = 30:-1:location
    loca(j) = find(SumDistance == OrderContribution(i));
    j = j + 1;
end


Template = TemplateCandidate(loca,:);
fsc = SumDistance(loca);
for i =1:length(loca)
    temp = SumDistance(loca);
    weight(i) =  temp(i)/sum( temp);
end 
