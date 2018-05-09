krondelta1 = zeros(128,1);
krondelta1(60) = 1;
krondelta2 = zeros(128,1);
krondelta2(64) = 1;
J = 3;
dwt1 = dddtree('dwt',krondelta1,J,'sym7');
dwt2 = dddtree('dwt',krondelta2,J,'sym7');
dwt1Cfs = dwt1.cfs{J};
dwt2Cfs = dwt2.cfs{J};

dt1 = dddtree('cplxdt',krondelta1,J,'dtf3');
dt2 = dddtree('cplxdt',krondelta2,J,'dtf3');

dt1Cfs = dt1.cfs{J}(:,:,1) + 1i*dt1.cfs{J}(:,:,2);
dt2Cfs = dt2.cfs{J}(:,:,1) + 1i*dt2.cfs{J}(:,:,2);

figure
subplot(121)
stem(abs(dwt1Cfs),'markerfacecolor',[0 0 1]);
title(['DWT Squared 2-norm = ' num2str(norm(dwt1Cfs,2)^2,3)],'fontsize',10);
subplot(122)
stem(abs(dwt2Cfs),'markerfacecolor',[0 0 1]);
title(['DWT Squared 2-norm = ' num2str(norm(dwt2Cfs,2)^2,3)],'fontsize',10);
figure
subplot(121)
stem(abs(dt1Cfs),'markerfacecolor',[0 0 1]);
title(['DWT Squared 2-norm = ' num2str(norm(dt1Cfs,2)^2,3)],'fontsize',10);
subplot(122)
stem(abs(dt2Cfs),'markerfacecolor',[0 0 1]);
title(['DWT Squared 2-norm = ' num2str(norm(dt2Cfs,2)^2,3)],'fontsize',10);
