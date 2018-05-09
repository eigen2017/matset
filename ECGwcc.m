%clear all
%clc

%read data
a=load('F:ecgmatchAG\aa.csv');
%b=sortrows(a,15361);
%candidLoca = [1 6 11 13 19 28 36 41 47 50];
%candidLoca = [54 59 65 67 75 83 90 99 110 116];
candidLoca = [1 3 5 7 9];
TemplateTrain = a(candidLoca,1:7680);

%extract the templates for each class£¨10 classes£©
for i = 1:5
    sample  = TemplateTrain(i,:);
    [TemplateCell{i},weight{i}] =  produceTemplate(sample);
end
%New unknown sample 
Newsample = a(8,1:7680);
[NewTemplateCell,Newweight] =  produceTemplate(Newsample);
for i = 1:length(Newweight)
    for j = 1:length(TemplateCell)
        tt = WCCcompute(TemplateCell{j},weight{j},NewTemplateCell(i,:));
        Wcc(i,j) = tt;
    end
end
%statistics and find the true class the sample belongs to
classes = zeros(1,length(Newweight));
for i = 1:length(Newweight)
    [maxmean,classes(i)] = max(Wcc(i,:));
end
table=tabulate(classes);
[F,loc] = max(table(:,2));
I = find(table(:,2)==F);
FinalClass = table(I,1);























