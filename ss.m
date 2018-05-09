clc
syms z;
z=0:0.001:0.5;
A0=2.25*10^(-5);
alpha=10.5;
R=287.06;
T0=300;
rhog=1.78;
p0=2.5*10^5;
gama=1.4;
lamda=alpha*sqrt(A0);
i=1;
while p0>=1.5*10^5
Jg=A0*p0*sqrt(gama*(2/(gama+1))^((gama+1)/(gama-1))/(R*T0));
u0=Jg/(rhog*A0);
ug=u0*(1+(z/lamda).^20).^(-0.05);
plot(z,ug)
xlswrite(num2str(i).xlsx,[z,ug]); 
hold on
p0=p0-0.25*10^5;
i=i+1;
end
xlabel('Distance x/m');
ylabel('Velocity of gas v/ (m/s)');
