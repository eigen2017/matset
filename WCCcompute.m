function [WCC] = WCCcompute(Template,weight,Newsample)
WCC = 0;
for i= 1:length(weight)
    Comatric = corrcoef(Template(i,:),Newsample);
    WCC = WCC + weight(i) * Comatric(1,2);
end