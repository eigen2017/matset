function output = open_operation( f,g,N,M )
%f为原信号，g为结构元素，
%N为原信号长度，M为结构元素的长度
%output为输出结果
%fmg=zeros(size(f));
%fg=zeros(size(g));
for i=1:N
    for j=1:M
        if i+j<=N+1
%             if(i+j==2)
%                 fg(j)=f(1)-g(j);
%             else
            fg(j)=f(i+j-1)-g(j);
%            end
        end
    end
    fmg(i)=min(fg);
    fg=[];
end
% f关于g的开运算f-g+g=fmg+g
%output=zeros(size(f));
%fg11=zeros(size(g));
for i=1:N
    for j=1:M
         if i-j>=0
           % if i-j>0
                fg11(j)=fmg(i-j+1)+g(j);
%             else
%                 fg11(j)=fmg(1)+g(j);
          %  end
         end
    end
    output(i)=max(fg11);
    fg11=[];
end
end


