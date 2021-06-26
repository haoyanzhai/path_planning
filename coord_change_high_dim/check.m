ub = 0.2;
lb = 0.02;
for i = 1 : size(path, 1) - 1
    s = path(i, :); t = path(i+1, :);
    t
    for lambda = 0 : 0.1 : 1
        tmp = lambda*t + (1-lambda) * s;
        for j = 1 : 2 : size(tmp, 2) - 1
            for k = j : 2 : size(tmp, 2) - 1
                infeasible = block(tmp(j : j+1), tmp(k : k+1), obst);
                if infeasible
                    fprintf('fuck\n');
                    j
                    k
                end
            end
        end
%         y = reshape(tmp, 2, [])';
%         d = pdist2(y, y) + eye(size(y,1))*(ub+lb)/2;
%         dd = (d>ub) | (d<lb);
        
%         if ~isempty(find(dd,1))
%             fprintf('fuck\n');
%             i
%             s
%             t
%             lambda
%         end
    end
end


%%

xxx = [0.5500    0.3400    0.5300    0.2700    0.4650    0.2700    0.4450    0.3200    0.4100    0.3600];
o_pt = [0.5500   0.3400    0.5300    0.2700    0.4650    0.2700    0.4660    0.3200    0.4100    0.3600];
x = [0.4660    0.3200];
% from original to now is blocked
for i = 1 : 2 : size(o_pt, 2) - 1
    infeasible = block(o_pt(i : i+1), x, obst)
end

%%
close all
clear
clc
l = 0.02;
obst = [.5 .5 .1 1];
s = [.61 .4 .61 .6 .65 .5];
t = [.61 .4 .61-l .6 .65 .5];

xx = feasible(t, s, obst, 2, l, true, false);
xx
oplot(obst, []);
hold on;
y = reshape(t,2,[])';
plot(y(:,1),y(:,2));










