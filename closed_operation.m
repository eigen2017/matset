function output = closed_operation( f,g,N,M )
%fΪԭ�źţ�gΪ�ṹԪ�أ�
%NΪԭ�źų��ȣ�MΪ�ṹԪ�صĳ���
%outputΪ������
%fpg=zeros(size(f));
%fg1=zeros(size(g));
for i=1:N
    for j=1:M
         if i-j>=0
           % if i-j>0
            
            fg1(j)=f(i-j+1)+g(j);
%             else
%                 fg1(j)=f(1)+g(j);
          %  end
         end
    end
    fpg(i)=max(fg1);
    fg1=[];
end
%f+g-g
%output=zeros(size(f));
%fg12=zeros(size(g));
for i=1:N
    for j=1:M
       if( i+j<=N+1)
%             
%             fg12(j)=fpg(i+j+1)-g(j);
        %if (i+j<=N)
%             if(i+j==2)
%                  fg12(j)=fpg(1)-g(j);
%             else
              fg12(j)=fpg(i+j-1)-g(j);
%             end
        end
    end
    output(i)=min(fg12);
    fg12=[];
end
end