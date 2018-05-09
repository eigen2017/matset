

person = 24;

cnnpart=a;

rows=9;




index=1;
for m=1:length(cnnpart(:,5))
    if(cnnpart(m,5121) == person)
        person_records{index}=cnnpart(m,1:5120);
        index=index+1;
    end
end

how_many_figure = ceil(length(person_records)/rows);

last_figure_subplot_num = mod(length(person_records), rows);

init_subindex = rows*100+10+1;

if(last_figure_subplot_num == 0)
    for m=1:how_many_figure
        figure;
        set(gcf,'position',get(0,'screensize'))
        subindex = init_subindex;
        for nn=1:rows
            subplot(subindex)
            plot(person_records{(m-1)*rows+nn})
            title((m-1)*rows+nn)
            subindex = subindex + 1;
        end
    end

else
    
    for m=1:how_many_figure-1
         figure;
         set(gcf,'position',get(0,'screensize'))
         subindex = init_subindex;
         for nn=1:rows
             subplot(subindex)
             plot(person_records{(m-1)*rows+nn})
             title((m-1)*rows+nn)
             subindex = subindex + 1;
         end
    end 
    
    m=how_many_figure;
    figure;
    set(gcf,'position',get(0,'screensize'))
    subindex = init_subindex;
    for nn=1:last_figure_subplot_num
        subplot(subindex)
        plot(person_records{(m-1)*rows+nn})
        title((m-1)*rows+nn)
        subindex = subindex + 1;
    end
    
end
    
clear how_many_figure;
clear index;
clear init_subindex;
clear last_figure_subplot_num;
clear m;
clear nn;
clear person_records;
clear rows;
clear subindex;




