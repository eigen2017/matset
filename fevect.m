function [ Pfa,Pfd,Ea,Ed ] = fevect( a )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
a = a(1:floor(length(a)/128)*128);
[swa,swd] = swt(a,7,'db5');
Mfa = zeros(1,7);
Mfd = zeros(1,7);
Pfa = zeros(1,7);
Pfd = zeros(1,7);
for i = 1:7
  Fa = pwelch(swa(i,:) );
  Fd = pwelch(swd(i,:));
  Mfa(i) = max(Fa);
  Mfd(i) = max(Fd);
  Pfa(i) = Mfa(i)/sum(Fa);
  Pfd(i) = Mfd(i)/sum(Fd);
end

% for i = 1:7
%     Mfa(i) = max(Fa(i,:));
%     Mfd(i) = max(Fd(i,:));
% end
% for i = 1:7
%     Pfa(i) = Mfa(i)/sum(Fa(i,:));
%     Pfd(i) = Mfd(i)/sum(Fd(i,:));
% end
%求对数熵
tempa = zeros(7,length(a));
tempd = zeros(7,length(a));
Ea = zeros(1,7);
Ed = zeros(1,7);
for i = 1:7
    for j = 1:length(a)
        tempa(i,j) = swa(i,j) * swa(i,j);
        tempd(i,j) = swd(i,j) * swd(i,j);
    end
   tempa1 = 0;
   tempd1 = 0;
   for j = 1:length(a)
       tempa1 = tempa1 + log(tempa(i,j));
       tempd1 = tempd1 + log(tempd(i,j));
   end
   Ea(i) = tempa1;
   Ed(i) = tempd1;
end
       

end

