function dis=EditDistance(t,r)
%     ft=find(t1(1,:)==0);
% if ~isempty(ft)
%     t=t1(1,1:ft(1,1)-1);
% else
%     t=t1(1,:);
% end
% clear ft
%     ft=find(r1(1,:)==0);
% if ~isempty(ft)
%     r=r1(1,1:ft(1,1)-1);
% else
%     r=r1(1,:);
% end
n=0;
for i=1:size(r,2)+1
    D(i,1)=n;
    n=n+1;
end
n=1;
for i=2:size(t,2)+1
    D(1,i)=n;
    n=n+1;
end
for i=2:size(r,2)+1
    for j=2:size(t,2)+1
        dif=abs(r(1,i-1)-t(1,j-1));
        if(dif==0)
            w=0;
        else
            w=50;
        end
        D(i,j)=min([D(i-1,j-1)+w,D(i-1,j)+1,D(i,j-1)+1]);
    end
end
dis=D(size(r,2)+1,size(t,2)+1);
end