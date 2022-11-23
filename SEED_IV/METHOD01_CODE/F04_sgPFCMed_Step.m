function [V, U, T, E] = sgPFCMed_Step(X, V, c, m, eta,a,b,G)
%
%sgPFCMed_Step One step in string grammar fuzzy-possibilistic c-medians clustering.
%

n = size (X, 1);
% fill the distance matrix
for k=1:n
    for i=1:c
        D(i,k)=F01_EditDistance(X{k,:},V{i,1});
    end
end
dist=D;

% calculate new U, suppose m != 1
tmp = dist.^(-1/(m-1));
U = tmp./(ones(c, 1)*sum(tmp));

% Correct the situation of "singularity" (one of the data points is
% exactly the same as one of the cluster centers).
si = find (tmp == Inf);
U(si) = 1;
if (size (si, 1) > c)
    display ('sgPFCMed, Warning: Singularity occured and corrected.');
end

% calculate new T, suppose eta != 1
eta = eta(:);
tmp=b*dist/G;

tmp = tmp.^(1/(eta-1));
T = 1 ./ (1 + tmp);



% Correct the situation of "singularity" (one of the data points is
% exactly the same as one of the cluster centers).
T(si) = 1; % Do more later

% new center
V_old = V;
Us = U.^m;
Ts = T.^eta;
maxU = max(U);
for i=1:c
    ed = [];
    index = find(U(i,:)== maxU);
    
    if ~isempty(index)
        for p=1:length(index)
            dataP=X(index(p),:);
            %dataP=data{index(p)};
            maxU(index(p))=5;
            nn=0;
            for q=1:n
                dataQ=X(q);
                ed(p,q)=(Us(i,index(p))+Ts(i,index(p)))*F01_EditDistance(dataP{1},dataQ{1});
                nn=nn+ed(p,q);
            end
            dists(p)=nn;
        end
        [B,I]=min(dists);
        q=index(I);
        po(i)=q;
        Vnew(i,:)=X(q,:);
        clear dists index
    end
end

V=Vnew;


E = 0;
for i = 1:c
    Dis = F01_EditDistance(V{i},V_old{i});
    E = E+Dis;
end

