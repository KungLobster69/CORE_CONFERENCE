function V = sgPFCMed_InitV (X,c)
rad=randperm(size(X,1),c);
for i=1:c
    V{i,1}=X{rad(i),1};%initial cluster centers
end
end