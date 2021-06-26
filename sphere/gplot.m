function [] = gplot( G, flag, obst, remain_obst )

% close all
oplot(obst, remain_obst); hold on;

x = G.x;
[cx, cy] = pt_drawer_pre(x);
scatter(cx, cy, 50, 'bo', 'filled');hold on;
n = 100;
if flag
    for i = 1 : G.n
        idx = G.idx{i};
        for j = 1 : length(idx)
            if idx(j) > i
                s = step(x(i,:), x(idx(j),:), n);
                [cx, cy] = pt_drawer_pre(s);
                plot(cx, cy, 'b-', 'LineWidth', 1.5); hold on;
            end
        end
    end
end

end



function s = step(x1, x2, n)

lambda = (0 : 1/n : 1)';

for i = 1 : size(x1,1)
    if abs(x1(i,2)-x2(i,2))>pi
        x2(i,2) = x2(i,2) - 2*pi;
    end
end

s = [(1-lambda)*x1(:,1)+lambda*x2(:,1), (1-lambda)*x1(:,2)+lambda*x2(:,2)];

end



