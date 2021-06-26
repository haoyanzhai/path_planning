clear
clc
close all

a = [1,2]
b = [3,4;4,5]

result = bsxfun(@f, repmat(a, 2, 1), b);


%%
pplot(path(10:10+1,:), [], []);