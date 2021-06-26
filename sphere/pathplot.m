function [] = pathplot( path, obst, remain_obst )

close all
oplot(obst, remain_obst,1); hold on;

for i = 1 : length(path) - 1
    s = step(path(i,:), path(i+1,:), 100);
    [cx, cy] = pt_drawer_pre(s);
    plot(cx, cy, 'b-', 'LineWidth', 2.5); hold on;
%     plot([path(i, 1) path(i+1, 1)], [path(i, 2), path(i+1, 2)], 'b-', 'LineWidth',2.5); hold on;
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